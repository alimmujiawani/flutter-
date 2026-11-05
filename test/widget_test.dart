import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_ikbal/girdview/guil_builder.dart';

void main() {
  test('the automotive catalog contains exactly eight products', () {
    expect(automotiveProducts, hasLength(8));
    expect(
      automotiveProducts.map((product) => product.name),
      containsAll([
        'Toyota GR Supra',
        'Honda Civic RS',
        'Yamaha NMAX',
        'Kawasaki Ninja',
        'Ban Michelin',
        'Oli Shell Helix',
        'Aki GS Astra',
        'Helm KYT',
      ]),
    );
    expect(
      automotiveProducts.every((product) => product.description.isNotEmpty),
      isTrue,
    );
  });

  testWidgets('shows the automotive catalog', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: AutomotiveProduct()));

    expect(find.text('Katalog Otomotif'), findsOneWidget);
    expect(find.text('8 ITEM'), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);

    await tester.tap(find.text('Toyota GR Supra'));
    await tester.pumpAndSettle();

    expect(find.text('Mobil sport'), findsOneWidget);
    expect(
      find.text('Coupe sport dengan performa tinggi dan desain agresif.'),
      findsNWidgets(2),
    );
    expect(find.text('Rp 2,1 M'), findsNWidgets(2));

    await tester.tap(find.text('Tutup'));
    await tester.pumpAndSettle();
  });

  testWidgets('replaces a product image after selecting a gallery image', (
    WidgetTester tester,
  ) async {
    final imageBytes = base64Decode(
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAIAAACQd1PeAAAADUlEQVR4nGP4z8AAAAMBAQDJ/pLvAAAAAElFTkSuQmCC',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: GridBuilder(pickImage: () async => imageBytes)),
      ),
    );

    await tester.tap(find.byTooltip('Ubah gambar Toyota GR Supra'));
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Gambar Toyota GR Supra berhasil diubah'), findsOneWidget);
  });
}
