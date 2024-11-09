// test/dio_http_client_test.dart

import 'package:city/core/dio_http_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock class for Dio
class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late DioHttpClient dioHttpClient;

  setUp(() {
    mockDio = MockDio();
    dioHttpClient = DioHttpClient(mockDio);
  });

  group('DioHttpClient', () {
    const testUrl = 'https://api.example.com/data';
    final testQueryParameters = {'param1': 'value1'};
    final testData = {'key': 'value'};

    group('get', () {
      test('returns data when the GET request is successful', () async {
        // Arrange
        final responseData = {'result': 'success'};
        when(() => mockDio.get(
              testUrl,
              queryParameters: testQueryParameters,
            )).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: testUrl),
          ),
        );

        // Act
        final result = await dioHttpClient.get(
          testUrl,
          queryParameters: testQueryParameters,
        );

        // Assert
        expect(result, equals(responseData));
        verify(() => mockDio.get(testUrl, queryParameters: testQueryParameters))
            .called(1);
      });

      test('throws DioError when the GET request fails', () async {
        // Arrange
        when(() => mockDio.get(
              testUrl,
              queryParameters: testQueryParameters,
            )).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: testUrl),
            error: 'Not Found',
            response: Response(
              statusCode: 404,
              requestOptions: RequestOptions(path: testUrl),
            ),
          ),
        );

        // Act & Assert
        expect(
          () => dioHttpClient.get(
            testUrl,
            queryParameters: testQueryParameters,
          ),
          throwsA(isA<DioException>()),
        );
        verify(() => mockDio.get(testUrl, queryParameters: testQueryParameters))
            .called(1);
      });
    });

    group('post', () {
      test('returns data when the POST request is successful', () async {
        // Arrange
        final responseData = {'id': 1, 'status': 'created'};
        when(() => mockDio.post(
              testUrl,
              data: testData,
              queryParameters: testQueryParameters,
            )).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 201,
            requestOptions: RequestOptions(path: testUrl),
          ),
        );

        // Act
        final result = await dioHttpClient.post(
          testUrl,
          data: testData,
          queryParameters: testQueryParameters,
        );

        // Assert
        expect(result, equals(responseData));
        verify(() => mockDio.post(
              testUrl,
              data: testData,
              queryParameters: testQueryParameters,
            )).called(1);
      });

      test('throws DioError when the POST request fails', () async {
        // Arrange
        when(() => mockDio.post(
              testUrl,
              data: testData,
              queryParameters: testQueryParameters,
            )).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: testUrl),
            error: 'Bad Request',
            response: Response(
              statusCode: 400,
              requestOptions: RequestOptions(path: testUrl),
            ),
          ),
        );

        // Act & Assert
        expect(
          () => dioHttpClient.post(
            testUrl,
            data: testData,
            queryParameters: testQueryParameters,
          ),
          throwsA(isA<DioException>()),
        );
        verify(() => mockDio.post(
              testUrl,
              data: testData,
              queryParameters: testQueryParameters,
            )).called(1);
      });
    });

    group('put', () {
      test('returns data when the PUT request is successful', () async {
        // Arrange
        final responseData = {'id': 1, 'status': 'updated'};
        when(() => mockDio.put(
              testUrl,
              data: testData,
            )).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: testUrl),
          ),
        );

        // Act
        final result = await dioHttpClient.put(
          testUrl,
          data: testData,
        );

        // Assert
        expect(result, equals(responseData));
        verify(() => mockDio.put(
              testUrl,
              data: testData,
            )).called(1);
      });

      test('throws DioError when the PUT request fails', () async {
        // Arrange
        when(() => mockDio.put(
              testUrl,
              data: testData,
            )).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: testUrl),
            error: 'Unauthorized',
            response: Response(
              statusCode: 401,
              requestOptions: RequestOptions(path: testUrl),
            ),
          ),
        );

        // Act & Assert
        expect(
          () => dioHttpClient.put(
            testUrl,
            data: testData,
          ),
          throwsA(isA<DioException>()),
        );
        verify(() => mockDio.put(
              testUrl,
              data: testData,
            )).called(1);
      });
    });

    group('delete', () {
      test('returns data when the DELETE request is successful', () async {
        // Arrange
        final responseData = {'status': 'deleted'};
        when(() => mockDio.delete(
              testUrl,
            )).thenAnswer(
          (_) async => Response(
            data: responseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: testUrl),
          ),
        );

        // Act
        final result = await dioHttpClient.delete(testUrl);

        // Assert
        expect(result, equals(responseData));
        verify(() => mockDio.delete(testUrl)).called(1);
      });

      test('throws DioError when the DELETE request fails', () async {
        // Arrange
        when(() => mockDio.delete(
              testUrl,
            )).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: testUrl),
            error: 'Forbidden',
            response: Response(
              statusCode: 403,
              requestOptions: RequestOptions(path: testUrl),
            ),
          ),
        );

        // Act & Assert
        expect(
          () => dioHttpClient.delete(testUrl),
          throwsA(isA<DioException>()),
        );
        verify(() => mockDio.delete(testUrl)).called(1);
      });
    });
  });
}
