import 'package:awesome_icons/awesome_icons.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isExpanded = false;

  // Sample text for demonstration
  late String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff040412),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 15),
            child: const Icon(
              FontAwesomeIcons.comments,
              color: Colors.white70,
            ),
          )
        ],
        leading: const Icon(
          FontAwesomeIcons.bell,
          color: Colors.white70,
        ),
        title: const Center(
          child: Text(
            'GamerNet',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Orbitron',
                color: Color(0xFF932EFF)),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        color: Color(0xff040412),
        child: SingleChildScrollView(
          child: Container(
            color: const Color(0xff040412),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Shahil',
                        style: TextStyle(
                            fontFamily: 'Orbitron',
                            color: Colors.white70,
                            fontSize: 19),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('images/shahil.png'),
                        radius: 25,
                      ),
                      trailing: Icon(
                        Icons.more_horiz,
                        color: Colors.white70,
                        size: 30,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 280,
                      child: Image.asset(
                        'images/device.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          const Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(
                                Icons.thumb_up_outlined,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 5),
                              Text('100',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    color: Colors.white70,
                                  )),
                              SizedBox(width: 20),
                              Icon(
                                FontAwesomeIcons.commentDots,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 5),
                              Text('100',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    color: Colors.white70,
                                  )),
                              Spacer(),
                              Icon(
                                FontAwesomeIcons.paperPlane,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                    text.isEmpty
                        ? Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isExpanded
                                      ? text
                                      : text.split(' ').take(12).join(' ') +
                                          '...',
                                  style: const TextStyle(
                                      color: Colors.white70,
                                      fontFamily: 'Orbitron',
                                      fontSize: 13),
                                ),
                                if (!isExpanded)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isExpanded = true;
                                      });
                                    },
                                    child: Text(
                                      'more',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white70,
                                          color: Colors.white70,
                                          fontFamily: 'Orbitron'),
                                    ),
                                  ),
                                if (isExpanded)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isExpanded = false;
                                      });
                                    },
                                    child: Text(
                                      'Read less',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white70,
                                          color: Colors.white70,
                                          fontFamily: 'Orbitron'),
                                    ),
                                  ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Shahil',
                        style: TextStyle(
                            fontFamily: 'Orbitron',
                            color: Colors.white70,
                            fontSize: 19),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('images/shahil.png'),
                        radius: 25,
                      ),
                      trailing: Icon(
                        Icons.more_horiz,
                        color: Colors.white70,
                        size: 30,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 280,
                      child: Image.asset(
                        'images/device.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          const Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(
                                Icons.thumb_up_outlined,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 5),
                              Text('100',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    color: Colors.white70,
                                  )),
                              SizedBox(width: 20),
                              Icon(
                                FontAwesomeIcons.commentDots,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 5),
                              Text('100',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    color: Colors.white70,
                                  )),
                              Spacer(),
                              Icon(
                                FontAwesomeIcons.paperPlane,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                    text.isEmpty
                        ? Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isExpanded
                                      ? text
                                      : text.split(' ').take(12).join(' ') +
                                          '...',
                                  style: const TextStyle(
                                      color: Colors.white70,
                                      fontFamily: 'Orbitron',
                                      fontSize: 13),
                                ),
                                if (!isExpanded)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isExpanded = true;
                                      });
                                    },
                                    child: Text(
                                      'more',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white70,
                                          color: Colors.white70,
                                          fontFamily: 'Orbitron'),
                                    ),
                                  ),
                                if (isExpanded)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isExpanded = false;
                                      });
                                    },
                                    child: Text(
                                      'Read less',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white70,
                                          color: Colors.white70,
                                          fontFamily: 'Orbitron'),
                                    ),
                                  ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
                Column(
                  children: [
                    ListTile(
                      title: Text(
                        'Shahil',
                        style: TextStyle(
                            fontFamily: 'Orbitron',
                            color: Colors.white70,
                            fontSize: 19),
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        backgroundImage: AssetImage('images/shahil.png'),
                        radius: 25,
                      ),
                      trailing: Icon(
                        Icons.more_horiz,
                        color: Colors.white70,
                        size: 30,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 280,
                      child: Image.asset(
                        'images/device.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: Column(
                        children: [
                          const SizedBox(height: 5),
                          const Row(
                            children: [
                              SizedBox(width: 10),
                              Icon(
                                Icons.thumb_up_outlined,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 5),
                              Text('100',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    color: Colors.white70,
                                  )),
                              SizedBox(width: 20),
                              Icon(
                                FontAwesomeIcons.commentDots,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 5),
                              Text('100',
                                  style: TextStyle(
                                    fontFamily: 'Orbitron',
                                    color: Colors.white70,
                                  )),
                              Spacer(),
                              Icon(
                                FontAwesomeIcons.paperPlane,
                                color: Colors.white70,
                              ),
                              SizedBox(width: 10),
                            ],
                          ),
                        ],
                      ),
                    ),
                    text.isEmpty
                        ? Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isExpanded
                                      ? text
                                      : text.split(' ').take(12).join(' ') +
                                          '...',
                                  style: const TextStyle(
                                      color: Colors.white70,
                                      fontFamily: 'Orbitron',
                                      fontSize: 13),
                                ),
                                if (!isExpanded)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isExpanded = true;
                                      });
                                    },
                                    child: Text(
                                      'more',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white70,
                                          color: Colors.white70,
                                          fontFamily: 'Orbitron'),
                                    ),
                                  ),
                                if (isExpanded)
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isExpanded = false;
                                      });
                                    },
                                    child: Text(
                                      'Read less',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.white70,
                                          color: Colors.white70,
                                          fontFamily: 'Orbitron'),
                                    ),
                                  ),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
