import 'package:flutter/material.dart';
import 'package:gamernet/screens/loginorsign.dart';

class Signuppagetwo extends StatelessWidget {
  const Signuppagetwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(top: 150, right: 15, left: 15, bottom: 70),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Color(0xff040412),
          child: Column(
            children: [
              Text(
                'Create password',
                style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 25,
                    color: Colors.white70),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xff272738)),
                child: TextField(
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.remove_red_eye_outlined,
                        color: Colors.white,
                      ),
                      hintText: 'Password',
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
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: buttonaccount(title: 'Next', onpress: () {})),
            ],
          )),
    );
  }
}
