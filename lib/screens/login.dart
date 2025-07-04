// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gamernet/data/firebase_services/firebase_auth.dart';
import 'package:gamernet/screens/bottomNav.dart';
import 'package:gamernet/screens/loginorsign.dart';
import 'package:gamernet/screens/signup.dart';
import 'package:gamernet/widgets/textfieldcontainer.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  bool ispasswordvisible = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60, right: 15, left: 15),
        color: Color(0xff040412),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // ignore: prefer_const_constructors
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome\nback',
                style: TextStyle(
                    height: 1,
                    fontFamily: 'Orbitron',
                    fontSize: 50,
                    color: Color(0xFF932EFF)),
              ),
              SizedBox(
                height: 150,
              ),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xff272738)),
                child: TextField(
                  controller: emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white, fontFamily: 'Orbitron'),
                  decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(
                          fontSize: 15,
                          color: Color(0xff81808D),
                          fontFamily: 'Orbitron'),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextfieldContainer(
                hinttext: 'Password',
                controller: passwordcontroller,
                obsecure: !ispasswordvisible,
                icon:
                    ispasswordvisible ? Icons.visibility : Icons.visibility_off,
                onTap: () {
                  setState(() {
                    ispasswordvisible = !ispasswordvisible;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'forgot password?',
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Orbitron',
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xFF932EFF),
                        color: Color(0xFF932EFF)),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: isLoading // Show loading indicator if logging in
                    ? CircularProgressIndicator()
                    : buttonaccount(
                        title: 'Login',
                        onpress: _handleLogin,
                      ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.purple
                          ], // Gradient colors
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Orbitron',
                        fontWeight: FontWeight.bold,
                        color: Colors.white70, // Custom color for text
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.purple,
                            Colors.blue
                          ], // Reversed gradient
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'images/apple.png',
                        width: 45,
                        height: 45,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'images/google.png',
                        width: 45,
                        height: 45,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'images/facebook.png',
                        width: 45,
                        height: 45,
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "dont't have an account?",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontFamily: 'Orbitron',
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return Signup();
                        },
                      ));
                    },
                    child: Text(
                      'signup',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Orbitron',
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFF932EFF),
                          color: Color(0xFF932EFF)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin() async {
    setState(() {
      isLoading = true; // Show loading indicator
    });

    // Validate email and password
    if (emailcontroller.text.isEmpty || passwordcontroller.text.isEmpty) {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both email and password.'),
          backgroundColor: Colors.red,
        ),
      );
      return; // Exit the function early
    }

    try {
      await Authentication().Login(
          email: emailcontroller.text, password: passwordcontroller.text);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => BottomNavBar(),
        ),
        (route) => false,
      );
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }
}
