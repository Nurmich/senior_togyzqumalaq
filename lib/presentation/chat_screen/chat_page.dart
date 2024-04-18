import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text(
          "Welcome to the Chat Page!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
