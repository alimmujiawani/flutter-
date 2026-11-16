import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ikbal/music_app/music_home_page.dart';

void main() {
  testWidgets('search filters songs and opens the player', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MusicHomePage()));

    await tester.tap(find.text('Search').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'Golden');
    await tester.pumpAndSettle();

    expect(find.text('Golden Hour'), findsOneWidget);
    expect(find.text('Midnight City'), findsOneWidget);

    await tester.tap(find.text('Golden Hour'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mira Sol').last);
    await tester.pumpAndSettle();

    expect(find.text('NOW PLAYING'), findsOneWidget);
    expect(find.text('Mira Sol').last, findsOneWidget);
    expect(find.byKey(const Key('changeArtworkButton')), findsOneWidget);
  });

  testWidgets('library shows liked songs and can remove a favorite', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: MusicHomePage()));

    await tester.tap(find.text('Library'));
    await tester.pumpAndSettle();

    expect(find.text('Your library'), findsOneWidget);
    expect(find.text('Golden Hour'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite_rounded).first);
    await tester.pumpAndSettle();

    expect(find.text('Golden Hour'), findsNothing);
  });
}
