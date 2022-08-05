import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences sharedPreferences;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Put Data ///////////////////////////////
  static Future<bool> putData({
    @required String key,
    @required bool value,
  }) async
  {
    return await sharedPreferences.setBool(key, value);
  }

  // Get Data ///////////////////////////////
static bool getData({
    @required String key,
  })
  {
    return  sharedPreferences.get(key);
  }



}
