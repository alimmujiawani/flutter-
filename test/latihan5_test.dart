import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ikbal/container_widget/row_column.dart/latihan5.dart';

void main() {
  testWidgets('shows the learning screen and starts the lesson', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: Latihan5()));

    expect(find.text('Mates Power Riot'), findsOneWidget);
    expect(find.text('Riot Selecta'), findsOneWidget);
    expect(find.text('Belajar Flutter!'), findsOneWidget);
    expect(
      find.text('Bangun aplikasi mulai dari fundamental.'),
      findsOneWidget,
    );
    expect(find.text('Skill Keahlian:'), findsOneWidget);
    await tester.ensureVisible(find.text('Skill Keahlian:'));
    await tester.pumpAndSettle();
    expect(find.text('Laravel'), findsOneWidget);
    expect(find.text('Tailwind'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);

    await tester.ensureVisible(find.text('Mulai Belajar'));
    await tester.tap(find.text('Mulai Belajar'));
    await tester.pump();

    expect(find.text('Selamat belajar Flutter!'), findsOneWidget);
  });
}
