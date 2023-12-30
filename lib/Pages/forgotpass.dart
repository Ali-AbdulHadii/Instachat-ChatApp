import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //reset password page
      appBar: AppBar(
        title: const Text(
          'Reset Your Password',
          style: TextStyle(fontFamily: 'FuturaLight', fontSize: 24),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //input for email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'Your Email Address',
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1))),
            ),
            //send reset password email
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TO DO, handles forgetting password logic is here
              },
              style: ElevatedButton.styleFrom(primary: Colors.amber),
              child: Text(
                'Send',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'FuturaLight',
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
