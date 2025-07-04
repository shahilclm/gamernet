import 'package:awesome_icons/awesome_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamernet/screens/editprofile.dart';
import 'package:gamernet/screens/postscreen.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    User? currentUser = _auth.currentUser;
    String userId = currentUser!.uid;

    return Scaffold(
      body: Container(
          padding: EdgeInsets.only(
            top: 60,
          ),
          color: Color(0xff040412),
          width: MediaQuery.of(context).size.width,
          child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              // Check if the snapshot has data and if the document exists
              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Center(child: Text('User not found.'));
              }

              var userData = snapshot.data!.data() as Map<String, dynamic>;

              String username = userData['UserName'] ?? 'n';
              String name = userData['Name'] ?? 'n';
              var imageUrl = userData['ImageUrl'] ?? '';
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Editprofile(
                                        image: imageUrl,
                                        username: userData['UserName'],
                                        name: userData['Name'],
                                      )));
                        },
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontFamily: 'Orbitron',
                              color: Colors.white70,
                              fontSize: 20),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          showbottomsheett(context);
                        },
                        child: Icon(
                          FontAwesomeIcons.plusSquare,
                          color: Colors.white70,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.settings_outlined,
                        color: Colors.white70,
                        size: 25,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Orbitron',
                              color: Colors.white70,
                            ),
                          ),
                          Text('Following',
                              style: TextStyle(
                                fontFamily: 'Orbitron',
                                color: Colors.white70,
                              ))
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF932EFF), blurRadius: 20)
                            ],
                            borderRadius: BorderRadius.circular(45),
                            border: Border.all(
                              style: BorderStyle.solid,
                              width: 2,
                              color: Color(0xFF932EFF),
                            )),
                        child: CircleAvatar(
                            radius: 45,
                            backgroundImage: imageUrl.isNotEmpty
                                ? NetworkImage(imageUrl)
                                : AssetImage('images/pic7.png')
                                    as ImageProvider),
                      ),
                      Column(
                        children: [
                          Text(
                            '0',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Orbitron',
                              color: Colors.white70,
                            ),
                          ),
                          Text('Followers',
                              style: TextStyle(
                                fontFamily: 'Orbitron',
                                color: Colors.white70,
                              ))
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      username,
                      style: TextStyle(
                          letterSpacing: 1,
                          fontFamily: 'Orbitron',
                          fontSize: 23,
                          color: Colors.white70),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(name,
                      style: TextStyle(
                          fontFamily: 'Orbitron',
                          fontSize: 15,
                          letterSpacing: 1,
                          color: Colors.white70)),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Divider(
                      thickness: 0.2,
                      color: Color(0xFF932EFF),
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .where('userId',
                              isEqualTo:
                                  userId) // Filter posts by the current user
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
                                  color: Colors.white70),
                            ),
                          );
                        }

                        var posts = snapshot.data!.docs;

                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3, // Number of columns in the grid
                            crossAxisSpacing: 1, // Horizontal spacing
                            mainAxisSpacing: 1, // Vertical spacing
                            childAspectRatio:
                                0.9, // Aspect ratio for each grid item
                          ),
                          itemCount: posts.length,
                          itemBuilder: (context, index) {
                            var post = posts[index];
                            var imageUrl = post['imageUrl'] ??
                                ''; // Ensure 'imageUrl' exists
                            var content = post['content'] ??
                                ''; // Post content or caption

                            return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                child: Image.network(
                                  imageUrl,
                                  fit: BoxFit.cover,
                                )
                                //
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.stretch,
                                //   children: [
                                //     Expanded(
                                //         child: imageUrl.isNotEmpty
                                //             ? Image.network(
                                //                 imageUrl,
                                //                 fit: BoxFit
                                //                     .cover, // Cover the grid item
                                //               )
                                //             : Container(
                                //                 color: Colors.grey[300],
                                //                 child: Center(
                                //                   child: Text(
                                //                     'No Image',
                                //                     style: TextStyle(
                                //                         color: Colors.black54),
                                //                   ),
                                //                 ),
                                //               )),
                                //     // Padding(
                                //     //   padding: const EdgeInsets.all(8.0),
                                //     //   child: Text(
                                //     //     content,
                                //     //     style: TextStyle(
                                //     //         fontFamily: 'Orbitron',
                                //     //         color: Colors.black,
                                //     //         fontSize: 14),
                                //     //     maxLines: 2,
                                //     //     overflow: TextOverflow
                                //     //         .ellipsis, // Add ellipsis for long text
                                //     //   ),
                                //     // ),
                                //   ],
                                // ),
                                );
                          },
                        );
                      },
                    ),
                  )
                ],
              );
            },
          )),
    );
  }

  Future showbottomsheett(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
              color: Colors.transparent.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          height: 150,
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.photo,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Postscreen();
                        },
                      ));
                    },
                    child: Text(
                      'Add Post',
                      style: TextStyle(
                          letterSpacing: 2,
                          fontFamily: 'Orbitron',
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Icon(
                    Icons.live_tv_rounded,
                    color: Color(0xFF932EFF),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Go Live',
                    style: TextStyle(
                        letterSpacing: 2,
                        fontFamily: 'Orbitron',
                        color: Color(0xFF932EFF)),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
