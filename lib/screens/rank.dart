import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  int _selectedIndex = 0;
  final List<String> leaderboardTypes = ["Global", "Country", "Friends"];

  // Sample user lists for each leaderboard type
  final Map<String, List<Map<String, String>>> leaderboardData = {
    "Global": [
      {"name": "Abram", "points": "11M", "image": "assets/abram.jpg"},
      {"name": "Maren", "points": "11M", "image": "assets/maren.jpg"},
      {"name": "Tatiana", "points": "11M", "image": "assets/tatiana.jpg"},
      {"name": "Erin", "points": "11M", "image": "assets/erin.jpg"},
      {"name": "Jakob", "points": "11M", "image": "assets/jakob.jpg"},
    ],
    "Country": [
      {"name": "Livia", "points": "10M", "image": "assets/livia.jpg"},
      {"name": "Hanna", "points": "10M", "image": "assets/hanna.jpg"},
      {"name": "Tatiana", "points": "10M", "image": "assets/tatiana2.jpg"},
      {"name": "Anika", "points": "9M", "image": "assets/anika.jpg"},
    ],
    "Friends": [
      {"name": "Tatiana", "points": "8M", "image": "assets/tatiana.jpg"},
      {"name": "Abram", "points": "7M", "image": "assets/abram.jpg"},
      {"name": "Erin", "points": "6M", "image": "assets/erin.jpg"},
      {"name": "Jakob", "points": "6M", "image": "assets/jakob.jpg"},
    ]
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
            // Segmented Control
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: leaderboardTypes
                    .asMap()
                    .entries
                    .map((entry) => buildLeaderboardTab(entry.key, entry.value))
                    .toList(),
              ),
            ),
            // User List
            Expanded(
              child: ListView.builder(
                itemCount:
                    leaderboardData[leaderboardTypes[_selectedIndex]]!.length,
                itemBuilder: (context, index) {
                  final user =
                      leaderboardData[leaderboardTypes[_selectedIndex]]![index];
                  return buildUserTile(index + 1, user["name"]!,
                      user["points"]!, user["image"]!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper methods
  Widget buildLeaderboardTab(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
        decoration: BoxDecoration(
          color: _selectedIndex == index ? Colors.purple : Colors.black,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: _selectedIndex == index ? Colors.white : Colors.grey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget buildUserTile(int rank, String name, String points, String image) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(image), // Add local images to assets
        radius: 25,
      ),
      title: Text(
        '$rank. $name',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      trailing: Text(
        points,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
