import 'package:chatappdemo1/services/sharePreference.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatappdemo1/services/database.dart';

class addFriend extends StatefulWidget {
  const addFriend({super.key});

  @override
  State<addFriend> createState() => _addFriendState();
}

class _addFriendState extends State<addFriend> {
  //controllers
  TextEditingController _friendUsername = TextEditingController();
  //list to store friend requests
  List<String> friendRequests = [];
  //updates the list when entering the page
  @override
  void initState() {
    super.initState();
    // Initialize friend requests when the widget is created
    updateFriendRequestsList();
  }

  //stores friend requests id
  String friendUsername = "";
  String senderId = "";
  String recipientId = "";

  //adding friend function
  Future<void> addFriend() async {
    //controller
    String friendUsername = _friendUsername.text;

    if (friendUsername.isEmpty) {
      //pop up if empty
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Enter a valid username"),
      ));
    } else {
      try {
        /*gets both send id and recipent id and pass them to 
        sendfriendrequest method in databasemethods.dart*/
        senderId = await SharedPreference().getUserID() as String;
        recipientId = await DatabaseMethods()
            .getUserIdByUsername(friendUsername) as String;
        await DatabaseMethods().sendFriendRequest(senderId, recipientId);
        //update the friendRequests list after sending the friend request
        updateFriendRequestsList();
        //popup
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Friend request sent successfully"),
        ));
      } catch (t) {
        //pop up
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Username not found"),
        ));
      }
    }
  }

  //function to fupdate friend requests list
  Future<void> updateFriendRequestsList() async {
    try {
      /*fetch friend requests and update the friendRequests 
      list from the method in databasemethods.dart*/
      List<String> newFriendRequests =
          await DatabaseMethods().getFriendRequests();
      setState(() {
        friendRequests = newFriendRequests;
      });
    } catch (e) {
      print("Error fetching friend requests: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade600,
        title: Text(
          "Add friend",
          style: TextStyle(fontFamily: "Montserrat-R", fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Expanded(
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              SizedBox(height: 18),
              Text(
                "Enter Friend's Username",
                style: TextStyle(fontFamily: "Montserrat-R", fontSize: 18),
              ),
              SizedBox(height: 16),
              Container(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  controller: _friendUsername,
                  decoration: InputDecoration(
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1)),
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Username',
                  ),
                  //friends username value should be stored here
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    addFriend();
                  },
                  child: Text(
                    "Send Friend Request",
                    style: TextStyle(fontFamily: "Montserrat-R", fontSize: 18),
                  )),
              SizedBox(height: 40),
              //friend requests section here
              Container(
                child: Text(
                  "Friend Requests",
                  style: TextStyle(fontFamily: "Montserrat-R", fontSize: 18),
                ),
              ),
              SizedBox(height: 16),
              //building the friendrequest list here
              ListView.builder(
                shrinkWrap: true,
                itemCount: friendRequests.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(friendRequests[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            //accept friend request logic
                          },
                          icon: Icon(Icons.add_circle_outline),
                        ),
                        IconButton(
                          onPressed: () {
                            //reject friend request logic
                          },
                          icon: Icon(Icons.remove_circle_outline),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
