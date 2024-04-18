import 'package:flutter/material.dart';

class StatisticsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Statistics"),
        automaticallyImplyLeading: false,
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
