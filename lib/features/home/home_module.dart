import 'package:city/features/home/data/datasources/home_datasource.dart';
import 'package:city/features/home/data/repositories/home_repository_impl.dart';
import 'package:city/features/home/domain/repositories/home_repository.dart';
import 'package:city/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:city/features/home/presentation/pages/edit_page.dart';
import 'package:city/features/home/presentation/pages/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void binds(i) {
    i.add<HomeRepository>(HomeRepositoryImpl.new);
    i.add<HomeDatasource>(HomeDatasourceImpl.new);
    i.add(HomePageCubit.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => HomePage());
    r.child('/edit',
        child: (context) => EditPage(
              city: r.args.data,
            ));
  }
}
