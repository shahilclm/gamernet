import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Ranktab extends StatefulWidget {
  const Ranktab({super.key});

  @override
  State<Ranktab> createState() => _RanktabState();
}

class _RanktabState extends State<Ranktab> {
  int _selectedindex = 0;
  final List<String> rankTypes = ['Global', 'Counrty', 'Friends'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'leaderboard',
          style: TextStyle(
            fontFamily: 'Orbitron',
            color: Colors.purple,
            letterSpacing: 2,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Color(0xff040412),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: rankTypes
                  .asMap()
                  .entries
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedindex = e.key;
                        });
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        decoration: BoxDecoration(
                            color: _selectedindex == e.key
                                ? Colors.purple
                                : Colors.black,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          e.value,
                          style: TextStyle(
                              color: _selectedindex == e.key
                                  ? Colors.white
                                  : Colors.grey),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Divider(
                thickness: 0.2,
                color: Color(0xff81808D),
              ),
            ),
            Expanded(
                child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final users = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index].data() as Map<String, dynamic>;
                    final name = user['Name'];
                    final imageurl =
                        user.containsKey('ImageUrl') ? user['ImageUrl'] : '';
                    return Card(
                      shadowColor: Colors.white,
                      color: Color(0xff272738),
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundImage: imageurl.isNotEmpty
                                ? NetworkImage(imageurl)
                                : AssetImage('images/pic7.png')),
                        title: Text(
                          '   ${index + 1}.       $name',
                          style: TextStyle(
                              fontFamily: 'Orbitron', color: Colors.white70),
                        ),
                      ),
                    );
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
