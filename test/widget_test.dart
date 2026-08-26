// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:medicine_alert/main.dart';

void main() {
  testWidgets('muestra el resumen diario y permite marcar una dosis', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('MedicineAlert'), findsOneWidget);
    expect(find.text('Mi día'), findsOneWidget);
    expect(find.text('Losartán'), findsOneWidget);
    expect(find.text('2 pendientes'), findsOneWidget);

    await tester.tap(find.byTooltip('Marcar como tomada').first);
    await tester.pump();

    expect(find.text('1 pendientes'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
  });

  testWidgets('permite cambiar a la pestaña de medicamentos', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Medicamentos'));
    await tester.pump();

    expect(find.text('Mis medicamentos'), findsOneWidget);
  });
}
