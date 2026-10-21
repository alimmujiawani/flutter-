import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_ikbal/main.dart';

void main() {
  testWidgets('shows the collections and saves a link', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Save now.\nFind anytime.'), findsOneWidget);
    expect(find.text('My Collections'), findsOneWidget);
    expect(find.text('Unsorted'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'https://example.com');
    await tester.tap(find.byTooltip('Save link'));
    await tester.pump();

    expect(find.text('2 links'), findsOneWidget);
    expect(find.text('Link disimpan ke Unsorted'), findsOneWidget);
  });

  testWidgets('rejects links without a valid web address', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField), 'https://');
    await tester.tap(find.byTooltip('Save link'));
    await tester.pump();

    expect(
      find.text('Masukkan link yang valid, misalnya https://contoh.com'),
      findsOneWidget,
    );
    expect(find.text('1 links'), findsOneWidget);
  });
}
