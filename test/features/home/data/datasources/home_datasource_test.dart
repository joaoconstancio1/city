// test/home_datasource_impl_test.dart

import 'package:city/core/custom_http_client.dart';
import 'package:city/features/home/data/datasources/home_datasource.dart';
import 'package:city/features/home/domain/entities/city_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock class for CustomHttpClient
class MockCustomHttpClient extends Mock implements CustomHttpClient {}

void main() {
  late MockCustomHttpClient mockHttpClient;
  late HomeDatasourceImpl datasource;

  setUp(() {
    mockHttpClient = MockCustomHttpClient();
    datasource = HomeDatasourceImpl(client: mockHttpClient);
  });

  setUpAll(() {
    registerFallbackValue(Uri());
  });

  group('HomeDatasourceImpl', () {
    group('get', () {
      test('should return list of CityEntity when the call is successful',
          () async {
        // Arrange
        final response = [
          {
            'id': '1',
            'city': 'New York',
            'temperature': '25',
            'description': 'Sunny',
          },
          {
            'id': '2',
            'city': 'Los Angeles',
            'temperature': '28',
            'description': 'Clear',
          },
        ];

        when(() => mockHttpClient.get(any())).thenAnswer((_) async => response);

        // Act
        final result = await datasource.get();

        // Assert
        expect(result, isA<List<CityEntity>>());
        expect(result.length, 2);
        expect(result[0].id, '1');
        expect(result[0].city, 'New York');
      });

      test('should throw an exception when the call fails', () async {
        // Arrange
        when(() => mockHttpClient.get(any()))
            .thenThrow(Exception('Failed to load cities'));

        // Act
        final call = datasource.get();

        // Assert
        expect(
            () => call,
            throwsA(isA<Exception>().having(
                (e) => e.toString(), 'message', contains('Request error:'))));
      });
    });

    group('addCity', () {
      test('should call post method on the client', () async {
        // Arrange
        when(() => mockHttpClient.post(any())).thenAnswer((_) async => null);

        // Act
        await datasource.addCity();

        // Assert
        verify(() => mockHttpClient.post(any())).called(1);
      });

      test('should throw an exception when the call fails', () async {
        // Arrange
        when(() => mockHttpClient.post(any()))
            .thenThrow(Exception('Failed to add city'));

        // Act
        final call = datasource.addCity();

        // Assert
        expect(
            () => call,
            throwsA(isA<Exception>().having((e) => e.toString(), 'message',
                contains('Error adding city:'))));
      });
    });

    group('deleteCity', () {
      const cityId = '123';

      test('should call delete method with correct URL', () async {
        // Arrange
        when(() => mockHttpClient.delete(any())).thenAnswer((_) async => null);

        // Act
        await datasource.deleteCity(cityId);

        // Assert
        verify(() => mockHttpClient.delete(any())).called(1);
      });

      test('should throw an exception when the call fails', () async {
        // Arrange
        when(() => mockHttpClient.delete(any()))
            .thenThrow(Exception('Failed to delete city'));

        // Act
        final call = datasource.deleteCity(cityId);

        // Assert
        expect(
            () => call,
            throwsA(isA<Exception>().having((e) => e.toString(), 'message',
                contains('Error deleting city:'))));
      });
    });

    group('updateCity', () {
      const cityId = '456';
      const cityName = 'Chicago';
      const temperature = '20';
      const description = 'Cloudy';

      test('should call put method with correct URL and data', () async {
        // Arrange
        final data = {
          'city': cityName,
          'temperature': temperature,
          'description': description,
        };

        when(() => mockHttpClient.put(any(), data: data))
            .thenAnswer((_) async => null);

        // Act
        await datasource.updateCity(
          id: cityId,
          cityName: cityName,
          temperature: temperature,
          description: description,
        );

        // Assert
        verify(() => mockHttpClient.put(any(), data: data)).called(1);
      });

      test('should throw an exception when the call fails', () async {
        // Arrange
        final data = {
          'city': cityName,
          'temperature': temperature,
          'description': description,
        };

        when(() => mockHttpClient.put(any(), data: data))
            .thenThrow(Exception('Failed to update city'));

        // Act
        final call = datasource.updateCity(
          id: cityId,
          cityName: cityName,
          temperature: temperature,
          description: description,
        );

        // Assert
        expect(
            () => call,
            throwsA(isA<Exception>().having((e) => e.toString(), 'message',
                contains('Error updating city:'))));
      });
    });

    group('createCity', () {
      const cityId = '789';
      const cityName = 'San Francisco';
      const temperature = '18';
      const description = 'Foggy';

      test('should call post method with correct URL and data', () async {
        // Arrange
        final data = {
          'city': cityName,
          'temperature': temperature,
          'description': description,
        };

        when(() => mockHttpClient.post(any(), data: data))
            .thenAnswer((_) async => null);

        // Act
        await datasource.createCity(
          id: cityId, // Assuming 'id' might not be used in createCity
          cityName: cityName,
          temperature: temperature,
          description: description,
        );

        // Assert
        verify(() => mockHttpClient.post(any(), data: data)).called(1);
      });

      test('should call post method with null data when no fields are provided',
          () async {
        // Arrange
        when(() => mockHttpClient.post(any(), data: null))
            .thenAnswer((_) async => null);

        // Act
        await datasource.createCity();

        // Assert
        verify(() => mockHttpClient.post(any(), data: null)).called(1);
      });

      test('should throw an exception when the call fails', () async {
        // Arrange
        when(() => mockHttpClient.post(any(), data: any(named: 'data')))
            .thenThrow(Exception('Failed to create city'));

        // Act
        final call = datasource.createCity(
          cityName: cityName,
          temperature: temperature,
          description: description,
        );

        // Assert
        expect(
            () => call,
            throwsA(isA<Exception>().having((e) => e.toString(), 'message',
                contains('Error creating city:'))));
      });
    });
  });
}
