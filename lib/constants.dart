import 'package:moviedb/domain/models/secret_model.dart';

abstract class AppIcon {
  static const String calendar = 'assets/icons/calendar.svg';
  static const String clock = 'assets/icons/clock.svg';
  static const String ticket = 'assets/icons/ticket.svg';
}

abstract class AppLocal {
  static List<int> movieWatchList = [];
  static SecretModel secretModel = SecretModel(apiKey: "");
}
