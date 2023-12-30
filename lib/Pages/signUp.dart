import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //field validiations here
  final _formkey = GlobalKey<FormState>();

  String userName = "", email = "", password = "", confirmPassword = "";
  //controllers for information retieval
  TextEditingController _emailController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  //regisration function here
  registration() async {
    //username and password is checked
    if (userName.isNotEmpty &&
        password.isNotEmpty &&
        password == confirmPassword) {
      try {
        //waits for the result before proceeding with the operation
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String Id = randomAlphaNumeric(10);
        //maps the information to integrate it to firebase db
        Map<String, dynamic> userInformationMap = {
          "Username": _usernameController.text,
          "Email": _emailController.text,
          "Password": _passwordController.text,
          "Confirmed Password": _confirmPasswordController.text,
          "id": Id,
        };

        //display successful message with snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Registration was successful!",
              style: TextStyle(fontFamily: 'Montserrat-R', fontSize: 20),
            ),
          ),
        );
      }
      //eexception handling
      on FirebaseAuthException catch (t) {
        if (t.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Weak Password, Enter a different password",
                style: TextStyle(fontFamily: 'Montserrat-R', fontSize: 20),
              ),
            ),
          );
        } else if (t.code == 'username-already-exist') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Username Taken, Please Enter a Different Username!',
                style: TextStyle(fontFamily: 'Montserrat-R', fontSize: 20),
              ),
            ),
          );
        } else if (t.code == 'email-already-exist') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'An Account Has Been Registered with this email!',
                style: TextStyle(fontFamily: 'Montserrat-R', fontSize: 20),
              ),
            ),
          );
        } else {
          //Firebase Authentication errors here
          print("Error: ${t.message}");
        }
      } catch (t) {
        //non-Firebase related errors
        print("Error: $t");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar, color to be changed
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          //form key here
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //enter username, Textformfield to capture information
              TextFormField(
                controller: _usernameController,
                //validates the username using validator
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is Required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Enter Username',
                    prefixIcon: Icon(Icons.person),
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1))),
              ),
              SizedBox(
                height: 16,
              ),
              //enter email,
              TextFormField(
                controller: _emailController,
                //validates the email using validator
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'An E-mail is Required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Enter E-mail',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              //enter password
              TextFormField(
                controller: _passwordController,
                //hides password during input
                obscureText: true,
                //validates the password using validator
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is Required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  prefixIcon: Icon(Icons.password_rounded),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              //confirm password
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                //validates the confirmation of the password
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Confirm Your Password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 24),
              //the sign up confirm button
              ElevatedButton(
                onPressed: () {
                  //checks if the form is complete
                  if (_formkey.currentState!.validate()) {
                    //sets the informations
                    setState(
                      () {
                        userName = _usernameController.text;
                        email = _emailController.text;
                        password = _passwordController.text;
                        confirmPassword = _confirmPasswordController.text;
                      },
                    );
                  }
                  //registers the user if the information submitted is true
                  registration();
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    padding: EdgeInsets.symmetric(horizontal: 50)),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      fontFamily: 'FuturaLight',
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
