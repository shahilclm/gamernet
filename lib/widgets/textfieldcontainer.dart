import 'package:flutter/material.dart';

class TextfieldContainer extends StatefulWidget {
  final String hinttext;
  VoidCallback? onTap;
  bool obsecure;
  final IconData? icon;
  final IconData? prefixicon;
  final TextInputType? keyboardtype;
  TextEditingController? controller;
  TextfieldContainer({
    this.onTap,
    required this.hinttext,
    this.keyboardtype,
    this.icon,
    this.prefixicon,
    this.obsecure = false,
    this.controller,
    super.key,
  });

  @override
  State<TextfieldContainer> createState() => _TextfieldContainerState();
}

class _TextfieldContainerState extends State<TextfieldContainer> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Color(0xff272738)),
      child: TextField(
        obscureText: widget.obsecure,
        keyboardType: widget.keyboardtype,
        controller: widget.controller,
        style: TextStyle(
          fontFamily: 'Orbitron',
          color: Colors.white,
        ),
        decoration: InputDecoration(
            prefixIcon: Icon(
              widget.prefixicon,
              color: Colors.white,
            ),
            suffixIcon: GestureDetector(
              onTap: widget.onTap,
              child: Icon(
                widget.icon,
                color: Colors.white,
              ),
            ),
            hintText: widget.hinttext,
            hintStyle: TextStyle(
                fontSize: 15, color: Color(0xff81808D), fontFamily: 'Orbitron'),
            border: OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}
