import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fitmeal_ai/screens/workout/workout_menu_screen.dart';

void main() {
  testWidgets('creates a workout menu with an exercise', (
    WidgetTester tester,
  ) async {
    SharedPreferences.setMockInitialValues({});

    await tester.pumpWidget(const MaterialApp(home: WorkoutMenuScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'テストメニュー');
    await tester.tap(find.byType(OutlinedButton));
    await tester.pumpAndSettle();

    final textFields = find.byType(TextField);
    await tester.enterText(textFields.at(1), 'ベンチプレス');
    await tester.enterText(textFields.at(2), '60');
    await tester.enterText(textFields.at(3), '10');
    await tester.enterText(textFields.at(4), '3');
    await tester.enterText(textFields.at(5), '2');

    await tester.tap(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.byType(FilledButton),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('ベンチプレス'), findsOneWidget);

    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();

    expect(find.text('テストメニュー'), findsOneWidget);
    expect(find.textContaining('ベンチプレス'), findsOneWidget);
  });
}
