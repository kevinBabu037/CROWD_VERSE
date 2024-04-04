


import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenses{

 static String key='isLogin';
   
 

   static Future<void> saveBoolValue(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool?> getBoolValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

   static Future<bool?> deleteBool() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }



}


