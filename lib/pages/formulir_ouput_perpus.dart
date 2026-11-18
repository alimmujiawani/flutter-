import 'package:flutter/material.dart';

class HasilPerpusPage extends StatelessWidget {
  static const _forest = Color(0xFF246B52);
  static const _ink = Color(0xFF18352B);
  static const _muted = Color(0xFF64756D);
  static const _canvas = Color(0xFFF4F7F4);

  final String
  namaBuku,
  penerbit,
  kategoriBuku,
  tanggalDaftar,
  tanggalPinjam,
  tanggalKembali;

  const HasilPerpusPage({
    super.key,
    required this.namaBuku,
    required this.penerbit,
    required this.kategoriBuku,
    required this.tanggalDaftar,
    required this.tanggalPinjam,
    required this.tanggalKembali,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _canvas,
      appBar: AppBar(
        title: const Text('Hasil Pendaftaran'),
        centerTitle: true,
        backgroundColor: _forest,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [_forest, Color(0xFF368563)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(26),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 27,
                    backgroundColor: Color(0x33FFFFFF),
                    child: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Pendaftaran berhasil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 7),
                  Text(
                    'Informasi buku sudah tersimpan.',
                    style: TextStyle(
                      color: Color(0xFFD8E9E0),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE5ECE7)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A18352B),
                    blurRadius: 18,
                    offset: Offset(0, 7),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Detail buku',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Berikut ringkasan informasi yang didaftarkan.',
                    style: TextStyle(color: _muted, fontSize: 13),
                  ),
                  const SizedBox(height: 20),
                  _detailRow(
                    icon: Icons.menu_book_outlined,
                    text: 'Nama buku: $namaBuku',
                  ),
                  _detailRow(
                    icon: Icons.business_outlined,
                    text: 'Penerbit: $penerbit',
                  ),
                  _detailRow(
                    icon: Icons.category_outlined,
                    text: 'Kategori buku: $kategoriBuku',
                  ),
                  _detailRow(
                    icon: Icons.calendar_today_outlined,
                    text: 'Tanggal daftar: $tanggalDaftar',
                  ),
                  _detailRow(
                    icon: Icons.login_rounded,
                    text: 'Tanggal pinjam: $tanggalPinjam',
                  ),
                  _detailRow(
                    icon: Icons.assignment_return_outlined,
                    text: 'Tanggal kembali: $tanggalKembali',
                    last: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 52,
              child: OutlinedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_rounded),
                label: const Text('Kembali ke formulir'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: _forest,
                  side: const BorderSide(color: Color(0xFFC9D9CF)),
                  textStyle: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow({
    required IconData icon,
    required String text,
    bool last = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: last ? 0 : 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFEAF2EC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 19, color: _forest),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                text,
                style: const TextStyle(
                  color: _muted,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
