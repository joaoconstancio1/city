import 'package:city/core/core_extensions.dart';
import 'package:city/features/home/data/datasources/home_datasource.dart';
import 'package:city/features/home/domain/entities/city_entity.dart';
import 'package:city/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource datasource;

  HomeRepositoryImpl(this.datasource);

  @override
  Future<Either<Exception, List<CityEntity>>> get() async {
    try {
      final result = await datasource.get();

      return Right(result);
    } on Exception catch (error) {
      return Left(error);
    }
  }

  @override
  Future<void> addCity() async {
    try {
      await datasource.addCity();
    } catch (e) {
      throw Exception('Failed to add city: $e');
    }
  }

  @override
  Future<void> deleteCity(String id) async {
    try {
      await datasource.deleteCity(id);
    } catch (e) {
      throw Exception('Failed to delete city: $e');
    }
  }

  @override
  Future<void> updateCity({
    String? id,
    String? cityName,
    String? temperature,
    String? description,
  }) async {
    try {
      await datasource.updateCity(
        id: id,
        cityName: cityName,
        temperature: temperature,
        description: description,
      );
    } catch (e) {
      throw Exception('Failed to update city: $e');
    }
  }

  @override
  Future<void> createCity({
    String? id,
    String? cityName,
    String? temperature,
    String? description,
  }) async {
    try {
      await datasource.createCity(
        id: id,
        cityName: cityName,
        temperature: temperature,
        description: description,
      );
    } catch (e) {
      throw Exception('Failed to update city: $e');
    }
  }
}
