import 'package:city/app_module.dart';
import 'package:city/features/home/domain/entities/city_entity.dart';
import 'package:city/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:city/features/home/presentation/pages/edit_or_create_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomePageCubit extends Mock implements HomePageCubit {}

void main() {
  late MockHomePageCubit mockHomePageCubit;

  setUp(() {
    mockHomePageCubit = MockHomePageCubit();
    Modular.bindModule(AppModule());
    Modular.replaceInstance<HomePageCubit>(mockHomePageCubit);
  });

  tearDown(() {
    Modular.dispose();
  });

  Widget createWidgetUnderTest({CityEntity? city}) {
    return MaterialApp(
      home: EditOrCreatePage(city: city),
    );
  }

  group('EditOrCreatePage', () {
    testWidgets('displays Create UI when no city is provided', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Create'), findsOneWidget);
      expect(find.text('City Name'), findsOneWidget);
      expect(find.text('Temperature'), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('Create City'), findsOneWidget);
      expect(find.text('Random City'), findsOneWidget);
    });

    testWidgets('displays Edit UI when a city is provided', (tester) async {
      final city = CityEntity(
        id: '1',
        city: 'Test City',
        temperature: '25',
        description: 'Sunny',
      );

      await tester.pumpWidget(createWidgetUnderTest(city: city));

      expect(find.text('Edit'), findsOneWidget);
      expect(find.text('Save Changes'), findsOneWidget);
      expect(find.text('Test City'), findsOneWidget);
      expect(find.text('25'), findsOneWidget);
      expect(find.text('Sunny'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(3));
    });

    testWidgets('validates empty fields', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Create City'));
      await tester.pump();

      expect(find.text('This field cannot be empty'), findsNWidgets(3));
    });
  });

  testWidgets('calls updateCity on cubit when editing and valid input provided',
      (tester) async {
    final city = CityEntity(
      id: '1',
      city: 'Existing City',
      temperature: '30',
      description: 'Clear',
    );

    // Set up the mock to return a Future<void> when updateCity is called
    when(() => mockHomePageCubit.updateCity(
          id: any(named: 'id'),
          cityName: any(named: 'cityName'),
          temperature: any(named: 'temperature'),
          description: any(named: 'description'),
        )).thenAnswer((_) async => Future.value());

    await tester.pumpWidget(createWidgetUnderTest(city: city));

    await tester.enterText(find.byKey(Key('cityNameField')), 'Updated City');
    await tester.enterText(find.byKey(Key('temperatureField')), '35');
    await tester.enterText(find.byKey(Key('descriptionField')), 'Cloudy');

    await tester.tap(find.text('Save Changes'));
    await tester.pump();

    verify(() => mockHomePageCubit.updateCity(
          id: city.id,
          cityName: 'Updated City',
          temperature: '35',
          description: 'Cloudy',
        )).called(1);
  });

  testWidgets(
      'calls createCity on cubit when creating and valid input provided',
      (tester) async {
    when(() => mockHomePageCubit.createCity(
          id: any(named: 'id'),
          cityName: any(named: 'cityName'),
          temperature: any(named: 'temperature'),
          description: any(named: 'description'),
        )).thenAnswer((_) async => Future.value());

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byKey(Key('cityNameField')), 'New City');
    await tester.enterText(find.byKey(Key('temperatureField')), '28');
    await tester.enterText(find.byKey(Key('descriptionField')), 'Rainy');

    await tester.tap(find.text('Create City'));
    await tester.pump();

    verify(() => mockHomePageCubit.createCity(
          cityName: 'New City',
          temperature: '28',
          description: 'Rainy',
        )).called(1);
  });

  testWidgets(
      'displays error messages when trying to save with invalid temperature',
      (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byKey(Key('cityNameField')), 'Test City');
    await tester.enterText(find.byKey(Key('temperatureField')), '');
    await tester.enterText(find.byKey(Key('descriptionField')), 'Cloudy');

    await tester.tap(find.text('Create City'));
    await tester.pump();

    expect(find.text('This field cannot be empty'), findsOneWidget);
  });

  testWidgets(
      'calls cubit createCity with random values when Random City button is tapped',
      (tester) async {
    when(() => mockHomePageCubit.createCity(
          id: any(named: 'id'),
          cityName: any(named: 'cityName'),
          temperature: any(named: 'temperature'),
          description: any(named: 'description'),
        )).thenAnswer((_) async => Future.value());
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.text('Random City'));
    await tester.pump();

    verify(() => mockHomePageCubit.createCity()).called(1);
  });

  testWidgets(
      'populates form fields with initial values when editing an existing city',
      (tester) async {
    final city = CityEntity(
      id: '1',
      city: 'Sample City',
      temperature: '20',
      description: 'Warm',
    );

    await tester.pumpWidget(createWidgetUnderTest(city: city));

    expect(find.text('Sample City'), findsOneWidget);
    expect(find.text('20'), findsOneWidget);
    expect(find.text('Warm'), findsOneWidget);
  });
}
