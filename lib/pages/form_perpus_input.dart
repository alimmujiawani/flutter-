import 'package:flutter/material.dart';
import 'package:flutter_ikbal/pages/formulir_ouput_perpus.dart';

void main() => runApp(const MaterialApp(home: FormPerpusInput()));

class FormPerpusInput extends StatefulWidget {
  const FormPerpusInput({super.key});

  @override
  State<FormPerpusInput> createState() => _FormPerpusState();
}

class _FormPerpusState extends State<FormPerpusInput> {
  static const _forest = Color(0xFF246B52);
  static const _ink = Color(0xFF18352B);
  static const _canvas = Color(0xFFF4F7F4);

  final _formKey = GlobalKey<FormState>();
  final _namaBukuC = TextEditingController();
  final _penerbitC = TextEditingController();
  final _tanggalDaftarC = TextEditingController();
  final _tanggalPinjamC = TextEditingController();
  final _tanggalKembaliC = TextEditingController();
  late DateTime _tanggalDaftar;
  late DateTime _tanggalPinjam;
  late DateTime _tanggalKembali;
  String? _kategoriBuku;
  bool _setuju = false;

  @override
  void initState() {
    super.initState();
    _tanggalDaftar = DateUtils.dateOnly(DateTime.now());
    _tanggalDaftarC.text = _formatTanggal(_tanggalDaftar);
    _tanggalPinjam = _tanggalDaftar;
    _tanggalKembali = _tanggalPinjam.add(const Duration(days: 7));
    _tanggalPinjamC.text = _formatTanggal(_tanggalPinjam);
    _tanggalKembaliC.text = _formatTanggal(_tanggalKembali);
  }

  @override
  void dispose() {
    _namaBukuC.dispose();
    _penerbitC.dispose();
    _tanggalDaftarC.dispose();
    _tanggalPinjamC.dispose();
    _tanggalKembaliC.dispose();
    super.dispose();
  }

  String _formatTanggal(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  Future<void> _pilihTanggal() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: _tanggalDaftar,
      firstDate: DateTime(2000),
      lastDate: DateUtils.dateOnly(DateTime.now()),
    );
    if (tanggal == null) return;

    setState(() {
      _tanggalDaftar = DateUtils.dateOnly(tanggal);
      _tanggalDaftarC.text = _formatTanggal(_tanggalDaftar);
    });
  }

  Future<void> _pilihTanggalPinjam() async {
    final hariIni = DateUtils.dateOnly(DateTime.now());
    final tanggal = await showDatePicker(
      context: context,
      initialDate: _tanggalPinjam.isBefore(hariIni) ? hariIni : _tanggalPinjam,
      firstDate: hariIni,
      lastDate: DateTime(2100),
    );
    if (tanggal == null) return;

    setState(() {
      _tanggalPinjam = DateUtils.dateOnly(tanggal);
      _tanggalPinjamC.text = _formatTanggal(_tanggalPinjam);
      if (_tanggalKembali.isBefore(_tanggalPinjam)) {
        _tanggalKembali = _tanggalPinjam;
        _tanggalKembaliC.text = _formatTanggal(_tanggalKembali);
      }
    });
  }

  Future<void> _pilihTanggalKembali() async {
    final tanggal = await showDatePicker(
      context: context,
      initialDate: _tanggalKembali.isBefore(_tanggalPinjam)
          ? _tanggalPinjam
          : _tanggalKembali,
      firstDate: _tanggalPinjam,
      lastDate: DateTime(2100),
    );
    if (tanggal == null) return;

    setState(() {
      _tanggalKembali = DateUtils.dateOnly(tanggal);
      _tanggalKembaliC.text = _formatTanggal(_tanggalKembali);
    });
  }

  void _kirim() {
    if (_formKey.currentState!.validate()) {
      if (!_setuju) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kamu harus menyetujui tata tertib')),
        );
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HasilPerpusPage(
            namaBuku: _namaBukuC.text.trim(),
            penerbit: _penerbitC.text.trim(),
            kategoriBuku: _kategoriBuku!,
            tanggalDaftar: _formatTanggal(_tanggalDaftar),
            tanggalPinjam: _formatTanggal(_tanggalPinjam),
            tanggalKembali: _formatTanggal(_tanggalKembali),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _canvas,
      appBar: AppBar(
        title: const Text('Pendaftaran Perpustakaan'),
        centerTitle: true,
        backgroundColor: _forest,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFE5ECE7))),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                color: _canvas,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0xFFE5ECE7)),
                ),
                child: SwitchListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  activeThumbColor: _forest,
                  title: const Text(
                    'Klik untuk menyetujui tata tertib perpustakaan',
                    style: TextStyle(
                      color: _ink,
                      fontSize: 13,
                      height: 1.3,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  value: _setuju,
                  onChanged: (v) => setState(() => _setuju = v),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 54,
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _kirim,
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Daftar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _forest,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 16,
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
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [_forest, Color(0xFF368563)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(17),
                      ),
                      child: const Icon(
                        Icons.local_library_outlined,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'FORMULIR PERPUSTAKAAN',
                            style: TextStyle(
                              color: Color(0xFFD8E9E0),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Tambahkan buku baru',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
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
                      'Informasi buku',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                      controller: _namaBukuC,
                      textCapitalization: TextCapitalization.words,
                      decoration: _inputDecoration(
                        label: 'Masukan Nama Buku',
                        icon: Icons.menu_book_outlined,
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Nama buku tidak boleh kosong';
                        }
                        if (v.trim().length < 3) {
                          return 'Nama buku minimal 3 huruf';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _penerbitC,
                      textCapitalization: TextCapitalization.words,
                      decoration: _inputDecoration(
                        label: 'Masukan Nama Penerbit',
                        icon: Icons.business_outlined,
                      ),
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) {
                          return 'Nama penerbit tidak boleh kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      initialValue: _kategoriBuku,
                      decoration: _inputDecoration(
                        label: 'Pilih Kategori Buku',
                        icon: Icons.category_outlined,
                      ),
                      items: ['Fiksi', 'Nonfiksi', 'Pendidikan', 'Referensi']
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                      onChanged: (v) => setState(() => _kategoriBuku = v),
                      validator: (v) =>
                          v == null ? 'Pilih kategori buku' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _tanggalDaftarC,
                      readOnly: true,
                      onTap: _pilihTanggal,
                      decoration: _inputDecoration(
                        label: 'Tanggal Daftar',
                        icon: Icons.calendar_today_outlined,
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Pilih tanggal daftar';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _tanggalPinjamC,
                      readOnly: true,
                      onTap: _pilihTanggalPinjam,
                      decoration: _inputDecoration(
                        label: 'Tanggal Pinjam',
                        icon: Icons.login_rounded,
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Pilih tanggal pinjam';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _tanggalKembaliC,
                      readOnly: true,
                      onTap: _pilihTanggalKembali,
                      decoration: _inputDecoration(
                        label: 'Tanggal Kembali',
                        icon: Icons.assignment_return_outlined,
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return 'Pilih tanggal kembali';
                        }
                        return null;
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

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: _forest),
      filled: true,
      fillColor: const Color(0xFFFAFCFA),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 17),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFDCE6DF)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFFDCE6DF)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: _forest, width: 1.5),
      ),
    );
  }
}
