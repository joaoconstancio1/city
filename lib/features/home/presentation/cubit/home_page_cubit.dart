import 'package:city/core/core_extensions.dart';
import 'package:city/features/home/domain/entities/city_entity.dart';
import 'package:city/features/home/domain/repositories/home_repository.dart';

part 'home_page_states.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(
    this.repository,
  ) : super(const HomePageInitialState());

  final HomeRepository repository;

  Future<void> init() async {
    emit(const HomePageLoadingState());

    try {
      final result = await repository.get();
      result.fold((l) => emit(HomePageErrorState(l)),
          (r) => emit(HomePageSuccessState(cities: r)));
    } catch (error, stackTrace) {
      onError(error, stackTrace);
    }
  }

  Future<void> addCity() async {
    emit(const HomePageLoadingState());

    try {
      await repository.addCity();
      await init();
    } catch (error, stackTrace) {
      onError(error, stackTrace);
    }
  }
}
