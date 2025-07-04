import 'package:firebase_auth/firebase_auth.dart';
import 'package:gamernet/data/firebase_services/firestor.dart';
import 'package:gamernet/utils/exeption.dart';

class Authentication {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> Login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
    } on FirebaseException catch (e) {
      throw Exeptions(e.message.toString());
    }
  }

  Future<void> SignUp({
    required String email,
    required String password,
    required String confirmpassword,
    required String username,
    required String gender,
    required String name,
    required String dob,
  }) async {
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          username.isNotEmpty &&
          gender.isNotEmpty &&
          name.isNotEmpty &&
          dob.isNotEmpty) {
        if (password == confirmpassword) {
          await _auth.createUserWithEmailAndPassword(
              email: email, password: password);

          //firestore information
          Map<String, dynamic> addUserInfo = {
            'Email': email,
            'Password': password,
            'UserName': username,
            'Name': name,
            'Gender': gender,
            'DOB': dob
          };

          await Firebase_firestore().createUser(addUserInfo);
        } else {
          throw Exeptions('Passwor and confirm password should be same');
        }
      } else {
        throw Exeptions('Enter all the fields');
      }
    } on FirebaseException catch (e) {
      throw Exeptions(e.message.toString());
    }
  }
}
