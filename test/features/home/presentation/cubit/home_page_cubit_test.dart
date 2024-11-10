import 'package:bloc_test/bloc_test.dart';
import 'package:city/core/core_extensions.dart';
import 'package:city/features/home/domain/entities/city_entity.dart';
import 'package:city/features/home/domain/repositories/home_repository.dart';
import 'package:city/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:city/features/home/presentation/cubit/home_page_states.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late HomePageCubit homePageCubit;
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    homePageCubit = HomePageCubit(mockHomeRepository);
  });

  tearDown(() {
    homePageCubit.close();
  });

  group('HomePageCubit Tests', () {
    // Test for the init function
    blocTest<HomePageCubit, HomePageState>(
      'emits [HomePageLoadingState, HomePageSuccessState] when init is successful',
      setUp: () {
        // Setup the repository mock to return a successful result
        when(() => mockHomeRepository.get())
            .thenAnswer((_) async => Right(<CityEntity>[]));
      },
      build: () => homePageCubit,
      act: (cubit) => cubit.init(),
      expect: () => [
        const HomePageLoadingState(),
        HomePageSuccessState(cities: <CityEntity>[]),
      ],
    );

    // Test for error in init function
    blocTest<HomePageCubit, HomePageState>(
      'emits [HomePageLoadingState, HomePageErrorState] when init fails',
      setUp: () {
        when(() => mockHomeRepository.get())
            .thenAnswer((_) async => Left(Exception()));
      },
      build: () => homePageCubit,
      act: (cubit) => cubit.init(),
      expect: () => [
        const HomePageLoadingState(),
        HomePageErrorState(Exception()),
      ],
    );

    // Test for the addCity function
    blocTest<HomePageCubit, HomePageState>(
      'emits [HomePageLoadingState] and calls init after adding city',
      setUp: () {
        when(() => mockHomeRepository.addCity()).thenAnswer((_) async {});
        when(() => mockHomeRepository.get())
            .thenAnswer((_) async => Right(<CityEntity>[]));
      },
      build: () => homePageCubit,
      act: (cubit) => cubit.addCity(),
      expect: () => [
        const HomePageLoadingState(),
        HomePageSuccessState(cities: <CityEntity>[]),
      ],
    );

    // Test for the deleteCity function
    blocTest<HomePageCubit, HomePageState>(
      'emits [HomePageLoadingState] and calls init after deleting city',
      setUp: () {
        when(() => mockHomeRepository.deleteCity(any()))
            .thenAnswer((_) async {});
        when(() => mockHomeRepository.get())
            .thenAnswer((_) async => Right(<CityEntity>[]));
      },
      build: () => homePageCubit,
      act: (cubit) => cubit.deleteCity('123'),
      expect: () => [
        const HomePageLoadingState(),
        HomePageSuccessState(cities: <CityEntity>[]),
      ],
    );

    // Test for the updateCity function
    blocTest<HomePageCubit, HomePageState>(
      'calls updateCity on repository with correct parameters',
      setUp: () {
        when(() => mockHomeRepository.updateCity(
              id: any(named: 'id'),
              cityName: any(named: 'cityName'),
              temperature: any(named: 'temperature'),
              description: any(named: 'description'),
            )).thenAnswer((_) async {});
      },
      build: () => homePageCubit,
      act: (cubit) => cubit.updateCity(
        id: '123',
        cityName: 'Test City',
        temperature: '25',
        description: 'Sunny',
      ),
      verify: (_) {
        verify(() => mockHomeRepository.updateCity(
              id: '123',
              cityName: 'Test City',
              temperature: '25',
              description: 'Sunny',
            )).called(1);
      },
    );

    // Test for the createCity function
    blocTest<HomePageCubit, HomePageState>(
      'calls createCity on repository with correct parameters',
      setUp: () {
        when(() => mockHomeRepository.createCity(
              id: any(named: 'id'),
              cityName: any(named: 'cityName'),
              temperature: any(named: 'temperature'),
              description: any(named: 'description'),
            )).thenAnswer((_) async {});
      },
      build: () => homePageCubit,
      act: (cubit) => cubit.createCity(
        id: '123',
        cityName: 'New City',
        temperature: '30',
        description: 'Clear Sky',
      ),
      verify: (_) {
        verify(() => mockHomeRepository.createCity(
              id: '123',
              cityName: 'New City',
              temperature: '30',
              description: 'Clear Sky',
            )).called(1);
      },
    );
  }); // Test for error in addCity function

  blocTest<HomePageCubit, HomePageState>(
    'emits [ HomePageErrorState] when init fails',
    setUp: () {
      when(() => mockHomeRepository.get()).thenThrow(Exception());
    },
    build: () => homePageCubit,
    act: (cubit) => cubit.init(),
    expect: () => [
      const HomePageLoadingState(),
      HomePageErrorState(Exception()),
    ],
  );
  blocTest<HomePageCubit, HomePageState>(
    'emits [HomePageLoadingState, HomePageErrorState] when addCity fails',
    setUp: () {
      when(() => mockHomeRepository.addCity()).thenThrow(Exception());
    },
    build: () => homePageCubit,
    act: (cubit) => cubit.addCity(),
    expect: () => [
      const HomePageLoadingState(),
      HomePageErrorState(Exception()),
    ],
  );

// Test for error in deleteCity function
  blocTest<HomePageCubit, HomePageState>(
    'emits [HomePageLoadingState, HomePageErrorState] when deleteCity fails',
    setUp: () {
      when(() => mockHomeRepository.deleteCity(any())).thenThrow(Exception());
    },
    build: () => homePageCubit,
    act: (cubit) => cubit.deleteCity('123'),
    expect: () => [
      const HomePageLoadingState(),
      HomePageErrorState(Exception()),
    ],
  );

// Test for error in updateCity function
  blocTest<HomePageCubit, HomePageState>(
    'emits [ HomePageErrorState] when updateCity fails',
    setUp: () {
      when(() => mockHomeRepository.updateCity(
            id: any(named: 'id'),
            cityName: any(named: 'cityName'),
            temperature: any(named: 'temperature'),
            description: any(named: 'description'),
          )).thenThrow(Exception());
    },
    build: () => homePageCubit,
    act: (cubit) => cubit.updateCity(
      id: '123',
      cityName: 'Test City',
      temperature: '25',
      description: 'Sunny',
    ),
    expect: () => [
      HomePageErrorState(Exception()),
    ],
  );

// Test for error in createCity function
  blocTest<HomePageCubit, HomePageState>(
    'emits [ HomePageErrorState] when createCity fails',
    setUp: () {
      when(() => mockHomeRepository.createCity(
            id: any(named: 'id'),
            cityName: any(named: 'cityName'),
            temperature: any(named: 'temperature'),
            description: any(named: 'description'),
          )).thenThrow(Exception());
    },
    build: () => homePageCubit,
    act: (cubit) => cubit.createCity(
      id: '123',
      cityName: 'New City',
      temperature: '30',
      description: 'Clear Sky',
    ),
    expect: () => [
      HomePageErrorState(Exception()),
    ],
  );
}
