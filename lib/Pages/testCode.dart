import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the backgroundColor to transparent
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 50.0),
        decoration: BoxDecoration(
          // Use a LinearGradient for the gradient effect
          gradient: LinearGradient(
            colors: [
              Colors.amber,
              Colors.amberAccent
            ], // Set your gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Instachat',
                  style: TextStyle(
                    fontFamily: 'FuturaLight',
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors
                        .white, // Set text color to contrast with the background
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                )
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // adding friends logic here
          // You can open a dialog or navigate to another screen for adding friends
        },
        backgroundColor: Colors.amberAccent,
        child: Icon(Icons.person_add),
      ),
    );
  }
}
