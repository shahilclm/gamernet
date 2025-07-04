import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gamernet/data/firebase_services/firestor.dart';
import 'package:gamernet/screens/loginorsign.dart';
import 'package:image_picker/image_picker.dart';

class Postscreen extends StatefulWidget {
  const Postscreen({super.key});

  @override
  State<Postscreen> createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  final TextEditingController contentControlller = TextEditingController();
  XFile? _selectedimage;
  final ImagePicker _picker = ImagePicker();
  Future<void> pickimage() async {
    final pickedimage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedimage != null) {
      setState(() {
        _selectedimage = pickedimage;
      });
    }
  }

  void upload() {
    if (contentControlller.text.isEmpty || _selectedimage == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Caption or Image is empty')));
    } else {
      if (contentControlller.text.isNotEmpty) {
        Firebase_firestore()
            .createPost(contentControlller.text, _selectedimage!);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white70,
            )),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        color: Color(0xff040412),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _selectedimage == null
                  ? Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff272738).withOpacity(0.4)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              pickimage();
                            },
                            child: Icon(
                              Icons.add,
                              color: Colors.white70,
                              size: 50,
                            ),
                          ),
                          Text(
                            'Select photo',
                            style: TextStyle(
                                fontFamily: 'Orbitron', color: Colors.white70),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff272738).withOpacity(0.4)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.file(
                          File(_selectedimage!.path),
                          fit: BoxFit.cover,
                        ),
                      )),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width / 1.2,
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff272738).withOpacity(0.4)),
                child: TextField(
                  controller: contentControlller,
                  style: TextStyle(
                      fontFamily: 'Orbitron',
                      color: Colors.white70,
                      letterSpacing: 1),
                  maxLines: 3,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Write a caption about post....',
                      hintStyle: TextStyle(
                          fontFamily: 'Orbitron', color: Colors.white54)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              buttonaccount(
                title: 'Post',
                onpress: () {
                  upload();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
