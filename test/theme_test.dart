import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_essential_oil_diagnosis/main.dart';

void main() {
  testWidgets('配色は teal を元にする', (tester) async {
    await tester.pumpWidget(const MyApp());

    final colorScheme = Theme.of(tester.element(find.byType(Scaffold))).colorScheme;
    expect(colorScheme.primary, ColorScheme.fromSeed(seedColor: Colors.teal).primary);
  });
}
