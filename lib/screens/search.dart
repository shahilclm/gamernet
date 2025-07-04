import 'package:awesome_icons/awesome_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gamernet/data/firebase_services/firestor.dart';
import 'package:gamernet/screens/searchprofile.dart';
import 'package:gamernet/widgets/textfieldcontainer.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<Map<String, dynamic>> searchResult = [];
  TextEditingController searchController = TextEditingController();
  void _searchUsers() async {
    String searchTerm = searchController.text.trim();
    if (searchTerm.isNotEmpty) {
      List<Map<String, dynamic>> results =
          await Firebase_firestore().searchUser(searchTerm);
      setState(() {
        searchResult = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 60),
        color: Color(0xff040412),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.19,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextfieldContainer(
                      controller: searchController,
                      hinttext: 'Search',
                      prefixicon: FontAwesomeIcons.search,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _searchUsers();
                    },
                    icon: Icon(FontAwesomeIcons.search))
              ],
            ),
            Expanded(
                child: ListView.builder(
              itemCount: searchResult.length,
              itemBuilder: (context, index) {
                final user = searchResult[index];
                String? imageurl = user['ImageUrl'];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return UserProfile(
                          userId: user['UserName'],
                        );
                      },
                    ));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                        backgroundImage: imageurl != null && imageurl.isNotEmpty
                            ? NetworkImage(imageurl)
                            : AssetImage('images/pic7.png')),
                    title: Text(
                      user['UserName'],
                      style: TextStyle(
                          fontFamily: 'Orbitron', color: Colors.white),
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
