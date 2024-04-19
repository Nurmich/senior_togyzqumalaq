import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nurmukhammed_s_application4/core/app_export.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfilePage extends StatelessWidget {
  final storage = FlutterSecureStorage();
  String defaultImg = 'http://192.168.0.117/media/users/no-user.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text("Profile",
              style: TextStyle(fontSize: 24, color: Colors.white)),
        ),
        backgroundColor: Color(0xFFC57941),
      ),
      body: FutureBuilder<Map<String, String?>>(
        future: getUserData(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, String?>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var userData = snapshot.data!;
            var userImage = userData['image'];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 80.v),
                Center(
                  child: ClipOval(
                    child: Image.network(
                      userImage ?? defaultImg,
                      width: 170.h,
                      height: 170.v,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 40.v),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Information',
                        style: theme.textTheme.headline6,
                      ),
                      SizedBox(height: 20.v),
                      ListTile(
                        title: Text(
                          'Username',
                          style: theme.textTheme.subtitle1
                              ?.copyWith(color: Color(0xFFC57941)),
                        ),
                        subtitle: Text(
                          userData['username'] ?? 'N/A',
                          style: theme.textTheme.bodyText1,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'First Name',
                          style: theme.textTheme.subtitle1
                              ?.copyWith(color: Color(0xFFC57941)),
                        ),
                        subtitle: Text(
                          userData['firstName'] ?? 'N/A',
                          style: theme.textTheme.bodyText1,
                        ),
                      ),
                      ListTile(
                        title: Text(
                          'Last Name',
                          style: theme.textTheme.subtitle1
                              ?.copyWith(color: Color(0xFFC57941)),
                        ),
                        subtitle: Text(
                          userData['lastName'] ?? 'N/A',
                          style: theme.textTheme.bodyText1,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 140.v),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _logout(context);
                    },
                    child: Container(
                      height: 60.v,
                      width: 120.h, // Adjusted width of the logout button
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.h),
                        gradient: LinearGradient(
                          begin: Alignment(-0.5, 0.5),
                          end: Alignment(0.5, 1.5),
                          colors: [
                            appTheme.orange200,
                            appTheme.red300,
                          ],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Logout",
                          style: theme.textTheme.button
                              ?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
    await storage.delete(key: 'userId');
    await storage.delete(key: 'username');
    await storage.delete(key: 'firstName');
    await storage.delete(key: 'lastName');
    await storage.delete(key: 'image');

    print(storage.readAll());

    // Navigate to the login screen
    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
      AppRoutes.loginScreen,
      (route) => false,
    );
  }

  Future<Map<String, String?>> getUserData() async {
    // Retrieve user data from storage
    String? id = await storage.read(key: 'userId');
    String? username = await storage.read(key: 'username');
    String? firstName = await storage.read(key: 'firstName');
    String? lastName = await storage.read(key: 'lastName');
    String? userImg = await storage.read(key: 'image');

    // Return the user data as a map
    return {
      'id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'image': userImg,
    };
  }
}
