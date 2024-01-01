import 'package:flutter/material.dart';
import 'package:chatappdemo1/Pages/addfriend.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //this line is uncessary but for npw its there
      backgroundColor: Colors.amber,
      //made the body in a container to give it gradient colors
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange, Colors.red, Colors.deepPurple],
          ),
        ),
        //margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 50.0),
        //this contains the top icons for name and search icon
        //it also contains the conatiner to display chats
        child: Column(
          children: [
            //holds the top icons for name and search icon
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 45),
              child: Row(
                //adds space inbetween the two widgets
                //need to implement a setting icon later on
                //TO-DO make a setting page wwith icon
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //App name here
                  Text(
                    'Instachat',
                    style: TextStyle(
                        fontFamily: 'FuturaLight',
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  Container(
                    //The Search Icon here
                    //margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.purpleAccent,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            //container that holds the chats, names, and pp
            //pp will be implemented later
            Container(
              //responsive design implementation
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.15,
              //this makes the chat section rounded
              //redesigned later
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              child: Column(
                children: [
                  //this will be the single chat
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //this add a circlur profile pic
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        //temporary image until image.network is implemented
                        child: Image.asset(
                          'images/pptest1.jpg',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 2.0,
                          ),
                          //username here
                          Text(
                            'Alio Abdul',
                            style: TextStyle(
                                fontFamily: 'FuturaLight',
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          //chat text here
                          Text(
                            'Hey Saleh',
                            style: TextStyle(
                                fontFamily: 'Montserrat-R',
                                fontSize: 18,
                                color: Colors.black45,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text('12:00 PM'),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            //The amount of messages
                            //margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.purpleAccent,
                                borderRadius: BorderRadius.circular(90)),
                            child: Text(
                              ' 1 ',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //this add a circlur profile pic
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        //temporary image until image.network is implemented
                        child: Image.asset(
                          'images/pptest1.jpg',
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 2.0,
                          ),
                          //username here
                          Text(
                            'Ahmed',
                            style: TextStyle(
                                fontFamily: 'FuturaLight',
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          //chat text here
                          Text(
                            'Hey Saleh',
                            style: TextStyle(
                                fontFamily: 'Montserrat-R',
                                fontSize: 18,
                                color: Colors.black45,
                                fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                      Spacer(),
                      Column(
                        children: [
                          Text('10:00 PM'),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            //The amount of messages
                            //margin: EdgeInsets.only(top: 20),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.purpleAccent,
                                borderRadius: BorderRadius.circular(90)),
                            child: Text(
                              ' 79 ',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      //icon on bottom right for addings a person and chat with him
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //adding friends logic here
          //opens a dialog or navigate to another screen for adding friends
          //depending on design
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => addFriend()));
        },
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.person_add),
      ),
    );
  }
}
