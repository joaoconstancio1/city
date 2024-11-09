import 'package:city/features/home/presentation/components/show_delete_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Delete confirmation dialog displays correctly',
      (WidgetTester tester) async {
    // Define a mock function for deleteCity action
    bool deleteCalled = false;
    void mockDeleteCity() {
      deleteCalled = true;
    }

    // Build the widget and trigger the dialog
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () =>
                    showDeleteConfirmationDialog(context, mockDeleteCity),
                child: Text('Show Dialog'),
              );
            },
          ),
        ),
      ),
    );

    // Tap the button to show the dialog
    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    // Verify the dialog elements
    expect(find.text('Confirm Deletion'), findsOneWidget);
    expect(
        find.text(
            'Are you sure you want to delete this city? This action cannot be undone.'),
        findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
    expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);

    // Verify the Cancel button closes the dialog
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Confirm Deletion'), findsNothing);

    // Reopen the dialog for delete action testing
    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    // Verify the Delete button triggers the deleteCity callback
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(deleteCalled, isTrue);
  });

  testWidgets('Delete button styling and content', (WidgetTester tester) async {
    // Define a mock function for deleteCity action
    void mockDeleteCity() {}

    // Build the widget and trigger the dialog
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () =>
                    showDeleteConfirmationDialog(context, mockDeleteCity),
                child: Text('Show Dialog'),
              );
            },
          ),
        ),
      ),
    );

    // Open the dialog
    await tester.tap(find.text('Show Dialog'));
    await tester.pumpAndSettle();

    // Check that the Delete button has the expected styling
    final deleteButton = tester
        .widget<ElevatedButton>(find.widgetWithText(ElevatedButton, 'Delete'));
    expect(deleteButton.style?.backgroundColor?.resolve({}), Colors.red);
    expect(deleteButton.style?.padding?.resolve({}),
        EdgeInsets.symmetric(horizontal: 16, vertical: 10));
  });
}
