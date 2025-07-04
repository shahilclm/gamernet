import 'package:flutter/material.dart';

Future<void> dialogBuilder(BuildContext context, String message) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Error',
          style: TextStyle(
              color: Colors.red,
              fontFamily: 'Orbitron',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        content: Text(
          message,
          style: TextStyle(fontFamily: 'Orbitron', fontSize: 20),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok',
                  style: TextStyle(
                    fontFamily: 'Orbitron',
                  )))
        ],
      );
    },
  );
}
