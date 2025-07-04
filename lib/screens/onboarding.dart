import 'package:flutter/material.dart';
import 'package:gamernet/screens/loginorsign.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50, left: 15, right: 15, bottom: 50),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xff040412),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'GamerNET',
                style: TextStyle(
                    fontFamily: 'Orbitron',
                    fontSize: 50,
                    color: Color(0xFF932EFF)),
              ),
            ),
            Spacer(),
            Text(
              'Stay connected\nwith your\ngaming community',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Orbitron', fontSize: 35),
            ),
            SizedBox(
              height: 100,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return Loginorsign();
                    },
                  ));
                },
                child: Container(
                  width: 230,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color(0xFF932EFF)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Let started',
                        style: TextStyle(
                            fontFamily: 'Orbitron',
                            color: Colors.white,
                            fontSize: 25),
                      ),
                      Icon(
                        Icons.keyboard_double_arrow_right,
                        size: 40,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
