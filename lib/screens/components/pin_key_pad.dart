import 'package:flutter/material.dart';

class PinKeyPad extends StatefulWidget {
  const PinKeyPad({Key? key, required this.keypad, required this.click})
      : super(key: key);

  final String keypad;
  final Function() click;
  @override
  State<PinKeyPad> createState() => _PinKeyPadState();
}

class _PinKeyPadState extends State<PinKeyPad> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.click,
      child: Text(
        widget.keypad,
        style: const TextStyle(
            color: Colors.white, fontSize: 35, fontWeight: FontWeight.w600),
      ),
    );
  }
}
