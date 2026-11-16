import 'dart:typed_data';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const _background = Color(0xFF101210);
const _surface = Color(0xFF1B1E1B);
const _muted = Color(0xFF9A9F99);
const _accent = Color(0xFFB7F36B);

class MusicTrack {
  const MusicTrack({
    required this.title,
    required this.artist,
    required this.colors,
    required this.icon,
  });

  final String title;
  final String artist;
  final List<Color> colors;
  final IconData icon;
}

const _tracks = [
  MusicTrack(
    title: 'Midnight City',
    artist: 'Neon Valley',
    colors: [Color(0xFF5536A8), Color(0xFFE4779C)],
    icon: Icons.nightlight_round,
  ),
  MusicTrack(
    title: 'Golden Hour',
    artist: 'Mira Sol',
    colors: [Color(0xFFF2A65A), Color(0xFFD94F70)],
    icon: Icons.wb_twilight_rounded,
  ),
  MusicTrack(
    title: 'Slow Motion',
    artist: 'The Coastline',
    colors: [Color(0xFF236B73), Color(0xFF9AC7A2)],
    icon: Icons.waves_rounded,
  ),
  MusicTrack(
    title: 'Blue Weekend',
    artist: 'June Atlas',
    colors: [Color(0xFF274690), Color(0xFF65A7C9)],
    icon: Icons.water_rounded,
  ),
  MusicTrack(
    title: 'Afterglow',
    artist: 'Luna Park',
    colors: [Color(0xFF8A3D62), Color(0xFFE6A56B)],
    icon: Icons.blur_on_rounded,
  ),
  MusicTrack(
    title: 'Daydream',
    artist: 'Paper Skies',
    colors: [Color(0xFF4F7C61), Color(0xFFB7CF88)],
    icon: Icons.cloud_rounded,
  ),
];

class MusicHomePage extends StatefulWidget {
  const MusicHomePage({super.key});

  @override
  State<MusicHomePage> createState() => _MusicHomePageState();
}

class _MusicHomePageState extends State<MusicHomePage> {
  int _tabIndex = 0;
  int _filterIndex = 0;
  String _query = '';
  MusicTrack _currentTrack = _tracks.first;
  bool _isPlaying = false;
  final Set<String> _likedTracks = {_tracks[1].title, _tracks[4].title};
  final Map<String, Uint8List> _artworkByTrack = {};

  List<MusicTrack> get _visibleTracks {
    final tracks = _tabIndex == 2
        ? _tracks.where((track) => _likedTracks.contains(track.title)).toList()
        : _tracks;
    if (_query.trim().isEmpty) return tracks;
    final query = _query.toLowerCase();
    return tracks
        .where(
          (track) =>
              track.title.toLowerCase().contains(query) ||
              track.artist.toLowerCase().contains(query),
        )
        .toList();
  }

  void _playTrack(MusicTrack track) {
    setState(() {
      _currentTrack = track;
      _isPlaying = true;
    });
  }

  Future<void> _pickArtwork(MusicTrack track) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
      );
      if (image == null) return;

      final bytes = await image.readAsBytes();
      if (bytes.isEmpty) {
        throw Exception('File gambar kosong.');
      }
      if (!mounted) return;

      setState(() => _artworkByTrack[track.title] = bytes);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal mengganti gambar: $error')));
    }
  }

  Widget _coverArt({
    required MusicTrack track,
    required double size,
    required double radius,
  }) {
    return _CoverArt(
      track: track,
      size: size,
      radius: radius,
      imageBytes: _artworkByTrack[track.title],
    );
  }

  void _toggleLike(MusicTrack track) {
    setState(() {
      if (!_likedTracks.add(track.title)) {
        _likedTracks.remove(track.title);
      }
    });
  }

  void _openPlayer() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _NowPlayingSheet(
        track: _currentTrack,
        imageBytes: _artworkByTrack[_currentTrack.title],
        isPlaying: _isPlaying,
        isLiked: _likedTracks.contains(_currentTrack.title),
        onPlayPause: () => setState(() => _isPlaying = !_isPlaying),
        onLike: () => _toggleLike(_currentTrack),
        onPickArtwork: () => _pickArtwork(_currentTrack),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(child: _buildSelectedTab()),
            _buildMiniPlayer(),
            _buildNavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedTab() {
    if (_tabIndex == 1) return _buildSearchPage();
    if (_tabIndex == 2) return _buildLibraryPage();
    return _buildHomePage();
  }

  Widget _buildHomePage() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: _buildHomeHeader()),
        SliverToBoxAdapter(child: _buildFilters()),
        SliverToBoxAdapter(child: _buildQuickMixes()),
        SliverToBoxAdapter(
          child: _sectionTitle(
            'Made for your mood',
            'A little bit of everything',
          ),
        ),
        SliverToBoxAdapter(child: _buildFeaturedCard()),
        SliverToBoxAdapter(
          child: _sectionTitle('Recently played', 'Your latest favorites'),
        ),
        SliverToBoxAdapter(child: _buildTrackStrip(_tracks)),
        SliverToBoxAdapter(
          child: _sectionTitle('Fresh discoveries', 'New sounds for you'),
        ),
        SliverToBoxAdapter(child: _buildTrackStrip(_tracks.reversed.toList())),
        const SliverToBoxAdapter(child: SizedBox(height: 18)),
      ],
    );
  }

  Widget _buildHomeHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: const BoxDecoration(
              color: _accent,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.graphic_eq_rounded, color: _background),
          ),
          const SizedBox(width: 11),
          const Text(
            'soundwave',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => setState(() => _tabIndex = 1),
            icon: const Icon(Icons.search_rounded),
            tooltip: 'Cari musik',
          ),
          IconButton(
            onPressed: () => setState(() => _tabIndex = 2),
            icon: const Icon(Icons.account_circle_outlined),
            tooltip: 'Koleksi',
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    const filters = ['For you', 'Chill', 'Focus', 'Energy'];
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (context, index) => const SizedBox(width: 9),
        itemBuilder: (context, index) {
          final selected = _filterIndex == index;
          return ChoiceChip(
            label: Text(filters[index]),
            selected: selected,
            onSelected: (_) => setState(() => _filterIndex = index),
            backgroundColor: _surface,
            selectedColor: _accent,
            labelStyle: TextStyle(
              color: selected ? _background : Colors.white,
              fontWeight: FontWeight.w600,
            ),
            side: BorderSide.none,
            showCheckmark: false,
          );
        },
      ),
    );
  }

  Widget _buildQuickMixes() {
    final mixes = [
      ('Daily mix', _tracks[0]),
      ('Easy listening', _tracks[2]),
      ('New finds', _tracks[4]),
      ('On repeat', _tracks[1]),
    ];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: mixes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 9,
          crossAxisSpacing: 9,
          mainAxisExtent: 62,
        ),
        itemBuilder: (context, index) {
          final (title, track) = mixes[index];
          return Material(
            color: _surface,
            borderRadius: BorderRadius.circular(8),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: () => _playTrack(track),
              child: Row(
                children: [
                  _coverArt(track: track, size: 62, radius: 0),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sectionTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 25, 20, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: _muted, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard() {
    final track = _tracks[_filterIndex % _tracks.length];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: () => _playTrack(track),
        child: Container(
          height: 172,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [track.colors.first, track.colors.last],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Stack(
            children: [
              if (_artworkByTrack[track.title] case final imageBytes?)
                Positioned.fill(
                  child: Image.memory(imageBytes, fit: BoxFit.cover),
                )
              else
                Positioned(
                  right: -15,
                  bottom: -34,
                  child: Icon(track.icon, size: 180, color: Colors.white24),
                ),
              if (_artworkByTrack.containsKey(track.title))
                Positioned.fill(
                  child: ColoredBox(color: Colors.black.withValues(alpha: 0.3)),
                ),
              Padding(
                padding: const EdgeInsets.all(19),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'YOUR DAILY SOUNDTRACK',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.4,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      track.title,
                      style: const TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      track.artist,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: _accent,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: _background,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrackStrip(List<MusicTrack> tracks) {
    return SizedBox(
      height: 186,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: tracks.length,
        separatorBuilder: (context, index) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final track = tracks[index];
          return SizedBox(
            width: 136,
            child: InkWell(
              onTap: () => _playTrack(track),
              borderRadius: BorderRadius.circular(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _coverArt(track: track, size: 136, radius: 10),
                  const SizedBox(height: 9),
                  Text(
                    track.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    track.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: _muted, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchPage() {
    final tracks = _visibleTracks;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Search',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 18),
                TextField(
                  onChanged: (value) => setState(() => _query = value),
                  style: const TextStyle(color: _background),
                  decoration: InputDecoration(
                    hintText: 'Songs, artists, albums...',
                    hintStyle: const TextStyle(color: Color(0xFF59605A)),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: _background,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  _query.isEmpty ? 'Popular right now' : 'Search results',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (tracks.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                'Tidak ada musik yang cocok.',
                style: TextStyle(color: _muted),
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            sliver: SliverList.separated(
              itemCount: tracks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) => _buildTrackRow(tracks[index]),
            ),
          ),
      ],
    );
  }

  Widget _buildLibraryPage() {
    final likedTracks = _visibleTracks;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Your library',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() => _tabIndex = 1),
                  icon: const Icon(Icons.search_rounded),
                ),
                IconButton(
                  onPressed: () => setState(() => _likedTracks.clear()),
                  icon: const Icon(Icons.delete_outline_rounded),
                  tooltip: 'Hapus semua favorit',
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Text(
              '${likedTracks.length} liked songs',
              style: const TextStyle(color: _muted),
            ),
          ),
        ),
        if (likedTracks.isEmpty)
          const SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Text(
                'Musik favoritmu akan muncul di sini.',
                style: TextStyle(color: _muted),
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            sliver: SliverList.separated(
              itemCount: likedTracks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 8),
              itemBuilder: (context, index) =>
                  _buildTrackRow(likedTracks[index]),
            ),
          ),
      ],
    );
  }

  Widget _buildTrackRow(MusicTrack track) {
    final isLiked = _likedTracks.contains(track.title);
    return Material(
      color: _surface,
      borderRadius: BorderRadius.circular(10),
      child: ListTile(
        onTap: () => _playTrack(track),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        leading: _coverArt(track: track, size: 48, radius: 6),
        title: Text(
          track.title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(track.artist, style: const TextStyle(color: _muted)),
        trailing: IconButton(
          onPressed: () => _toggleLike(track),
          icon: Icon(
            isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
            color: isLiked ? _accent : _muted,
          ),
        ),
      ),
    );
  }

  Widget _buildMiniPlayer() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 8, 7),
      child: Material(
        color: const Color(0xFF303630),
        borderRadius: BorderRadius.circular(9),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _openPlayer,
          child: SizedBox(
            height: 60,
            child: Row(
              children: [
                const SizedBox(width: 8),
                _coverArt(track: _currentTrack, size: 44, radius: 5),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _currentTrack.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        _currentTrack.artist,
                        style: const TextStyle(color: _muted, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _toggleLike(_currentTrack),
                  icon: Icon(
                    _likedTracks.contains(_currentTrack.title)
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: _likedTracks.contains(_currentTrack.title)
                        ? _accent
                        : Colors.white,
                    size: 21,
                  ),
                ),
                IconButton(
                  onPressed: () => setState(() => _isPlaying = !_isPlaying),
                  icon: Icon(
                    _isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    size: 27,
                  ),
                ),
                const SizedBox(width: 4),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationBar() {
    const items = [
      (Icons.home_filled, 'Home'),
      (Icons.search_rounded, 'Search'),
      (Icons.library_music_rounded, 'Library'),
    ];
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF080908),
        border: Border(top: BorderSide(color: Color(0xFF242724))),
      ),
      child: NavigationBar(
        height: 66,
        backgroundColor: const Color(0xFF080908),
        indicatorColor: Colors.transparent,
        selectedIndex: _tabIndex,
        onDestinationSelected: (index) {
          setState(() {
            _tabIndex = index;
            _query = '';
          });
        },
        destinations: [
          for (var index = 0; index < items.length; index++)
            NavigationDestination(
              icon: Icon(items[index].$1),
              selectedIcon: Icon(items[index].$1, color: _accent),
              label: items[index].$2,
            ),
        ],
      ),
    );
  }
}

class _CoverArt extends StatelessWidget {
  const _CoverArt({
    required this.track,
    required this.size,
    required this.radius,
    required this.imageBytes,
  });

  final MusicTrack track;
  final double size;
  final double radius;
  final Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.isFinite ? size : null,
      height: size.isFinite ? size : null,
      decoration: BoxDecoration(
        gradient: imageBytes == null
            ? LinearGradient(
                colors: track.colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        image: imageBytes == null
            ? null
            : DecorationImage(
                image: MemoryImage(imageBytes!),
                fit: BoxFit.cover,
              ),
        borderRadius: BorderRadius.circular(radius),
      ),
      child: imageBytes == null
          ? LayoutBuilder(
              builder: (context, constraints) => Icon(
                track.icon,
                size: constraints.maxWidth * 0.48,
                color: Colors.white70,
              ),
            )
          : null,
    );
  }
}

class _NowPlayingSheet extends StatelessWidget {
  const _NowPlayingSheet({
    required this.track,
    required this.imageBytes,
    required this.isPlaying,
    required this.isLiked,
    required this.onPlayPause,
    required this.onLike,
    required this.onPickArtwork,
  });

  final MusicTrack track;
  final Uint8List? imageBytes;
  final bool isPlaying;
  final bool isLiked;
  final VoidCallback onPlayPause;
  final VoidCallback onLike;
  final VoidCallback onPickArtwork;

  @override
  Widget build(BuildContext context) {
    final artworkSize = math.min(
      320.0,
      math.min(
        MediaQuery.sizeOf(context).width - 48,
        MediaQuery.sizeOf(context).height * 0.38,
      ),
    );
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.92,
      padding: EdgeInsets.fromLTRB(
        24,
        14,
        24,
        MediaQuery.viewPaddingOf(context).bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF202520),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 26),
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.keyboard_arrow_down_rounded),
                ),
                const Expanded(
                  child: Column(
                    children: [
                      Text(
                        'NOW PLAYING',
                        style: TextStyle(
                          color: _muted,
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.5,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        'Your mix',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_horiz_rounded),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Stack(
              children: [
                SizedBox(
                  width: artworkSize,
                  height: artworkSize,
                  child: _CoverArt(
                    track: track,
                    size: artworkSize,
                    radius: 14,
                    imageBytes: imageBytes,
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: FilledButton.tonalIcon(
                    key: const Key('changeArtworkButton'),
                    onPressed: onPickArtwork,
                    icon: const Icon(Icons.edit_rounded, size: 17),
                    label: const Text('Ganti gambar'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        track.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(track.artist, style: const TextStyle(color: _muted)),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: onLike,
                  icon: Icon(
                    isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: isLiked ? _accent : Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            const LinearProgressIndicator(
              value: 0.36,
              minHeight: 4,
              backgroundColor: Color(0xFF454A45),
              color: _accent,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('1:12', style: TextStyle(color: _muted, fontSize: 11)),
                  Text('3:24', style: TextStyle(color: _muted, fontSize: 11)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shuffle_rounded, color: _accent),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.skip_previous_rounded, size: 34),
                ),
                IconButton.filled(
                  onPressed: onPlayPause,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: _background,
                  ),
                  icon: Icon(
                    isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    size: 35,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.skip_next_rounded, size: 34),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.repeat_rounded, color: _accent),
                ),
              ],
            ),
            const SizedBox(height: 22),
            const Row(
              children: [
                Icon(Icons.devices_rounded, color: _accent, size: 18),
                SizedBox(width: 8),
                Text(
                  'Listening on this device',
                  style: TextStyle(color: _muted, fontSize: 12),
                ),
                Spacer(),
                Icon(Icons.queue_music_rounded, color: _muted),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
