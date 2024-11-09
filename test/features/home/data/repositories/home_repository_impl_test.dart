import 'package:city/features/home/data/repositories/home_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:city/features/home/data/datasources/home_datasource.dart';
import 'package:city/features/home/domain/entities/city_entity.dart';

// Mock the HomeDatasource class
class MockHomeDatasource extends Mock implements HomeDatasource {}

void main() {
  late HomeRepositoryImpl homeRepository;
  late MockHomeDatasource mockHomeDatasource;

  setUp(() {
    mockHomeDatasource = MockHomeDatasource();
    homeRepository = HomeRepositoryImpl(mockHomeDatasource);
  });

  group('HomeRepositoryImpl', () {
    test('should return a list of CityEntity when get is called', () async {
      // Arrange
      final mockCities = [
        CityEntity(
            id: '1', city: 'City1', temperature: '25', description: 'Sunny')
      ];
      when(() => mockHomeDatasource.get()).thenAnswer((_) async => mockCities);

      // Act
      final result = await homeRepository.get();

      // Assert
      result.fold(
        (l) => fail('Expected Right, but got Left with error: $l'),
        (r) {
          expect(r, mockCities);
        },
      );
    });

    test('should return an exception when get fails', () async {
      // Arrange
      when(() => mockHomeDatasource.get())
          .thenThrow(Exception('Failed to fetch cities'));

      // Act
      final result = await homeRepository.get();

      // Assert
      result.fold(
        (l) {
          expect(l, isA<Exception>());
        },
        (r) => fail('Expected Left, but got Right with value: $r'),
      );
    });

    test('should call addCity and not throw an error', () async {
      // Arrange
      when(() => mockHomeDatasource.addCity()).thenAnswer((_) async {});

      // Act
      await homeRepository.addCity();

      // Assert
      verify(() => mockHomeDatasource.addCity()).called(1);
    });

    test('should throw an exception when addCity fails', () async {
      // Arrange
      when(() => mockHomeDatasource.addCity())
          .thenThrow(Exception('Failed to add city'));

      // Act & Assert
      expect(() => homeRepository.addCity(), throwsA(isA<Exception>()));
    });

    test('should call deleteCity and not throw an error', () async {
      // Arrange
      when(() => mockHomeDatasource.deleteCity('1')).thenAnswer((_) async {});

      // Act
      await homeRepository.deleteCity('1');

      // Assert
      verify(() => mockHomeDatasource.deleteCity('1')).called(1);
    });

    test('should throw an exception when deleteCity fails', () async {
      // Arrange
      when(() => mockHomeDatasource.deleteCity('1'))
          .thenThrow(Exception('Failed to delete city'));

      // Act & Assert
      expect(() => homeRepository.deleteCity('1'), throwsA(isA<Exception>()));
    });

    test('should call updateCity and not throw an error', () async {
      // Arrange
      when(() => mockHomeDatasource.updateCity(
            id: '1',
            cityName: 'Updated City',
            temperature: '30',
            description: 'Cloudy',
          )).thenAnswer((_) async {});

      // Act
      await homeRepository.updateCity(
        id: '1',
        cityName: 'Updated City',
        temperature: '30',
        description: 'Cloudy',
      );

      // Assert
      verify(() => mockHomeDatasource.updateCity(
            id: '1',
            cityName: 'Updated City',
            temperature: '30',
            description: 'Cloudy',
          )).called(1);
    });

    test('should throw an exception when updateCity fails', () async {
      // Arrange
      when(() => mockHomeDatasource.updateCity(
            id: '1',
            cityName: 'Updated City',
            temperature: '30',
            description: 'Cloudy',
          )).thenThrow(Exception('Failed to update city'));

      // Act & Assert
      expect(
          () => homeRepository.updateCity(
                id: '1',
                cityName: 'Updated City',
                temperature: '30',
                description: 'Cloudy',
              ),
          throwsA(isA<Exception>()));
    });

    test('should call createCity and not throw an error', () async {
      // Arrange
      when(() => mockHomeDatasource.createCity(
            id: '1',
            cityName: 'New City',
            temperature: '20',
            description: 'Rainy',
          )).thenAnswer((_) async {});

      // Act
      await homeRepository.createCity(
        id: '1',
        cityName: 'New City',
        temperature: '20',
        description: 'Rainy',
      );

      // Assert
      verify(() => mockHomeDatasource.createCity(
            id: '1',
            cityName: 'New City',
            temperature: '20',
            description: 'Rainy',
          )).called(1);
    });

    test('should throw an exception when createCity fails', () async {
      // Arrange
      when(() => mockHomeDatasource.createCity(
            id: '1',
            cityName: 'New City',
            temperature: '20',
            description: 'Rainy',
          )).thenThrow(Exception('Failed to create city'));

      // Act & Assert
      expect(
          () => homeRepository.createCity(
                id: '1',
                cityName: 'New City',
                temperature: '20',
                description: 'Rainy',
              ),
          throwsA(isA<Exception>()));
    });
  });
}
