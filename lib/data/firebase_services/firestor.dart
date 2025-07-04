import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gamernet/model/postmodel.dart';
import 'package:image_picker/image_picker.dart';

class Firebase_firestore {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<bool> createUser(Map<String, dynamic> userInfo) async {
    try {
      await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set(userInfo);
      return true;
    } catch (e) {
      print("Error creating user: $e");
      return false;
    }
  }

  Future<XFile?> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      return await _picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      print("Error picking image: $e");
      return null; // Return null on error
    }
  }

  Future<void> submitEditProfile(
      File imageFile, String newUsername, String newName) async {
    String? oldImageUrl;
    DocumentSnapshot userDoc = await _firebaseFirestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get();
    if (userDoc.exists) {
      var userData = userDoc.data() as Map<String, dynamic>;
      oldImageUrl = userData['ImageUrl']; // Assuming your field is 'ImageUrl'
    }
    if (oldImageUrl != null && oldImageUrl.isNotEmpty) {
      try {
        final oldImageRef = FirebaseStorage.instance.refFromURL(oldImageUrl);
        await oldImageRef.delete();
        print('Old image deleted successfully.');
      } catch (e) {
        print('Error deleting old image: $e');
      }
    }

    String? imageUrl;
    try {
      final imageRef = _storage.ref().child('users/${DateTime.now()}.png');
      await imageRef.putFile(imageFile);
      imageUrl = await imageRef.getDownloadURL();
      print("Uploaded image URL: $imageUrl");

      await _firebaseFirestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update(
              {'ImageUrl': imageUrl, 'UserName': newUsername, 'Name': newName});
    } catch (e) {
      print("Error updating profile: $e");
    }
  }

  Future<String?> uploadImage(XFile? image) async {
    if (image == null) return null;
    try {
      final storageRef = _storage.ref().child('post_image/${image.name}');
      final UploadTask = storageRef.putFile(File(image.path));
      final snapshot = await UploadTask.whenComplete(
        () {},
      );
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image:$e');
      return null;
    }
  }

  Future<void> createPost(String content, XFile imageFile) async {
    String imageUrl = '';
    if (imageFile != null) {
      imageUrl = await uploadImage(imageFile) ?? '';
      Post post = Post(
          id: '',
          userId: _auth.currentUser!.uid,
          imageUrl: imageUrl,
          content: content,
          timestamp: DateTime.now());
      await _firebaseFirestore.collection('posts').add(post.toMap());
    }
  }

  Future<List<Map<String, dynamic>>> searchUser(String searchterm) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    QuerySnapshot querySnapshot = await users
        .where('UserName', isGreaterThanOrEqualTo: searchterm)
        .where('UserName', isLessThanOrEqualTo: searchterm + '\uf8ff')
        .get();
    return querySnapshot.docs
        .map(
          (doc) => doc.data() as Map<String, dynamic>,
        )
        .toList();
  }

  //follow and unfollow

  Future<void> followUser(String targetUserId) async {
    try {
      final currentUserId = _auth.currentUser!.uid;
      //add target users to current users following
      await _firebaseFirestore
          .collection('users')
          .doc(currentUserId)
          .collection('following')
          .doc(targetUserId)
          .set({});

      await _firebaseFirestore
          .collection('users')
          .doc(targetUserId)
          .collection('followers')
          .doc(currentUserId)
          .set({});
    } catch (e) {
      print('error $e');
    }
  }

  Future<void> unFollowUser(String targetUserId) async {
    try {
      final currentUserId = _auth.currentUser!.uid;
      //add target users to current users following
      await _firebaseFirestore
          .collection('users')
          .doc(currentUserId)
          .collection('following')
          .doc(targetUserId)
          .delete();

      await _firebaseFirestore
          .collection('users')
          .doc(targetUserId)
          .collection('followers')
          .doc(currentUserId)
          .delete();
    } catch (e) {
      print('error $e');
    }
  }

  Future<List<String>> getFollowers(String userId) async {
    try {
      final snapshot = await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('followers')
          .get();
      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print('error $e');
      return [];
    }
  }

  Future<List<String>> getFollowing(String userId) async {
    try {
      final snapshot = await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('following')
          .get();
      return snapshot.docs.map((doc) => doc.id).toList();
    } catch (e) {
      print('error $e');
      return [];
    }
  }

  Future<bool> isFollowing(String targetuserId) async {
    try {
      final currentUserId = _auth.currentUser!.uid;
      final doc = await _firebaseFirestore
          .collection('users')
          .doc(currentUserId)
          .collection('following')
          .doc(targetuserId)
          .get();
      return doc.exists;
    } catch (e) {
      print('$e');
      return false;
    }
  }
}
