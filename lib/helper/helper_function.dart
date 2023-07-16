import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  // keys
  static String userLoggedInKey = 'LOGGEDINKEY';
  static String userNameKey = 'USERNAMEKEY';
  static String userEmailKey = 'USEREMAILKEY';

  // getting the data from SF

  static Future<bool?> getUserLoggedINStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }

  static Future<bool?> saveUserNameSF(String userName) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(userNameKey, userName);
  }

  static Future<bool?> saveEmailSF(String email) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setString(userEmailKey, email);
  }

  // saving data
  static Future<bool?> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<String?> getUserName() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userNameKey);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getString(userEmailKey);
  }
}
