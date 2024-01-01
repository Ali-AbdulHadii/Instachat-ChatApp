import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class addFriend extends StatefulWidget {
  const addFriend({super.key});

  @override
  State<addFriend> createState() => _addFriendState();
}

class _addFriendState extends State<addFriend> {
  String friendUsername = "";
  //controllers
  TextEditingController _friendUsername = TextEditingController();
  //addding friend function
  addFriend() async {}
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
                  onPressed: () {},
                  child: Text(
                    "Send Friend Request",
                    style: TextStyle(fontFamily: "Montserrat-R", fontSize: 18),
                  )),
              SizedBox(height: 40),
              Container(
                child: Text(
                  "Friend Requests",
                  style: TextStyle(fontFamily: "Montserrat-R", fontSize: 18),
                ),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Container(
                            child: Text(
                              'Alio',
                              style: TextStyle(
                                  fontFamily: 'FuturaLight',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          Spacer(),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.add_circle_outline),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.remove_circle_outline))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
