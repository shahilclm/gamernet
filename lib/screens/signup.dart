import 'package:flutter/material.dart';
import 'package:gamernet/screens/login.dart';
import 'package:gamernet/screens/loginorsign.dart';
import 'package:gamernet/screens/signuppage3.dart';
import 'package:gamernet/widgets/textfieldcontainer.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  bool _isPasswordVisible = false; // To toggle password visibility
  bool _isConfirmPasswordVisible = false; // For confirm password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.only(top: 150, right: 15, left: 15, bottom: 70),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Color(0xff040412),
            child: Column(
              children: [
                Text(
                  'Create Account',
                  style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 25,
                      color: Colors.white70),
                ),
                SizedBox(
                  height: 50,
                ),
                TextfieldContainer(
                  controller: usernamecontroller,
                  hinttext: 'UserName',
                ),
                SizedBox(
                  height: 30,
                ),
                TextfieldContainer(
                  keyboardtype: TextInputType.emailAddress,
                  controller: emailcontroller,
                  hinttext: 'Email',
                ),
                SizedBox(
                  height: 30,
                ),
                TextfieldContainer(
                  obsecure: !_isPasswordVisible,
                  controller: passwordcontroller,
                  hinttext: 'Password',
                  icon: _isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onTap: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextfieldContainer(
                  obsecure: !_isConfirmPasswordVisible,
                  controller: confirmpasswordcontroller,
                  hinttext: 'Confirm Password',
                  icon: _isConfirmPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  onTap: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: buttonaccount(
                        title: 'Next',
                        onpress: () {
                          if (passwordcontroller.text ==
                              confirmpasswordcontroller.text) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Signuppagethree(
                                    emailcontroller: emailcontroller,
                                    passwordcontroller: passwordcontroller,
                                    confirmpasswordcontroller:
                                        confirmpasswordcontroller,
                                    usernamecontroller: usernamecontroller,
                                  ),
                                ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  content: Text(
                                    'Password and confirm password should be same',
                                    style: TextStyle(
                                        fontFamily: 'Orbitron',
                                        color: Colors.red),
                                  )),
                            );
                          }
                        })),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
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
                            return Login();
                          },
                        ));
                      },
                      child: Text(
                        'Login',
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
            )),
      ),
    );
  }
}
