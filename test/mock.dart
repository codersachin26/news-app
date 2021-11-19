import 'package:shared_preferences/shared_preferences.dart';

class MockPrefs implements SharedPreferences {
  String themeMode = 'light';
  @override
  Future<bool> clear() {
    // TODO: implement clear
    throw UnimplementedError();
  }

  @override
  Future<bool> commit() {
    // TODO: implement commit
    throw UnimplementedError();
  }

  @override
  bool containsKey(String key) {
    // TODO: implement containsKey
    throw UnimplementedError();
  }

  @override
  Object? get(String key) {
    if (key == 'themeMode') return themeMode;
  }

  @override
  bool? getBool(String key) {
    // TODO: implement getBool
    throw UnimplementedError();
  }

  @override
  double? getDouble(String key) {
    // TODO: implement getDouble
    throw UnimplementedError();
  }

  @override
  int? getInt(String key) {
    // TODO: implement getInt
    throw UnimplementedError();
  }

  @override
  Set<String> getKeys() {
    // TODO: implement getKeys
    throw UnimplementedError();
  }

  @override
  String? getString(String key) {
    // TODO: implement getString
    throw UnimplementedError();
  }

  @override
  List<String>? getStringList(String key) {
    // TODO: implement getStringList
    throw UnimplementedError();
  }

  @override
  Future<void> reload() {
    // TODO: implement reload
    throw UnimplementedError();
  }

  @override
  Future<bool> remove(String key) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> setBool(String key, bool value) {
    // TODO: implement setBool
    throw UnimplementedError();
  }

  @override
  Future<bool> setDouble(String key, double value) {
    // TODO: implement setDouble
    throw UnimplementedError();
  }

  @override
  Future<bool> setInt(String key, int value) {
    // TODO: implement setInt
    throw UnimplementedError();
  }

  @override
  Future<bool> setString(String key, String value) async {
    if (key == 'themeMode') {
      themeMode = value;
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> setStringList(String key, List<String> value) {
    // TODO: implement setStringList
    throw UnimplementedError();
  }
}
