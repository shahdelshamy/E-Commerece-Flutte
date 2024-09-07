import 'package:shared_preferences/shared_preferences.dart';

class CacheData{

  static late SharedPreferences pref;

  Future<void> initializeShared() async {
    pref=await SharedPreferences.getInstance();
  }

   Future<bool>setData({required String key,required String value}) async {
  return await pref.setString(key, value);
  }

   String getData(String key){
   return pref.getString(key) ?? '';
  }

   Future<bool>deleteData(String key) async {
   return await pref.remove(key);
  }

   Future<bool>clearData() async {
    return await pref.clear();
  }


}