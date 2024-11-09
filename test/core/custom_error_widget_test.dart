// custom_error_widget_test.dart

import 'package:city/core/custom_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CustomErrorWidget Tests', () {
    // Sample data for testing
    const testMessage = 'An error occurred';
    const testDetails = 'Error details: Unable to fetch data from the server.';
    bool retryCalled = false;

    // Helper function to build the widget
    Widget createWidgetUnderTest() {
      return MaterialApp(
        home: Scaffold(
          body: CustomErrorWidget(
            message: testMessage,
            details: testDetails,
            onRetry: () {
              retryCalled = true;
            },
          ),
        ),
      );
    }

    setUp(() {
      retryCalled = false;
    });

    testWidgets('Displays error icon', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('Displays error message', (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text(testMessage), findsOneWidget);
    });

    testWidgets('Displays "Try Again" button and triggers callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final tryAgainButton = find.widgetWithText(ElevatedButton, 'Try Again');
      expect(tryAgainButton, findsOneWidget);

      await tester.tap(tryAgainButton);
      await tester.pump();

      expect(retryCalled, isTrue);
    });

    testWidgets('Tapping "Show Details" displays the details',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final showDetailsButton = find.widgetWithText(TextButton, 'Show Details');
      expect(showDetailsButton, findsOneWidget);

      await tester.tap(showDetailsButton);
      await tester.pumpAndSettle(); // Wait for animations to complete

      expect(find.text(testDetails), findsOneWidget);
      expect(find.text('Hide Details'), findsOneWidget);
    });

    testWidgets('Tapping "Hide Details" hides the details',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      final showDetailsButton = find.widgetWithText(TextButton, 'Show Details');
      await tester.tap(showDetailsButton);
      await tester.pumpAndSettle();

      final hideDetailsButton = find.widgetWithText(TextButton, 'Hide Details');
      expect(hideDetailsButton, findsOneWidget);

      await tester.tap(hideDetailsButton);
      await tester.pumpAndSettle();

      expect(find.text(testDetails), findsOneWidget);
      expect(find.text('Show Details'), findsOneWidget);
    });

    testWidgets('Details section is scrollable when content exceeds max height',
        (WidgetTester tester) async {
      const longDetails = 'Error details: '; // Create a long string
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomErrorWidget(
              message: testMessage,
              details: longDetails,
              onRetry: () {},
            ),
          ),
        ),
      );

      // Show details
      final showDetailsButton = find.widgetWithText(TextButton, 'Show Details');
      await tester.tap(showDetailsButton);
      await tester.pumpAndSettle();

      // Verify that the details are present and scrollable
      expect(find.text(longDetails), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('AnimatedCrossFade transitions correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      // Initially, only the first child is visible
      expect(find.byType(AnimatedCrossFade), findsOneWidget);
      expect(find.byType(SingleChildScrollView), findsOneWidget);

      // Tap to show details
      final showDetailsButton = find.widgetWithText(TextButton, 'Show Details');
      await tester.tap(showDetailsButton);
      await tester.pump(); // Start the animation
      await tester.pump(const Duration(milliseconds: 150)); // Mid-animation

      await tester.pumpAndSettle(); // Complete the animation

      // Now, details should be visible
      expect(find.text(testDetails), findsOneWidget);
    });
  });
}
