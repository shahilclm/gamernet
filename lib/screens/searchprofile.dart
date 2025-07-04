import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  final String userId; // This is the username
  const UserProfile({super.key, required this.userId});

  @override
  State<UserProfile> createState() => _ProfileState();
}

class _ProfileState extends State<UserProfile> {
  bool follow = false;
  late Future<Map<String, dynamic>> _userProfileData;
  int _selectedIndex = 0;
  final List<String> postType = ['Posts', 'Shorts'];

  @override
  void initState() {
    super.initState();
    _userProfileData = _fetchUserProfile();
    _checkIfFollowing(); // Check if the current user is following this user
  }

  Future<Map<String, dynamic>> _fetchUserProfile() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('UserName', isEqualTo: widget.userId)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final userDoc = snapshot.docs.first;
      return {
        'data': userDoc.data() as Map<String, dynamic>,
        'docId': userDoc.id,
      };
    } else {
      throw Exception('User not found');
    }
  }

  Future<void> _checkIfFollowing() async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('followers')
        .doc(currentUserId)
        .get();

    if (snapshot.exists) {
      setState(() {
        follow = true;
      });
    }
  }

  Future<void> _followUser() async {
    final currentUserId = FirebaseAuth.instance.currentUser!.uid;

    if (follow) {
      // Unfollow user
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('followers')
          .doc(currentUserId)
          .delete();
      setState(() {
        follow = false;
      });
    } else {
      // Follow user
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .collection('followers')
          .doc(currentUserId)
          .set({'timestamp': FieldValue.serverTimestamp()});
      setState(() {
        follow = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        color: Color(0xff040412),
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder<Map<String, dynamic>>(
          future: _userProfileData,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              final userData = snapshot.data!['data'];
              final userId = snapshot.data!['docId'];

              String imageUrl = userData['ImageUrl'] ?? 'images/pic7.png';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Bar
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white70),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.more_horiz, color: Colors.white70),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // User Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Following Count
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('following')
                            .snapshots(),
                        builder: (context, followingSnapshot) {
                          final followingCount =
                              followingSnapshot.data?.docs.length ?? 0;
                          return _buildStatColumn(
                              followingCount.toString(), 'Following');
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(color: Color(0xFF932EFF), blurRadius: 20),
                          ],
                          borderRadius: BorderRadius.circular(45),
                          border: Border.all(
                            style: BorderStyle.solid,
                            width: 2,
                            color: Color(0xFF932EFF),
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage: imageUrl.startsWith('http')
                              ? NetworkImage(imageUrl)
                              : AssetImage(imageUrl) as ImageProvider,
                        ),
                      ),
                      // Followers Count
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(userId)
                            .collection('followers')
                            .snapshots(),
                        builder: (context, followersSnapshot) {
                          final followersCount =
                              followersSnapshot.data?.docs.length ?? 0;
                          return _buildStatColumn(
                              followersCount.toString(), 'Followers');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Username and Follow Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userData['UserName'] ?? 'Unknown User',
                        style: TextStyle(
                          letterSpacing: 1,
                          fontFamily: 'Orbitron',
                          fontSize: 23,
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: _followUser,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: follow
                                    ? Colors.transparent
                                    : Color(0xFF932EFF),
                                blurRadius: 20,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: follow
                                ? Colors.grey.shade400
                                : Color(0xFF932EFF),
                          ),
                          child: Icon(
                            follow
                                ? Icons.done_outline_outlined
                                : Icons.person_add_alt,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    userData['Name'] ?? '',
                    style: TextStyle(
                      fontFamily: 'Orbitron',
                      fontSize: 15,
                      letterSpacing: 1,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Post Type Selector
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: postType.asMap().entries.map(
                      (e) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = e.key;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 70),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: _selectedIndex == e.key
                                      ? Color(0xFF932EFF)
                                      : Colors.transparent,
                                  blurRadius: 20,
                                ),
                              ],
                              color: _selectedIndex == e.key
                                  ? Color(0xFF932EFF)
                                  : Color(0xff272738),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              e.value,
                              style: TextStyle(
                                color: _selectedIndex == e.key
                                    ? Colors.white
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  SizedBox(height: 10),
                  // User Posts
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .where('userId', isEqualTo: userId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text(
                              'No posts yet',
                              style: TextStyle(
                                fontFamily: 'Orbitron',
                                fontSize: 18,
                                color: Colors.white70,
                              ),
                            ),
                          );
                        }

                        var posts = snapshot.data!.docs;

                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 1,
                            childAspectRatio: 0.9,
                          ),
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            var post = posts[index];
                            var postImageUrl = post['imageUrl'] ?? '';

                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 5,
                              child: Image.network(
                                postImageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(
                                      child:
                                          Icon(Icons.error, color: Colors.red));
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            }
            return Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
