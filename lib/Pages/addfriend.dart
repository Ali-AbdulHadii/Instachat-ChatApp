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
        //await DatabaseMethods().sendFriendRequest(senderId, recipientId);

        //check if the friend is already in the local friends list
        Set<String> localFriends = await SharedPreference().getFriendsList();
        if (localFriends.contains(recipientId)) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("You are already friends with $friendUsername"),
          ));
        } else {
          //update the friendRequests list after sending the friend request
          bool requestExists = await DatabaseMethods()
              .checkFriendRequestExist(senderId, recipientId);
          if (requestExists) {
            //friend request already sent
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              "Friend request has already been sent",
              style: TextStyle(fontFamily: "Montserrat-R", fontSize: 18),
            )));
            updateFriendRequestsList();
          } else {
            //if friend request was not sent. send one.
            await DatabaseMethods().sendFriendRequest(senderId, recipientId);
            updateFriendRequestsList();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Friend request sent successfully"),
            ));
          }
        }

        //popup
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

  //logic to accept friend request
  void acceptFriendRequest(String friendUsername) async {
    try {
      String? senderId = await SharedPreference().getUserID() as String?;
      String? friendId = await DatabaseMethods()
          .getUserIdByUsername(friendUsername) as String?;
      print("Friend ID: $friendId");

      if (senderId == null || friendId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Unable to get user ID")),
        );
        return;
      }

      await DatabaseMethods().acceptFriendRequest(senderId, friendId);
      //update local friends list only if the request is accepted
      Set<String> localFriends = await SharedPreference().getFriendsList();
      //add them locally
      localFriends.add(friendId);
      await SharedPreference().setFriendsList(localFriends.toList());
      //update friendrequest list after accepting them
      updateFriendRequestsList();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Friend request accepted")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error accepting friend request: $e")),
      );
    }
  }

  //logic to reject friend request
  void rejectFriendRequest(String friendUsername) async {
    try {
      String senderId = await SharedPreference().getUserID() as String;
      String friendId =
          await DatabaseMethods().getUserIdByUsername(friendUsername) as String;

      //logic to remove or update the friend request status..

      updateFriendRequestsList();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Friend request rejected"),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error rejecting friend request: $e"),
      ));
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
                  String friendUsername = friendRequests[index];
                  return ListTile(
                    title: Text(friendRequests[index]),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            //accept friend request logic
                            acceptFriendRequest(friendUsername);
                            print("Friend ID: $friendUsername");
                          },
                          icon: Icon(Icons.add_circle_outline),
                        ),
                        IconButton(
                          onPressed: () {
                            //reject friend request logic
                            rejectFriendRequest(friendUsername);
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
