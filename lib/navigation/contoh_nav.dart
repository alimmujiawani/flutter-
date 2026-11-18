import 'package:flutter/material.dart';
import 'package:flutter_ikbal/navigation/about_page.dart';
import 'package:flutter_ikbal/pages/album_page.dart';

class ContohNav extends StatelessWidget {
  const ContohNav({super.key});

  @override
  Widget build(BuildContext context) {
    const ink = Color(0xFF1E293B);
    const canvas = Color(0xFFF4F6FF);

    return Scaffold(
      backgroundColor: canvas,
      appBar: AppBar(
        title: const Text(
          'Kumpulan Project Iqbaal',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: canvas,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        flexibleSpace: Container(color: ink),
        leading: const Padding(
          padding: EdgeInsets.only(left: 16),
          child: Icon(Icons.auto_stories_rounded),
        ),
        leadingWidth: 56,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 22, 20, 32),
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF4338CA), Color(0xFF7C3AED)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x263B32B8),
                    blurRadius: 22,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: Stack(
                  children: [
                    Positioned(
                      top: -54,
                      right: -34,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.07),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -62,
                      right: 62,
                      child: Container(
                        width: 112,
                        height: 112,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.06),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'RUANG BELAJAR',
                                  style: TextStyle(
                                    color: Color(0xFFD8D5FF),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.4,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Halo, Iqbaal!\nMau belajar apa?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    height: 1.18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: 9),
                                Text(
                                  'Pilih project dan mulai bereksplorasi.',
                                  style: TextStyle(
                                    color: Color(0xFFE0E7FF),
                                    fontSize: 13,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 54,
                            height: 54,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.16),
                              borderRadius: BorderRadius.circular(19),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.2),
                              ),
                            ),
                            child: const Icon(
                              Icons.school_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Jelajahi project',
              style: TextStyle(
                color: ink,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Pilih salah satu untuk mulai menjelajah.',
              style: TextStyle(
                color: Color(0xFF64748B),
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            _menuButton(
              icon: Icons.person_outline_rounded,
              label: 'Tentang saya',
              subtitle: 'Kenali profil dan informasi singkat',
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
              icon: Icons.music_note_rounded,
              label: 'Aplikasi musik',
              subtitle: 'Jelajahi koleksi dan pemutar musik',
              color: const Color(0xFF65A30D),
              onPressed: () => Navigator.pushNamed(context, '/music'),
            ),
            _menuButton(
              icon: Icons.assignment_outlined,
              label: 'Pendaftaran ekskul',
              subtitle: 'Isi data untuk bergabung kegiatan',
              color: const Color(0xFF8B5CF6),
              onPressed: () => Navigator.pushNamed(context, '/form'),
            ),
            _menuButton(
              icon: Icons.local_library_outlined,
              label: 'Pendaftaran perpustakaan',
              subtitle: 'Daftarkan buku dan pilih kategorinya',
              color: const Color(0xFF1742B8),
              onPressed: () => Navigator.pushNamed(context, '/form_perpus'),
            ),
            _menuButton(
              icon: Icons.photo_library_outlined,
              label: 'Story James Boggie',
              subtitle: 'Lihat galeri cerita James Boggie',
              color: const Color(0xFF06B6D4),
              onPressed: () => Navigator.pushNamed(context, '/grid1'),
            ),
            _menuButton(
              icon: Icons.album_rounded,
              label: 'Album Page',
              subtitle: 'Ambil dan tampilkan data album',
              color: const Color(0xFF0891B2),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AlbumPage()),
                );
              },
            ),
            _menuButton(
              icon: Icons.history_edu_outlined,
              label: 'Sejarah James Boggie',
              subtitle: 'Pelajari kisah James Boggie',
              color: const Color(0xFF10B981),
              onPressed: () => Navigator.pushNamed(context, '/GridBuilder'),
            ),
            _menuButton(
              icon: Icons.grid_view_rounded,
              label: 'Grid 11',
              subtitle: 'Latihan tampilan grid',
              color: const Color(0xFFF59E0B),
              onPressed: () => Navigator.pushNamed(context, '/Latihan'),
            ),
            _menuButton(
              icon: Icons.apps_rounded,
              label: 'Grid 12',
              subtitle: 'Eksplorasi layout grid builder',
              color: const Color(0xFFEF4444),
              onPressed: () => Navigator.pushNamed(context, '/GridBuilder'),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _menuButton({
    required IconData icon,
    required String label,
    required String subtitle,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE8EAF2)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A1E293B),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.11),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(icon, size: 23, color: color),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: const TextStyle(
                          color: Color(0xFF1E293B),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 12,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 17,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
