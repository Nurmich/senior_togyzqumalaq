import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nurmukhammed_s_application4/core/app_export.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// Import necessary packages for navigation and storage

class ProfilePage extends StatelessWidget {
  final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile",
            style: TextStyle(fontSize: 24, color: Colors.white)),
        backgroundColor: Color(0xFFC57941),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchUserData(), // Call the fetchUserData() method
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var userData = snapshot.data!;
            var firstName = userData['first_name'];
            var lastName = userData['last_name'];
            var username = userData['username'];

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Username: $username', style: TextStyle(fontSize: 24)),
                  Text('First Name: $firstName',
                      style: TextStyle(fontSize: 24)),
                  Text('Last Name: $lastName', style: TextStyle(fontSize: 24)),
                  // Add Logout button or other widgets as needed
                ],
              ),
            );
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }

  Future<void> _logout(BuildContext context) async {
    // Clear the token from shared preferences
    await storage.delete(key: 'token');

    // Navigate to the login screen
    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
      AppRoutes.loginScreen,
      (route) => false,
    );
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    var url = Uri.parse('http://192.168.0.193/userdata/');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // Handle errors, throw exception or return an empty map
      throw Exception('Failed to load user data');
    }
  }
}
