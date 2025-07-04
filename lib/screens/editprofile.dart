import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamernet/data/firebase_services/firestor.dart';
import 'package:gamernet/screens/loginorsign.dart';

class Editprofile extends StatefulWidget {
  Editprofile(
      {super.key,
      required this.image,
      required this.username,
      required this.name});
  final String image;
  final String username;
  final String name;

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  TextEditingController? usernamecontroller;
  TextEditingController? namecontroller;
  File? _pickedImage; // To store the picked image file

  Future<void> _handleImagePick() async {
    final imageFile = await Firebase_firestore().pickImage();
    if (imageFile != null) {
      setState(() {
        _pickedImage = File(imageFile.path); // Store the picked image
      });
    }
  }

  Future<void> _handleSubmit() async {
    String newUsername = usernamecontroller?.text.trim() ?? '';
    String newName = namecontroller?.text.trim() ?? '';

    if (_pickedImage != null || newUsername.isNotEmpty || newName.isNotEmpty) {
      try {
        if (_pickedImage != null) {
          await Firebase_firestore()
              .submitEditProfile(_pickedImage!, newUsername, newName);
        } else {
          // If no image is picked, just update the username and name
          await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
            'UserName': newUsername.isNotEmpty
                ? newUsername
                : FieldValue.increment(0), // Retain old value if empty
            'Name': newName.isNotEmpty
                ? newName
                : FieldValue.increment(0), // Retain old value if empty
          });
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile updated successfully!')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please pick an image or enter a username.')),
      );
    }
  }

  @override
  void initState() {
    usernamecontroller = TextEditingController(text: widget.username);
    namecontroller = TextEditingController(text: widget.name);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    usernamecontroller!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit profile',
          style: TextStyle(
            fontFamily: 'Orbitron',
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
            color: Color(0xFF932EFF),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white70,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        color: Color(0xff040412),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _handleImagePick,
                child: Center(
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: _pickedImage != null
                        ? FileImage(_pickedImage!) // Show the picked image
                        : widget.image.isNotEmpty
                            ? NetworkImage(widget.image)
                            : AssetImage('images/pic7.png') as ImageProvider,
                    child: Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Username',
                style: TextStyle(
                    color: Color(0xFF932EFF),
                    fontSize: 20,
                    fontFamily: 'Orbitron'),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff272738)),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  style: TextStyle(color: Colors.white, fontFamily: 'Orbitron'),
                  controller: usernamecontroller,
                  decoration: InputDecoration(
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Name',
                style: TextStyle(
                    color: Color(0xFF932EFF),
                    fontSize: 20,
                    fontFamily: 'Orbitron'),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff272738)),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  style: TextStyle(color: Colors.white, fontFamily: 'Orbitron'),
                  controller: namecontroller,
                  decoration: InputDecoration(
                      border:
                          UnderlineInputBorder(borderSide: BorderSide.none)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: buttonaccount(
                  title: 'Submit',
                  onpress: _handleSubmit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
