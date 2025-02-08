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

abstract class SharedPreferencesKeys {
  static String requestTokenKey = "requestToken";
  static String isAuthKey = "isAuth";
  static String sessionIdKey = "SessionId";
}

abstract class AppLocalMovieTabs {
  static String nowPlaying = "Now playing";
  static String upcoming = "Upcoming";
  static String topRated = "Top rated";
  static String popular = "Popular";
}

abstract class AppRoutes {
  static String home = "/";
  static String watchList = "/watch_list";
  static String search = "/search";
  static String movieDetails = "/movie_detail";
}
