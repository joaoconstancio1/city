// coverage:ignore-file

import 'dart:async';
import 'package:city/app_module.dart';
import 'package:city/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

FutureOr<void> main() async {
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}
