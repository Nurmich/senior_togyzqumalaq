import 'dart:ui';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nurmukhammed_s_application4/core/app_export.dart';
import '../game_vertical_screen/gamePage.dart';
import '../game_vertical_screen/gameOnline.dart';

class DifficultyButton extends StatelessWidget {
  final String title;
  final Color color;

  const DifficultyButton({
    Key? key,
    required this.title,
    required this.color,
  }) : super(key: key);
  int getDifficultyLevel() {
    switch (title) {
      case 'Easy':
        return 1;
      case 'Medium':
        return 2;
      case 'Hard':
        return 3;
      default:
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 70.0,
      margin: EdgeInsets.only(left: 65, right: 65, top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.transparent, width: 0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          Container(
            width: 20.0,
            height: 20.0,
            decoration: ShapeDecoration(
              shape: CircleBorder(side: BorderSide(color: color, width: 1)),
              color: Colors.white,
            ),
            child: IconButton(
              onPressed: () {
                int difficulty = getDifficultyLevel();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TogyzQumalaqGame(difficulty: difficulty),
                  ),
                );
              },
              focusColor: color,
              hoverColor: color,
              icon: Container(),
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              alignment: Alignment.center,
            ),
          ),
          SizedBox(height: 8), // Space between
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}

class LandingScreenPage extends StatefulWidget {
  const LandingScreenPage({Key? key}) : super(key: key);

  @override
  _LandingScreenPageState createState() => _LandingScreenPageState();
}

class RoundedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final String? userImage;

  const RoundedAppBar({
    Key? key,
    required this.title,
    required this.backgroundColor,
    this.userImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          SizedBox(width: 8), // Add spacing between username and user image
          if (userImage != null) // Check if userImage is not null
            CircleAvatar(
              backgroundImage: NetworkImage(userImage!), // Use userImage URL
            ),
        ],
      ),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(50),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

Future<void> showSearchingDialog(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false, // User must wait for 10 seconds
    barrierColor: Color(0xFFC57941).withOpacity(0.70),
    builder: (BuildContext context) {
      return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                'assets/images/earth.gif',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ), // Replace with Image.network if your GIF is hosted
              SizedBox(height: 20),
              Text(
                "Searching opponents...",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  decoration: TextDecoration.none,
                  fontFamily: 'Poppins',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
            ],
          ),
        ),
      );
    },
  );
  await Future.delayed(Duration(seconds: 7));
  // After 10 seconds, close the dialog and navigate
  Navigator.of(context).pop();
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TogyzQumalaqOnlineGame(),
    ),
  );
}

class _LandingScreenPageState extends State<LandingScreenPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    var url = Uri.parse('http://192.168.0.117/users/me');
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

  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Color(0xFFC57941).withOpacity(0.70),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Wrap(
            children: [
              Container(
                width: MediaQuery.of(buildContext).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Choose difficulty:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.fill
                          ..color = Colors.white,
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 28),
                    DifficultyButton(title: 'Easy', color: Colors.green),
                    DifficultyButton(title: 'Medium', color: Colors.yellow),
                    DifficultyButton(title: 'Hard', color: Colors.red),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xFFC57941),
              title: Text('Loading...'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Color(0xFFC57941),
              title: Text('Error'),
            ),
            body: Center(
              child: Text('Failed to load user data'),
            ),
          );
        } else {
          final userData = snapshot.data!;
          final username = userData['username'];
          final userImage = userData['image']; // Assuming image URL is provided

          return Scaffold(
            appBar: RoundedAppBar(
              title: username,
              backgroundColor: Color(0xFFC57941),
              userImage: userImage,
            ),
            body: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                left: 50.h,
                top: 140.v,
                right: 50.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Choose game mode",
                      style: theme.textTheme.titleLarge?.copyWith(fontSize: 28),
                    ),
                  ),

                  SizedBox(
                    height: 30.v,
                  ),

                  // Offline Section
                  GestureDetector(
                    onTap: () {
                      showCustomDialog(context);
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusStyle.circleBorder12,
                      ),
                      child: Container(
                        height: 169.v,
                        width: 315.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.h,
                          vertical: 11.v,
                        ),
                        decoration: AppDecoration.gradientOrangeAToRed.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder12,
                        ),
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgArrowLeft,
                              height: 9.v,
                              width: 14.h,
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.only(
                                left: 22.h,
                                bottom: 12.v,
                              ),
                            ),
                            Positioned(
                              left: 22.h,
                              top: 18.v,
                              child: Text(
                                "Offline",
                                style: theme.textTheme.labelLarge,
                              ),
                            ),
                            Positioned(
                              top: 45.v,
                              left: 22.h,
                              child: SizedBox(
                                width: 150.h,
                                child: Text(
                                  "Dive right into the offline mode and enjoy exciting gameplay against AI opponent",
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 22.v,
                              left: 170.h,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgHand1,
                                height: 100.v,
                                width: 150.h,
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Spacer between Offline and Online
                  SizedBox(height: 40.v),

                  // Online Section
                  GestureDetector(
                    onTap: () {
                      showSearchingDialog(context);
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusStyle.circleBorder12,
                      ),
                      child: Container(
                        height: 169.v,
                        width: 315.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.h,
                          vertical: 11.v,
                        ),
                        decoration: AppDecoration.gradientOrangeAToRed.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder12,
                        ),
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgArrowLeft,
                              height: 9.v,
                              width: 14.h,
                              alignment: Alignment.bottomLeft,
                              margin: EdgeInsets.only(
                                left: 22.h,
                                bottom: 12.v,
                              ),
                            ),
                            Positioned(
                              left: 22.h,
                              top: 18.v,
                              child: Text(
                                "Online",
                                style: theme.textTheme.labelLarge,
                              ),
                            ),
                            Positioned(
                              top: 45.v,
                              left: 22.h,
                              child: SizedBox(
                                width: 150.h,
                                child: Text(
                                  "Easily schedule event/games then find like minded players for battle. You up for it?",
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: CustomTextStyles.bodySmallWhiteA700,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 2.v,
                              left: 170.h,
                              child: CustomImageView(
                                imagePath: ImageConstant.imgGlobe1,
                                height: 139.adaptSize,
                                width: 139.adaptSize,
                                alignment: Alignment.centerRight,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 5.v),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
