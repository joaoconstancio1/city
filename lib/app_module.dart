import 'package:city/core/dio_http_client.dart';
import 'package:city/core/custom_http_client.dart';
import 'package:city/features/home/home_module.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    final dio = Dio(BaseOptions());

    i.addSingleton<Dio>(() => dio);

    i.addSingleton<CustomHttpClient>(DioHttpClient.new);
  }

  @override
  void routes(r) {
    r.module('/', module: HomeModule());
  }
}
