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
      await datasource.addCity(); // Agora usando await corretamente
    } catch (e) {
      throw Exception('Failed to add city: $e');
    }
  }
}
