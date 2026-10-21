import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _ink = Color(0xFF323538);
const _text = Color(0xFF38485B);
const _muted = Color(0xFF58677A);
const _background = Color(0xFFF0F6FF);

class Latihan extends StatefulWidget {
  const Latihan({super.key});

  @override
  State<Latihan> createState() => _LatihanState();
}

class _LatihanState extends State<Latihan> {
  final _linkController = TextEditingController();
  final _collectionsKey = GlobalKey();
  int _unsortedLinks = 1;

  static const _collections = [
    _Collection(
      'Must watch',
      57,
      Icons.bolt,
      Color(0xFF13CE44),
      Color(0xFF39E653),
    ),
    _Collection(
      'Learning & Research',
      24,
      Icons.menu_book_outlined,
      Color(0xFFE9D36D),
      Color(0xFFF5E8A4),
      folders: 2,
    ),
    _Collection(
      'Coffee & Chill Spots',
      7,
      Icons.coffee_outlined,
      Color(0xFF9CE51E),
      Color(0xFFBEF247),
    ),
    _Collection(
      'Travel plan',
      13,
      Icons.flight,
      Color(0xFFF05B9B),
      Color(0xFFF887B5),
    ),
    _Collection(
      'Weekend Recipes',
      7,
      Icons.favorite_border,
      Color(0xFF617DEB),
      Color(0xFF8DA4FF),
      isNew: true,
    ),
  ];

  @override
  void dispose() {
    _linkController.dispose();
    super.dispose();
  }

  Future<void> _pasteLink() async {
    final text = (await Clipboard.getData(Clipboard.kTextPlain))?.text;
    if (!mounted || text == null || text.isEmpty) return;

    _linkController.text = text;
    _linkController.selection = TextSelection.collapsed(offset: text.length);
  }

  void _saveLink() {
    final uri = Uri.tryParse(_linkController.text.trim());
    if (uri == null ||
        !uri.hasAuthority ||
        uri.host.isEmpty ||
        !['http', 'https'].contains(uri.scheme)) {
      _showMessage('Masukkan link yang valid, misalnya https://contoh.com');
      return;
    }

    setState(() => _unsortedLinks++);
    _linkController.clear();
    _showMessage('Link disimpan ke Unsorted');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _showSettings() {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pengaturan'),
        content: const Text('Atur koleksi link kamu di sini.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _searchCollections() {
    showSearch<void>(
      context: context,
      delegate: _CollectionSearch(_allCollectionNames),
    );
  }

  List<String> get _allCollectionNames => [
    'Unsorted',
    ..._collections.map((collection) => collection.name),
  ];

  @override
  Widget build(BuildContext context) {
    final collections = [
      _Collection(
        'Unsorted',
        _unsortedLinks,
        Icons.folder_outlined,
        const Color(0xFFB9C8E8),
        const Color(0xFFD9E2F6),
      ),
      ..._collections,
    ];

    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _SquareButton(
                        icon: Icons.settings_outlined,
                        label: 'Settings',
                        onPressed: _showSettings,
                      ),
                      const Spacer(),
                      _SquareButton(
                        icon: Icons.folder_open_outlined,
                        label: 'Go to collections',
                        onPressed: () {
                          final target = _collectionsKey.currentContext;
                          if (target != null) {
                            Scrollable.ensureVisible(
                              target,
                              duration: const Duration(milliseconds: 350),
                              curve: Curves.easeOut,
                            );
                          }
                        },
                      ),
                      const SizedBox(width: 12),
                      _SquareButton(
                        icon: Icons.search,
                        label: 'Search collections',
                        onPressed: _searchCollections,
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Save now.\nFind anytime.',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 38,
                      height: 1.02,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.2,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 62,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: _ink, width: 2.5),
                            borderRadius: BorderRadius.circular(13),
                            boxShadow: const [
                              BoxShadow(color: _ink, offset: Offset(3, 4)),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 14),
                                child: Text(
                                  '#',
                                  style: TextStyle(
                                    color: _ink,
                                    fontSize: 23,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _linkController,
                                  keyboardType: TextInputType.url,
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (_) => _saveLink(),
                                  decoration: const InputDecoration(
                                    hintText: 'Paste link to save',
                                    hintStyle: TextStyle(
                                      color: Color(0xFF728094),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                tooltip: 'Paste from clipboard',
                                onPressed: _pasteLink,
                                icon: const Icon(
                                  Icons.content_paste_go_rounded,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      _SquareButton(
                        icon: Icons.add,
                        label: 'Save link',
                        background: const Color(0xFFFFD900),
                        onPressed: _saveLink,
                        size: 62,
                        iconSize: 34,
                      ),
                    ],
                  ),
                  const SizedBox(height: 27),
                  Text(
                    'My Collections',
                    key: _collectionsKey,
                    style: const TextStyle(
                      color: Color(0xFF47566B),
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: collections.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 17,
                          childAspectRatio: 1.28,
                        ),
                    itemBuilder: (context, index) =>
                        _CollectionCard(collection: collections[index]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Collection {
  const _Collection(
    this.name,
    this.links,
    this.icon,
    this.color,
    this.tileColor, {
    this.folders,
    this.isNew = false,
  });

  final String name;
  final int links;
  final IconData icon;
  final Color color;
  final Color tileColor;
  final int? folders;
  final bool isNew;
}

class _CollectionCard extends StatelessWidget {
  const _CollectionCard({required this.collection});

  final _Collection collection;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 8,
          child: Container(
            width: 92,
            height: 22,
            decoration: BoxDecoration(
              color: collection.color,
              border: Border.all(color: _ink, width: 2.5),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
          ),
        ),
        Positioned(
          top: 12,
          left: 0,
          right: 4,
          bottom: 4,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FBFF),
              border: Border.all(color: _ink, width: 2.5),
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [BoxShadow(color: _ink, offset: Offset(4, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: collection.tileColor,
                        border: Border.all(color: _ink, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(collection.icon, color: _ink, size: 27),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${collection.links} links',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: _muted,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          if (collection.folders != null)
                            Text(
                              '${collection.folders} folders',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: _muted,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          if (collection.isNew)
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF05B83),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'NEW',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  collection.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: _text,
                    fontSize: 14,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SquareButton extends StatelessWidget {
  const _SquareButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.background = const Color(0xFFF9FBFF),
    this.size = 54,
    this.iconSize = 25,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color background;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: background,
          border: Border.all(color: _ink, width: 2.5),
          borderRadius: BorderRadius.circular(11),
          boxShadow: const [BoxShadow(color: _ink, offset: Offset(3, 4))],
        ),
        child: IconButton(
          tooltip: label,
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          icon: Icon(icon, color: _ink, size: iconSize),
        ),
      ),
    );
  }
}

class _CollectionSearch extends SearchDelegate<void> {
  _CollectionSearch(this.collections);

  final List<String> collections;

  @override
  String get searchFieldLabel => 'Search collections';

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(onPressed: () => query = '', icon: const Icon(Icons.close)),
  ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
    onPressed: () => close(context, null),
    icon: const Icon(Icons.arrow_back),
  );

  @override
  Widget buildResults(BuildContext context) => _buildList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context);

  Widget _buildList(BuildContext context) {
    final results = collections
        .where((name) => name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (results.isEmpty) {
      return const Center(child: Text('Koleksi tidak ditemukan'));
    }

    return ListView(
      children: [
        for (final name in results)
          ListTile(
            leading: const Icon(Icons.folder_outlined),
            title: Text(name),
            onTap: () {
              query = name;
              showResults(context);
            },
          ),
      ],
    );
  }
}
