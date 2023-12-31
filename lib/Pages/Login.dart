import 'package:flutter/material.dart';
import 'package:chatappdemo1/Pages/signUp.dart';
import 'package:chatappdemo1/Pages/forgotpass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controllers
  //TO DO, firebase cred integration and auth
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TO DO redesign the app bar
      appBar: AppBar(
        title: const Text(
          'Welcome to Instachat',
          style: TextStyle(fontFamily: 'FuturaLight', fontSize: 30),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      //input field
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1))),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPass(),
                        ));
                  },
                  child: Text('Forgot Password?'),
                ),
              ],
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                String username = _usernameController.text;
                String password = _passwordController.text;
                //auth here
              },
              style: ElevatedButton.styleFrom(primary: Colors.white70),
              child: const Text(
                'Login',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'FuturaLight',
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the Sign Up page when the button is pressed
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => signUp()));
              },
              style: ElevatedButton.styleFrom(primary: Colors.amber),
              child: const Text(
                'Sign Up',
                style: TextStyle(
                    fontFamily: 'FuturaLight',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
