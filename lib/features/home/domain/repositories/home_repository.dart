import 'package:city/features/home/domain/entities/city_entity.dart';
import 'package:either_dart/either.dart';

mixin HomeRepository {
  Future<Either<Exception, List<CityEntity>>> get();
  Future<void> addCity();
}
