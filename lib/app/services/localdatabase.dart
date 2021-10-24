import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceLocalStorage {
  static SharedPreferenceLocalStorage? _instance;
  static SharedPreferences? _preferences;
  static Future<SharedPreferenceLocalStorage> getInstance() async {
    _instance ??= SharedPreferenceLocalStorage();
    _preferences ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  Future setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  Future setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  Future setDouble(String key, num value) async {
    return _preferences!.setDouble(key, value.toDouble());
  }


  bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  String? getString(String key) {
    return _preferences?.getString(key);
  }

  double? getDouble(String key) {
    return _preferences?.getDouble(key);
  }

  
  Future<bool?> clearData(String key) async {
    return await _preferences?.remove(key);
  }

  Future<bool?> clearStorage() async {
    return await _preferences?.clear();
  }

}
// class LocalDataBase {

//   static Future<bool> saveUserLoggedIn(bool isUserLoggedIn) async {
//     final _sharedPreference = await SharedPreferences.getInstance();
//     return await _sharedPreference.setBool(StorageKeys.userLoggedInKey, isUserLoggedIn);
//   }

//   static Future<bool> saveUsername(String username) async {
//     final _sharedPreference = await SharedPreferences.getInstance();
//     return await _sharedPreference.setString(StorageKeys.usernameKey, username);
//   }

//   static Future<bool> saveUserEmail(String email) async {
//     final _sharedPreference = await SharedPreferences.getInstance();
//     return await _sharedPreference.setString(StorageKeys.userEmailKey, email);
//   }

//   //Gettng data method
//   static Future<bool?> getUSerLoggedIn() async {
//     final _sharedPreference = await SharedPreferences.getInstance();
//     return _sharedPreference.getBool(StorageKeys.userLoggedInKey);
//   }

//   static Future<String?> getUsername() async {
//     final _sharedPreference = await SharedPreferences.getInstance();
//     return _sharedPreference.getString(StorageKeys.usernameKey);
//   }

//   static Future<String?> getUserEmail() async {
//     final _sharedPreference = await SharedPreferences.getInstance();
//     return _sharedPreference.getString(StorageKeys.userEmailKey);
//   }
// }
