import 'package:city/core/http_client.dart';
import 'package:city/features/home/data/models/city_model.dart';
import 'package:city/features/home/domain/entities/city_entity.dart';
import 'package:city/flavors.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin HomeDatasource {
  Future<List<CityEntity>> get();
}

class HomeDatasourceImpl implements HomeDatasource {
  final client = Modular.get<HttpClient>();

  @override
  Future<List<CityEntity>> get() async {
    try {
      final response = client.get('${F.baseUrl}/city');
      final result = (response as List)
          .map((e) => CityModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return result;
    } catch (e) {
      throw Exception('Request error: $e');
    }
  }
}
