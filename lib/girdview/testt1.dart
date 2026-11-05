import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AutomotiveItem {
  const AutomotiveItem({
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.icon,
    required this.color,
  });

  final String name;
  final String category;
  final String description;
  final String price;
  final IconData icon;
  final Color color;
}

const automotiveProducts = <AutomotiveItem>[
  AutomotiveItem(
    name: 'Toyota GR Supra',
    category: 'Mobil sport',
    description: 'Coupe sport dengan performa tinggi dan desain agresif.',
    price: 'Rp 2,1 M',
    icon: Icons.directions_car,
    color: Color(0xFFE53935),
  ),
  AutomotiveItem(
    name: 'Honda Civic RS',
    category: 'Sedan',
    description: 'Sedan modern yang nyaman untuk harian dan perjalanan jauh.',
    price: 'Rp 718 Jt',
    icon: Icons.directions_car_filled,
    color: Color(0xFF42A5F5),
  ),
  AutomotiveItem(
    name: 'Yamaha NMAX',
    category: 'Skuter',
    description:
        'Skuter matik nyaman dengan bagasi luas untuk berkendara harian.',
    price: 'Rp 32,2 Jt',
    icon: Icons.two_wheeler,
    color: Color(0xFFFFB300),
  ),
  AutomotiveItem(
    name: 'Kawasaki Ninja',
    category: 'Motor sport',
    description:
        'Motor sport dengan posisi berkendara mantap dan tampilan tajam.',
    price: 'Rp 136 Jt',
    icon: Icons.two_wheeler,
    color: Color(0xFF66BB6A),
  ),
  AutomotiveItem(
    name: 'Ban Michelin',
    category: 'Ban kendaraan',
    description:
        'Ban dengan daya cengkeram baik untuk perjalanan lebih stabil.',
    price: 'Rp 1,8 Jt',
    icon: Icons.circle_outlined,
    color: Color(0xFFAB47BC),
  ),
  AutomotiveItem(
    name: 'Oli Shell Helix',
    category: 'Oli mesin',
    description:
        'Oli mesin untuk membantu menjaga performa dan kebersihan mesin.',
    price: 'Rp 185 Rb',
    icon: Icons.opacity,
    color: Color(0xFF26C6DA),
  ),
  AutomotiveItem(
    name: 'Aki GS Astra',
    category: 'Aki mobil',
    description:
        'Aki kendaraan untuk mendukung starter dan sistem kelistrikan.',
    price: 'Rp 950 Rb',
    icon: Icons.battery_charging_full,
    color: Color(0xFFFF7043),
  ),
  AutomotiveItem(
    name: 'Helm KYT',
    category: 'Perlengkapan',
    description:
        'Helm pelindung kepala untuk menemani perjalanan dengan motor.',
    price: 'Rp 780 Rb',
    icon: Icons.sports_motorsports,
    color: Color(0xFFEC407A),
  ),
];

typedef AutomotiveImagePicker = Future<Uint8List?> Function();

class AutomotiveProduct extends StatelessWidget {
  const AutomotiveProduct({super.key, this.pickImage});

  final AutomotiveImagePicker? pickImage;

  @override
  Widget build(BuildContext context) => GridBuilder(pickImage: pickImage);
}

class GridBuilder extends StatefulWidget {
  const GridBuilder({super.key, this.pickImage});

  final AutomotiveImagePicker? pickImage;

  @override
  State<GridBuilder> createState() => _GridBuilderState();
}

class _GridBuilderState extends State<GridBuilder> {
  final Map<String, Uint8List> _productImages = {};

  Future<void> _changeImage(AutomotiveItem product) async {
    try {
      final imageBytes = widget.pickImage == null
          ? await _pickImageFromGallery()
          : await widget.pickImage!();
      if (imageBytes == null || !mounted) return;

      setState(() => _productImages[product.name] = imageBytes);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gambar ${product.name} berhasil diubah')),
      );
    } on PlatformException catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.message ?? 'Gambar tidak dapat dipilih dari galeri.',
          ),
        ),
      );
    } on MissingPluginException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pemilih gambar tidak tersedia di platform ini.'),
        ),
      );
    }
  }

  Future<Uint8List?> _pickImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    return image?.readAsBytes();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF101114),
        colorScheme: ThemeData.dark().colorScheme.copyWith(
          primary: const Color(0xFFE53935),
          surface: const Color(0xFF1B1C20),
        ),
      ),
      child: ColoredBox(
        color: const Color(0xFF101114),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 4),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Katalog Otomotif',
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Ketuk ikon edit untuk mengganti gambar',
                          style: TextStyle(color: Colors.white60, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A1718),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${automotiveProducts.length} ITEM',
                      style: const TextStyle(
                        color: Color(0xFFFF6B6B),
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
                itemCount: automotiveProducts.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  final product = automotiveProducts[index];
                  final imageBytes = _productImages[product.name];

                  return Card(
                    color: const Color(0xFF1B1C20),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                      side: const BorderSide(color: Color(0xFF2B2C31)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => _showProductDetails(product),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 82,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(14),
                                    child: imageBytes == null
                                        ? ColoredBox(
                                            color: product.color.withValues(
                                              alpha: 0.13,
                                            ),
                                            child: Icon(
                                              product.icon,
                                              size: 44,
                                              color: product.color,
                                            ),
                                          )
                                        : Image.memory(
                                            imageBytes,
                                            fit: BoxFit.cover,
                                            gaplessPlayback: true,
                                          ),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: IconButton(
                                    tooltip: 'Ubah gambar ${product.name}',
                                    onPressed: () => _changeImage(product),
                                    style: IconButton.styleFrom(
                                      backgroundColor: Colors.black54,
                                      foregroundColor: Colors.white,
                                    ),
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              product.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                                height: 1.25,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Spacer(),
                            Text(
                              product.category.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.8,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              product.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              product.price,
                              style: const TextStyle(
                                color: Color(0xFFFF6B6B),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetails(AutomotiveItem product) {
    final imageBytes = _productImages[product.name];

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1B1C20),
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (imageBytes == null)
                    Icon(product.icon, size: 40, color: product.color)
                  else
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        imageBytes,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                product.category,
                style: const TextStyle(color: Colors.white60),
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                style: const TextStyle(color: Colors.white70, height: 1.4),
              ),
              const SizedBox(height: 6),
              Text(
                product.price,
                style: const TextStyle(
                  color: Color(0xFFFF6B6B),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
