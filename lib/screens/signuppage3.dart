import 'package:flutter/material.dart';
import 'package:gamernet/data/firebase_services/firebase_auth.dart';
import 'package:gamernet/screens/bottomNav.dart';
import 'package:gamernet/screens/loginorsign.dart';
import 'package:gamernet/utils/dialog.dart';
import 'package:gamernet/utils/exeption.dart';
import 'package:gamernet/widgets/datepic.dart'; // Import your DatePickerScreen here
import 'package:gamernet/widgets/textfieldcontainer.dart';

class Signuppagethree extends StatefulWidget {
  final TextEditingController emailcontroller;
  final TextEditingController passwordcontroller;
  final TextEditingController confirmpasswordcontroller;
  final TextEditingController usernamecontroller;

  const Signuppagethree({
    super.key,
    required this.emailcontroller,
    required this.passwordcontroller,
    required this.confirmpasswordcontroller,
    required this.usernamecontroller,
  });

  @override
  State<Signuppagethree> createState() => _SignuppagethreeState();
}

enum Gender { male, female }

class _SignuppagethreeState extends State<Signuppagethree> {
  String? selectedMonth;
  int? selectedYear;
  int? selectedDay;

  Gender? selectedGender;
  final TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  static const Color activecolor = Colors.purpleAccent;
  static const Color borderactivecolor = Color(0xFF932EFF);
  static const Color deactivecolor = Colors.transparent;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void _showDatePicker() async {
    final selectedDate = await showDialog<List<int>>(
      context: context,
      builder: (context) => Dialog(
        child: DatePickerScreen(), // Show the date picker dialog
      ),
    );

    if (selectedDate != null) {
      setState(() {
        selectedDay = selectedDate[0];
        selectedMonth = selectedDate[1].toString();
        selectedYear = selectedDate[2];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50, right: 20, left: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xff040412),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Select gender',
                style: TextStyle(
                  letterSpacing: 1,
                  fontFamily: 'Orbitron',
                  fontSize: 20,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    child: GenderCard(
                      bordercolor: selectedGender == Gender.male
                          ? borderactivecolor
                          : deactivecolor,
                      genderpic: 'male',
                      gender: 'Male',
                      shadowcolor: selectedGender == Gender.male
                          ? activecolor
                          : deactivecolor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.female;
                      });
                    },
                    child: GenderCard(
                      bordercolor: selectedGender == Gender.female
                          ? borderactivecolor
                          : deactivecolor,
                      genderpic: 'female',
                      gender: 'Female',
                      shadowcolor: selectedGender == Gender.female
                          ? activecolor
                          : deactivecolor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              TextfieldContainer(
                hinttext: 'Enter Name',
                controller: nameController,
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: _showDatePicker,
                child: AbsorbPointer(
                  child: TextfieldContainer(
                    hinttext: selectedDay != null &&
                            selectedMonth != null &&
                            selectedYear != null
                        ? 'DOB: $selectedDay/$selectedMonth/$selectedYear'
                        : 'Select Date of Birth',
                  ),
                ),
              ),
              SizedBox(height: 70),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: isLoading
                    ? CircularProgressIndicator()
                    : buttonaccount(
                        title: 'Sign Up',
                        onpress: () async {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await Authentication().SignUp(
                              email: widget.emailcontroller.text,
                              password: widget.passwordcontroller.text,
                              confirmpassword:
                                  widget.confirmpasswordcontroller.text,
                              username: widget.usernamecontroller.text,
                              gender: selectedGender.toString(),
                              name: nameController.text,
                              dob:
                                  '$selectedDay/$selectedMonth/$selectedYear', // Pass the formatted DOB
                            );
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => BottomNavBar(),
                              ),
                              (route) => false,
                            );
                          } on Exeptions catch (e) {
                            dialogBuilder(context, e.message);
                            // Handle signup error
                            print(e);
                          } finally {
                            setState(() {
                              isLoading = false;
                            });
                          }
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GenderCard extends StatelessWidget {
  final String genderpic;
  final String gender;
  final Color shadowcolor;
  final Color bordercolor;

  const GenderCard({
    super.key,
    required this.shadowcolor,
    required this.bordercolor,
    required this.genderpic,
    required this.gender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: shadowcolor,
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(color: bordercolor, width: 2),
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Image.asset(
            'images/$genderpic.png',
            width: 100,
            height: 150,
          ),
          Text(
            gender,
            style: TextStyle(
              fontFamily: 'Orbitron',
              fontSize: 20,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
