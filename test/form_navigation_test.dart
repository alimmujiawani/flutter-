import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ikbal/main.dart';
import 'package:flutter_ikbal/pages/album_page.dart';
import 'package:flutter_ikbal/pages/form_perpus_input.dart';
import 'package:flutter_ikbal/pages/formulir_input_page.dart';

void main() {
  testWidgets('opens the album page from the main menu', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final albumMenuItem = find.text('Album Page');
    await tester.drag(find.byType(ListView).last, const Offset(0, -250));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      albumMenuItem,
      100,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(albumMenuItem);
    await tester.pumpAndSettle();

    expect(find.byType(AlbumPage), findsOneWidget);
    expect(find.text('Fetch Data Example'), findsOneWidget);
  });

  testWidgets('opens the extracurricular form from the main menu', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final formMenuItem = find.text('Pendaftaran ekskul');
    expect(formMenuItem, findsOneWidget);

    await tester.ensureVisible(formMenuItem);
    await tester.tap(formMenuItem);
    await tester.pumpAndSettle();

    expect(find.text('Pendaftaran Ekskul'), findsOneWidget);
    expect(find.text('Nama Lengkap'), findsOneWidget);
  });

  testWidgets('opens the library registration form from the main menu', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    final formMenuItem = find.text('Pendaftaran perpustakaan');
    await tester.drag(find.byType(ListView).last, const Offset(0, -250));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      formMenuItem,
      100,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(formMenuItem);
    await tester.pumpAndSettle();

    expect(find.text('Pendaftaran Perpustakaan'), findsOneWidget);
    expect(find.text('Pilih Kategori Buku'), findsOneWidget);
    expect(
      find.text('Klik untuk menyetujui tata tertib perpustakaan'),
      findsOneWidget,
    );
  });

  testWidgets('submits a library book with its category and date', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: FormPerpusInput()));

    await tester.enterText(find.byType(TextFormField).at(0), 'Laskar Pelangi');
    await tester.enterText(find.byType(TextFormField).at(1), 'Andrea Hirata');

    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fiksi').last);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(SwitchListTile));
    await tester.ensureVisible(find.text('Daftar'));
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle();

    expect(find.text('Nama buku: Laskar Pelangi'), findsOneWidget);
    expect(find.text('Penerbit: Andrea Hirata'), findsOneWidget);
    expect(find.text('Kategori buku: Fiksi'), findsOneWidget);
    expect(find.textContaining('Tanggal daftar:'), findsOneWidget);
    expect(find.textContaining('Tanggal pinjam:'), findsOneWidget);
    expect(find.textContaining('Tanggal kembali:'), findsOneWidget);
  });

  testWidgets('requires a category and library rules agreement', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: FormPerpusInput()));

    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle();
    expect(find.text('Nama buku tidak boleh kosong'), findsOneWidget);
    expect(find.text('Nama penerbit tidak boleh kosong'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Laskar Pelangi');
    await tester.enterText(find.byType(TextFormField).at(1), 'Andrea Hirata');
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle();
    expect(find.text('Pilih kategori buku'), findsOneWidget);

    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Fiksi').last);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Daftar'));
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle();
    expect(find.text('Kamu harus menyetujui tata tertib'), findsOneWidget);
  });

  testWidgets('shows the book categories in the library form', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: FormPerpusInput()));
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    expect(find.text('Fiksi'), findsOneWidget);
    expect(find.text('Nonfiksi'), findsOneWidget);
    expect(find.text('Pendidikan'), findsOneWidget);
    expect(find.text('Referensi'), findsOneWidget);
  });

  testWidgets('selects and displays the registration date', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: FormEkskul()));

    await tester.enterText(find.byType(TextFormField).at(0), 'Budi Santoso');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'budi@example.com',
    );

    await tester.ensureVisible(find.byType(TextFormField).at(2));
    await tester.tap(find.byType(TextFormField).at(2));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    final tanggalField = tester
        .widgetList<TextFormField>(find.byType(TextFormField))
        .elementAt(2);
    final tanggalDaftar = tanggalField.controller!.text;

    await tester.ensureVisible(find.byType(DropdownButtonFormField<String>));
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pramuka').last);
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byType(SwitchListTile));
    await tester.tap(find.byType(SwitchListTile));
    await tester.ensureVisible(find.text('Daftar'));
    await tester.tap(find.text('Daftar'));
    await tester.pumpAndSettle();

    expect(find.text('Tanggal daftar: $tanggalDaftar'), findsOneWidget);
  });
}
