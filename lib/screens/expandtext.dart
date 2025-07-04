import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;

  ExpandableText({required this.text});

  @override
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isExpanded
                ? widget.text
                : widget.text.split(' ').take(10).join(' ') + '...',
            style: TextStyle(color: Colors.black),
          ),
          if (!isExpanded)
            Text(
              'Read more',
              style: TextStyle(color: Colors.blue),
            )
        ],
      ),
    );
  }
}
