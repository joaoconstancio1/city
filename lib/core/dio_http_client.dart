import 'package:dio/dio.dart';
import 'custom_http_client.dart';

class DioHttpClient implements CustomHttpClient {
  final Dio _dio;

  DioHttpClient(this._dio);

  @override
  Future<dynamic> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    final response = await _dio.get(url, queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future<dynamic> post(String url,
      {dynamic data, Map<String, dynamic>? queryParameters}) async {
    final response =
        await _dio.post(url, data: data, queryParameters: queryParameters);
    return response.data;
  }

  @override
  Future<dynamic> put(String url, {dynamic data}) async {
    final response = await _dio.put(url, data: data);
    return response.data;
  }

  @override
  Future<dynamic> delete(String url) async {
    final response = await _dio.delete(url);
    return response.data;
  }
}
