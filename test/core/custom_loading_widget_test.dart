// test/custom_loading_widget_test.dart

import 'package:city/core/custom_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  group('CustomLoadingWidget Tests', () {
    testWidgets('should display SpinKitCircle', (WidgetTester tester) async {
      // Arrange: Build the CustomLoadingWidget inside a MaterialApp
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomLoadingWidget(),
          ),
        ),
      );

      // Act & Assert: Verify that SpinKitCircle is present
      expect(find.byType(SpinKitCircle), findsOneWidget);
    });

    testWidgets('SpinKitCircle has correct color and size',
        (WidgetTester tester) async {
      // Arrange: Define the expected color and size
      const expectedColor = Colors.blue;
      const expectedSize = 50.0;

      // Act: Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomLoadingWidget(),
          ),
        ),
      );

      // Find the SpinKitCircle widget
      final spinKitCircle =
          tester.widget<SpinKitCircle>(find.byType(SpinKitCircle));

      // Assert: Check color and size
      expect(spinKitCircle.color, equals(expectedColor));
      expect(spinKitCircle.size, equals(expectedSize));
    });

    testWidgets('CustomLoadingWidget is centered', (WidgetTester tester) async {
      // Act: Build the widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomLoadingWidget(),
          ),
        ),
      );

      // Find the Center widget using the unique Key
      final centerFinder = find.byKey(const Key('custom_loading_center'));
      expect(centerFinder, findsOneWidget);

      // Optionally, verify that SpinKitCircle is a child of Center
      final centerWidget = tester.widget<Center>(centerFinder);
      final child = centerWidget.child;
      expect(child, isA<SpinKitCircle>());
    });
  });
}
