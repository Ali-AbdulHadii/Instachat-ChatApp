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

  //send a friend request
  Future<void> sendFriendRequest(String senderId, String recipientId) async {
    await FirebaseFirestore.instance.collection("friendRequests").add({
      'senderId': senderId,
      'recipientId': recipientId,
      'status': 'pending', // more statuses needed
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  //fetch user data from Firestore database
  Future<QuerySnapshot> getUserbyEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("Email", isEqualTo: email)
        .get();
  }
}
