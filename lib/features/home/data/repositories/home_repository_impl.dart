import 'package:city/features/home/data/datasources/home_datasource.dart';
import 'package:city/features/home/domain/entities/city_entity.dart';
import 'package:city/features/home/domain/repositories/home_repository.dart';
import 'package:either_dart/either.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource datasource;

  HomeRepositoryImpl(this.datasource);

  @override
  Future<Either<Exception, List<CityEntity>>> get() async {
    try {
      final result = await datasource.get();

      return Right(result);
    } on Exception catch (error) {
      return Left(Exception(error));
    }
  }
}
