import 'package:flutter/material.dart';

//blue Text Button at the bottom of screens
class BlueTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const BlueTextButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
          side: const BorderSide(color: Colors.blueAccent),
          backgroundColor: const Color(0xFF40C4FF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          )),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
