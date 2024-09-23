import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final getIt = GetIt.instance;

Future<void> initDeps() async {
  getIt.registerSingleton<Box>(await Hive.openBox('currentUserInfo'));
}
