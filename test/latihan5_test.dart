import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ikbal/main.dart';

void main() {
  testWidgets('shows the learning screen and starts the lesson', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Belajar Container'), findsOneWidget);
    expect(find.text('Candra Hediansyah'), findsOneWidget);
    expect(find.text('Belajar Flutter!'), findsOneWidget);
    expect(
      find.text('Bangun aplikasi mulai dari fundamental.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Mulai Belajar'));
    await tester.pump();

    expect(find.text('Selamat belajar Flutter!'), findsOneWidget);
  });
}
