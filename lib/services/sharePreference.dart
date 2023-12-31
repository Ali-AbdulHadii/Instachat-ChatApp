import 'package:shared_preferences/shared_preferences.dart';
/*persistent storage for simple data
to avoid frequent requests and load on server
like username, id, photos etc*/

class SharedPreference {
  //this saves the info locally
  static String userIdKey = "userKey";
  static String userNameKey = "userNameKey";
  static String userPhotoKey = "userPhotoKey";
  static String userEmailKey = "userEmailKey";
  static String displayUserNameKey = "displayUserName";

  //set functions to save the info
  Future<bool> setUserID(String getUserId) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.setString(userIdKey, getUserId);
  }

  Future<bool> setUserName(String getUserName) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.setString(userNameKey, getUserName);
  }

  Future<bool> setUserPhoto(String getUserPhoto) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.setString(userPhotoKey, getUserPhoto);
  }

  Future<bool> setUserEmail(String getUserEmail) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.setString(userEmailKey, getUserEmail);
  }

  Future<bool> setDisplayUserName(String getDisplayUserName) async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.setString(displayUserNameKey, getDisplayUserName);
  }

  //get functions to display the info
  Future<String?> getUserID() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString(userIdKey);
  }

  Future<String?> getUserName() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString(userNameKey);
  }

  Future<String?> getUserPhoto() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString(userPhotoKey);
  }

  Future<String?> getUserEmail() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString(userEmailKey);
  }

  Future<String?> getDisplayUserName() async {
    SharedPreferences preference = await SharedPreferences.getInstance();
    return preference.getString(displayUserNameKey);
  }
}
