import 'package:shared_preferences/shared_preferences.dart';

class HiCache {
  SharedPreferences? prefs;

  HiCache._() {
    init();
  }

  HiCache.pre(this.prefs);
  static HiCache? _instance;

  static Future<HiCache?> preInit() async {
    if (_instance == null) {
      var perfs = await SharedPreferences.getInstance();
      _instance = HiCache.pre(perfs);
    }

    return _instance;
  }

  static HiCache getInstance() {
    return _instance ??= HiCache._();
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  setBool(String key, bool value) {
    prefs!.setBool(key, value);
  }

  setInt(String key, int value) {
    prefs!.setInt(key, value);
  }

  setDouble(String key, double value) {
    prefs!.setDouble(key, value);
  }

  setString(String key, String value) {
    prefs!.setString(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs!.setStringList(key, value);
  }

  T get<T>(String key) {
    return prefs!.get(key) as T;
  }
}
