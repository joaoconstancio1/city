import 'package:city/core/http_client.dart';
import 'package:city/features/home/data/models/city_model.dart';
import 'package:city/features/home/domain/entities/city_entity.dart';
import 'package:city/flavors.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin HomeDatasource {
  Future<List<CityEntity>> get();
  Future<void> addCity();
  Future<void> deleteCity(String id);
}

class HomeDatasourceImpl implements HomeDatasource {
  final client = Modular.get<HttpClient>();

  @override
  Future<List<CityEntity>> get() async {
    try {
      final response = await client.get('${F.baseUrl}/city');
      final result = (response as List)
          .map((e) => CityModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return result;
    } catch (e) {
      throw Exception('Request error: $e');
    }
  }

  @override
  Future<void> addCity() async {
    try {
      await client.post('${F.baseUrl}/city');
    } catch (e) {
      throw Exception('Error adding city: $e');
    }
  }

  @override
  Future<void> deleteCity(String id) async {
    try {
      await client.delete('${F.baseUrl}/city/$id');
    } catch (e) {
      throw Exception('Error deleting city: $e');
    }
  }
}
