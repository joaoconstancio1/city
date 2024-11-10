import 'package:bloc_test/bloc_test.dart';
import 'package:city/app_module.dart';
import 'package:city/core/core_extensions.dart';
import 'package:city/core/custom_error_widget.dart';
import 'package:city/core/custom_loading_widget.dart';
import 'package:city/features/home/domain/entities/city_entity.dart';
import 'package:city/features/home/home_module.dart';
import 'package:city/features/home/presentation/components/weather_card.dart';
import 'package:city/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:city/features/home/presentation/cubit/home_page_states.dart';
import 'package:city/features/home/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomePageCubit extends Mock implements HomePageCubit {}

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  late MockHomePageCubit mockHomePageCubit;
  final navigator = ModularNavigateMock();
  Modular.navigatorDelegate = navigator;

  setUp(() {
    mockHomePageCubit = MockHomePageCubit();
    Modular.navigatorDelegate = navigator;
    Modular.bindModule(AppModule());
    Modular.replaceInstance<HomePageCubit>(mockHomePageCubit);

    when(() => mockHomePageCubit.close()).thenAnswer((_) async {});

    // Setup initial states for the cubit
    final cities = [
      CityEntity(
          id: '1', city: 'City 1', temperature: '2', description: 'sunny'),
      CityEntity(
          id: '2', city: 'City 2', temperature: '12', description: 'raining'),
    ];
    when(() => mockHomePageCubit.state)
        .thenReturn(HomePageSuccessState(cities: cities));
    whenListen(
        mockHomePageCubit,
        Stream<HomePageState>.fromIterable(
            [HomePageSuccessState(cities: cities)]));
  });

  Widget createTestableWidget() {
    return MaterialApp(
      home: BlocProvider<HomePageCubit>(
        create: (_) => mockHomePageCubit,
        child: const HomePageView(),
      ),
    );
  }

  testWidgets('Deve exibir HomePageView corretamente',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ModularApp(
        module: HomeModule(),
        child: BlocProvider<HomePageCubit>(
          create: (_) => mockHomePageCubit,
          child: MaterialApp(
            home: const HomePage(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(HomePageView), findsOneWidget);
  });

  testWidgets('renders SizedBox as fallback', (WidgetTester tester) async {
    when(() => mockHomePageCubit.state).thenReturn(HomePageInitialState());

    await tester.pumpWidget(createTestableWidget());

    expect(find.byKey(Key('sizedBox')), findsOneWidget);
  });

  testWidgets('shows loading state', (WidgetTester tester) async {
    when(() => mockHomePageCubit.state).thenReturn(HomePageLoadingState());
    whenListen(
      mockHomePageCubit,
      Stream<HomePageState>.fromIterable([HomePageLoadingState()]),
    );

    await tester.pumpWidget(createTestableWidget());

    expect(find.byType(CustomLoadingWidget), findsOneWidget);
  });

  testWidgets('shows error state', (WidgetTester tester) async {
    when(() => mockHomePageCubit.state).thenReturn(
      HomePageErrorState(Exception('Error loading data')),
    );
    whenListen(
      mockHomePageCubit,
      Stream<HomePageState>.fromIterable([
        HomePageErrorState(Exception('Error loading data')),
      ]),
    );

    await tester.pumpWidget(createTestableWidget());

    expect(find.byType(CustomErrorWidget), findsOneWidget);
    expect(
        find.text('Something went wrong. Please try again.'), findsOneWidget);
  });

  testWidgets('shows success state with weather cards',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget());

    expect(find.byType(WeatherCard), findsNWidgets(2));
    expect(find.text('City 1'), findsOneWidget);
    expect(find.text('City 2'), findsOneWidget);
  });

  testWidgets('calls deleteCity when delete action is triggered',
      (WidgetTester tester) async {
    // Mock the Cubit's behavior

    when(() => mockHomePageCubit.deleteCity(any())).thenAnswer((_) async {});

    await tester.pumpWidget(createTestableWidget());

    // Tap the delete button on the WeatherCard
    await tester.tap(find.descendant(
      of: find.widgetWithText(WeatherCard, 'City 1'), // Replace 'City Name'
      matching: find.byIcon(Icons.delete),
    ));
    await tester.pumpAndSettle(); // Wait for the dialog to appear

    // Tap the confirm button in the dialog
    await tester.tap(find.text('Delete')); // Adjust if the button text differs
    await tester
        .pumpAndSettle(); // Wait for the dialog to close and the action to complete

    // Verify deleteCity was called with the correct city ID
    verify(() => mockHomePageCubit.deleteCity('1')).called(1);
  });

  testWidgets('calls init on retry in error state',
      (WidgetTester tester) async {
    when(() => mockHomePageCubit.state)
        .thenReturn(HomePageErrorState(Exception('Error')));
    when(() => mockHomePageCubit.init()).thenAnswer((_) async {});

    await tester.pumpWidget(createTestableWidget());

    expect(find.byType(CustomErrorWidget), findsOneWidget);

    await tester.tap(find.text('Try Again'));
    await tester.pumpAndSettle();

    verify(() => mockHomePageCubit.init()).called(1);
  });

  testWidgets('calls init when returning from edit page',
      (WidgetTester tester) async {
    when(() => navigator.pushNamed(any())).thenAnswer((_) async => null);
    when(() => mockHomePageCubit.init()).thenAnswer((_) async {});

    await tester.pumpWidget(createTestableWidget());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    verify(() => navigator.pushNamed('/edit')).called(1);
    verify(() => mockHomePageCubit.init()).called(1);
  });

  testWidgets(
      'shows delete confirmation dialog when delete action is triggered',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget());

    await tester.tap(find.descendant(
      of: find.widgetWithText(WeatherCard, 'City 1'),
      matching: find.byIcon(Icons.delete),
    ));
    await tester.pumpAndSettle();

    expect(
        find.text(
            'Are you sure you want to delete this city? This action cannot be undone.'),
        findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
  });

  testWidgets('closes delete confirmation dialog when cancel is pressed',
      (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget());

    await tester.tap(find.descendant(
      of: find.widgetWithText(WeatherCard, 'City 1'),
      matching: find.byIcon(Icons.delete),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(
        find.text('Are you sure you want to delete this city?'), findsNothing);
  });

  testWidgets('calls init when returning from edit page with arguments',
      (WidgetTester tester) async {
    when(() => navigator.pushNamed(any(), arguments: any(named: 'arguments')))
        .thenAnswer((_) async => null);
    when(() => mockHomePageCubit.init()).thenAnswer((_) async {});

    await tester.pumpWidget(createTestableWidget());

    await tester.tap(find.descendant(
      of: find.widgetWithText(WeatherCard, 'City 1'),
      matching: find.byIcon(Icons.edit),
    ));
    await tester.pumpAndSettle();

    verify(() =>
            navigator.pushNamed('/edit', arguments: any(named: 'arguments')))
        .called(1);
    verify(() => mockHomePageCubit.init()).called(1);
  });
}
