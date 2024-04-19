import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
        title: Center(
          child: Text(
            "Chat",
            style: TextStyle(
              fontSize: 24,
              color: Colors.white, // Set the text color to white
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFC57941),
      ),
      body: Center(
        child: Text(
          "This page will be available soon!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
