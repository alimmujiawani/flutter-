import 'package:flutter/material.dart';
import 'package:flutter_ikbal/navigation/about_page.dart';

class ContohNav extends StatelessWidget {
  const ContohNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FF),
      appBar: AppBar(
        title: const Text('Menu Navigasi'),
        centerTitle: true,
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pilih materi',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Belajar Flutter dengan navigasi yang lebih rapi.',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF475569),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _menuButton(
                      icon: Icons.person_outline_rounded,
                      label: 'Pindah ke halaman about',
                      color: const Color(0xFF6366F1),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AboutPage(nama: 'sidik', kelas: 'xii', umur: 17);
                            },
                          ),
                        );
                      },
                    ),
                    _menuButton(
                      icon: Icons.photo_library_outlined,
                      label: 'Story James Boggie',
                      color: const Color(0xFF06B6D4),
                      onPressed: () {
                        Navigator.pushNamed(context, '/grid1');
                      },
                    ),
                    _menuButton(
                      icon: Icons.history_edu_outlined,
                      label: 'Sejarah Singkat James Boggie',
                      color: const Color(0xFF10B981),
                      onPressed: () {
                        Navigator.pushNamed(context, '/GridBuilder');
                      },
                    ),
                    _menuButton(
                      icon: Icons.grid_view_rounded,
                      label: 'Grid 11',
                      color: const Color(0xFFF59E0B),
                      onPressed: () {
                        Navigator.pushNamed(context, '/Latihan');
                      },
                    ),
                    _menuButton(
                      icon: Icons.apps_rounded,
                      label: 'Grid 12',
                      color: const Color(0xFFEF4444),
                      onPressed: () {
                        Navigator.pushNamed(context, '/GridBuilder');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _menuButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 22),
        label: Text(
          label,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: color,
          elevation: 0,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(color: color.withValues(alpha: 0.18), width: 1.2),
          ),
        ),
      ),
    );
  }
}
