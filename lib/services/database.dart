//functions related to database methods

import 'package:cloud_firestore/cloud_firestore.dart';

//integrates data to database
class DatabaseMethods {
  Future addUserDetails(
      Map<String, dynamic> userInformationMap, String id) async {
    //uploads the map to firebase, called from sign up
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInformationMap);
  }
}
