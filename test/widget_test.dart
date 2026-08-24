// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fitmeal_ai/screens/workout/workout_menu_screen.dart';

void main() {
  testWidgets('creates a workout menu with an exercise', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: WorkoutMenuScreen()));

    await tester.tap(find.text('メニューを作成'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, '胸トレ');
    await tester.tap(find.text('種目を追加'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).last, 'ベンチプレス');
    await tester.tap(find.text('追加'));
    await tester.pumpAndSettle();

    expect(find.text('ベンチプレス'), findsOneWidget);

    await tester.tap(find.text('保存'));
    await tester.pumpAndSettle();

    expect(find.text('胸トレ'), findsOneWidget);
    expect(find.text('・ベンチプレス'), findsOneWidget);
  });
}
