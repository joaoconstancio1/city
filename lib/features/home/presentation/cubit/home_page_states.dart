import 'package:city/core/core_extensions.dart';
import 'package:city/features/home/domain/entities/city_entity.dart';

sealed class HomePageState extends Equatable {
  const HomePageState();
  @override
  List<Object?> get props => [];
}

final class HomePageInitialState extends HomePageState {
  const HomePageInitialState();
}

final class HomePageLoadingState extends HomePageState {
  const HomePageLoadingState();
}

final class HomePageErrorState extends HomePageState {
  final Exception exception;

  const HomePageErrorState(this.exception);
}

final class HomePageSuccessState extends HomePageState {
  const HomePageSuccessState({
    required this.cities,
  });

  final List<CityEntity> cities;

  @override
  List<Object?> get props => [cities];
}
