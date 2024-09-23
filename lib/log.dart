import 'package:logger/logger.dart';

logInfo(dynamic message) {
  Logger().i(message.toString());
}

logErr(dynamic message) {
  Logger().e(message.toString());
}
