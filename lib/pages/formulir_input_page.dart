import 'package:flutter/material.dart';
import 'package:flutter_ikbal/pages/form_output_page.dart';

void main() => runApp(const MaterialApp(home: FormEkskul()));

class FormEkskul extends StatefulWidget {
  const FormEkskul({super.key});

  @override
  State<FormEkskul> createState() => _FormEkskulState();
}

class _FormEkskulState extends State<FormEkskul> {
  final _formKey = GlobalKey<FormState>();
  final _namaC = TextEditingController();
  final _emailC = TextEditingController();
  final _tanggalDaftarC = TextEditingController();
  late DateTime _tanggalDaftar;
  String? _ekskul;
  String _gender = 'Laki-laki';
  bool _setuju = false;

  @override
  void initState() {
    super.initState();
    _tanggalDaftar = DateUtils.dateOnly(DateTime.now());
    _tanggalDaftarC.text = _formatTanggal(_tanggalDaftar);
  }

  @override
  void dispose() {
    _namaC.dispose();
    _emailC.dispose();
    _tanggalDaftarC.dispose();
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
          builder: (_) => HasilPage(
            nama: _namaC.text,
            email: _emailC.text,
            ekskul: _ekskul!,
            gender: _gender,
            tanggalDaftar: _formatTanggal(_tanggalDaftar),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pendaftaran Ekskul')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _namaC,
                decoration: const InputDecoration(
                  labelText: 'Nama Lengkap',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Nama tidak boleh kosong';
                  if (v.length < 3) return 'Nama minimal 3 huruf';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailC,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Email tidak boleh kosong';
                  if (!v.contains('@')) return 'Format email tidak valid';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tanggalDaftarC,
                readOnly: true,
                onTap: _pilihTanggal,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Daftar',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today_outlined),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Pilih tanggal daftar';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _ekskul,
                decoration: const InputDecoration(
                  labelText: 'Pilih Ekskul',
                  border: OutlineInputBorder(),
                ),
                items: ['Pramuka', 'Robotik', 'Futsal', 'Rohis']
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (v) => setState(() => _ekskul = v),
                validator: (v) => v == null ? 'Pilih salah satu ekskul' : null,
              ),
              const SizedBox(height: 8),
              RadioListTile<String>(
                title: const Text('Laki-laki'),
                value: 'Laki-laki',
                groupValue: _gender,
                onChanged: (v) => setState(() => _gender = v!),
              ),
              RadioListTile<String>(
                title: const Text('Perempuan'),
                value: 'Perempuan',
                groupValue: _gender,
                onChanged: (v) => setState(() => _gender = v!),
              ),
              SwitchListTile(
                title: const Text('Saya setuju dengan tata tertib ekskul'),
                value: _setuju,
                onChanged: (v) => setState(() => _setuju = v),
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _kirim, child: const Text('Daftar')),
            ],
          ),
        ),
      ),
    );
  }
}
