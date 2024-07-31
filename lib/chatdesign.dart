import 'package:flutter/material.dart';

class Chatdesign extends StatelessWidget {
  final String message;
  const Chatdesign({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.blue[200]),
      child: Text(
        message,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
