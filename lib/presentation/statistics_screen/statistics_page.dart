import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Statistics",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white, // Set the text color to white
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFC57941),
      ),
      body: Center(
        child: Text(
          "Welcome to the Statistics Page!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
