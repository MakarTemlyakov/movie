import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesInstance {
  static SharedPreferences? _intstance = null;
  static SharedPreferences get intstance => _intstance!;
  SharedPreferencesInstance._();

  static Future<void> init() async {
    SharedPreferencesInstance._intstance =
        await SharedPreferences.getInstance();
  }
}
