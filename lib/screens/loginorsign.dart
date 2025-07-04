import 'package:flutter/material.dart';
import 'package:gamernet/screens/login.dart';
import 'package:gamernet/screens/signup.dart';

class Loginorsign extends StatelessWidget {
  const Loginorsign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(bottom: 100),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xff040412),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buttonaccount(
              title: 'Login',
              onpress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ));
              },
            ),
            Text(
              'or',
              style: TextStyle(
                  fontFamily: 'Orbitron', color: Colors.white, fontSize: 20),
            ),
            buttonaccount(
              title: 'Sign Up',
              onpress: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Signup(),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}

class buttonaccount extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  buttonaccount({super.key, required this.title, required this.onpress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: TextButton(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Color(0xFF932EFF))),
          onPressed: onpress,
          child: Text(
            title,
            style: TextStyle(
                fontFamily: 'Orbitron',
                color: Colors.white,
                fontSize: 20,
                letterSpacing: 1),
          )),
    );
  }
}
