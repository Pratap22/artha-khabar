import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:arthakhabar_app/main.dart';

void main() {
  testWidgets('App loads and shows splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const ArthakhabarApp());

    // Allow splash screen to render
    await tester.pump();

    // App should load without error
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
