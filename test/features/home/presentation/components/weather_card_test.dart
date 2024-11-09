import 'package:city/features/home/presentation/components/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:city/features/home/domain/entities/city_entity.dart';

void main() {
  group('WeatherCard Widget Tests', () {
    // Mock data for CityEntity
    final mockCity = CityEntity(
      city: 'Test City',
      temperature: '25',
      description: 'Sunny with some clouds',
    );

    testWidgets('displays city name, temperature, and description',
        (WidgetTester tester) async {
      // Build the WeatherCard widget with mock city data
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherCard(city: mockCity),
          ),
        ),
      );

      // Verify city name is displayed
      expect(find.text('Test City'), findsOneWidget);
      // Verify temperature is displayed
      expect(find.text('25°C'), findsOneWidget);
      // Verify description is displayed
      expect(find.text('Sunny with some clouds'), findsOneWidget);
    });

    testWidgets('calls onEdit callback when edit button is pressed',
        (WidgetTester tester) async {
      bool editCalled = false;

      // Build the WeatherCard widget with an onEdit callback
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherCard(
              city: mockCity,
              onEdit: () {
                editCalled = true;
              },
            ),
          ),
        ),
      );

      // Tap the edit button
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      // Verify the edit callback was triggered
      expect(editCalled, isTrue);
    });

    testWidgets('calls onDelete callback when delete button is pressed',
        (WidgetTester tester) async {
      bool deleteCalled = false;

      // Build the WeatherCard widget with an onDelete callback
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherCard(
              city: mockCity,
              onDelete: () {
                deleteCalled = true;
              },
            ),
          ),
        ),
      );

      // Tap the delete button
      await tester.tap(find.byIcon(Icons.delete));
      await tester.pumpAndSettle();

      // Verify the delete callback was triggered
      expect(deleteCalled, isTrue);
    });
  });
}
