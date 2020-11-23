import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<int> getIntData(key) async {
    final data = await SharedPreferences.getInstance();
    return data.getInt(key) == null ? 0 : data.getInt(key);
  }

  Future<void> setIntData(key, value) async {
    final data = await SharedPreferences.getInstance();
    await data.setInt(key, value);
  }

  Future<double> getDoubleData(key) async {
    final data = await SharedPreferences.getInstance();
    return data.getDouble(key) == null ? 0.0 : data.getDouble(key);
  }

  Future<void> setDoubleData(key, value) async {
    final data = await SharedPreferences.getInstance();
    await data.setDouble(key, value);
  }

  Future<bool> getBoolData(key) async {
    final data = await SharedPreferences.getInstance();
    return data.getBool(key) == null ? false : data.getBool(key);
  }

  Future<void> setBoolData(key, value) async {
    print(value);
    final data = await SharedPreferences.getInstance();
    await data.setBool(key, value);
  }

  Future<String> getStringData(key) async {
    final data = await SharedPreferences.getInstance();
    return data.getString(key) == null ? "" : data.getString(key);
  }

  Future<void> setStringData(key, value) async {
    final data = await SharedPreferences.getInstance();
    await data.setString(key, value);
  }

  Future<List<String>> getStringListData(key) async {
    final data = await SharedPreferences.getInstance();
    return data.getStringList(key) == null
        ? List<String>()
        : data.getStringList(key);
  }

  Future<void> setStringListData(key, value) async {
    final data = await SharedPreferences.getInstance();
    await data.setStringList(key, value);
  }

  void eraseData() async {
    final data = await SharedPreferences.getInstance();
    data.clear();
  }
}
