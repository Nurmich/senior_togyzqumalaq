import 'package:flutter/material.dart';
import 'package:nurmukhammed_s_application4/widgets/custom_text_form_field.dart';
import 'package:nurmukhammed_s_application4/widgets/custom_icon_button.dart';
import 'package:nurmukhammed_s_application4/core/app_export.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final storage = FlutterSecureStorage();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press
        // Return false to block the navigation to the splash screen
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    CustomImageView(
                      fit: BoxFit.cover,
                      imagePath: ImageConstant.imgGraphics,
                      height: 370.h,
                      width: 440.v,
                    ),
                    SizedBox(height: 29.v),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 68.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome Back!",
                                  style: theme.textTheme.titleLarge,
                                ),
                                SizedBox(height: 12.v),
                                Text(
                                  "Login to continue battle!",
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.v),
                    Padding(
                      padding: EdgeInsets.only(left: 68.h),
                      child: CustomTextFormField(
                        width: 273.h,
                        controller: usernameController,
                        hintText: "Username",
                        alignment: Alignment.centerLeft,
                        focusNode: emailFocus,
                      ),
                    ),
                    SizedBox(height: 23.v),
                    Padding(
                      padding: EdgeInsets.only(left: 68.h),
                      child: CustomTextFormField(
                        width: 273.h,
                        controller: passwordController,
                        hintText: "Password",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        alignment: Alignment.centerLeft,
                        focusNode: passwordFocus,
                        obscureText: true,
                      ),
                    ),
                    SizedBox(height: 8.v),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 88.h),
                        child: Text(
                          "Forgot Password?",
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ),
                    SizedBox(height: 27.v),
                    GestureDetector(
                      onTap: () {
                        login(context);
                      },
                      child: SizedBox(
                        height: 60.v,
                        width: 232.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 60.v,
                                width: 218.h,
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
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Let’s Combat!",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 23.v),
                    Text(
                      "Connect With:",
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.labelLargeRed400,
                    ),
                    SizedBox(height: 7.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconButton(
                          height: 35.v,
                          width: 36.h,
                          padding: EdgeInsets.all(10.h),
                          child: CustomImageView(
                            imagePath: ImageConstant.imgUpload,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.h),
                          child: CustomIconButton(
                            height: 35.v,
                            width: 36.h,
                            padding: EdgeInsets.all(12.h),
                            decoration: IconButtonStyleHelper.fillBlue,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgFacebook,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.v),
                    GestureDetector(
                      onTap: () {
                        onTapTxtDonthaveanaccount(context);
                      },
                      child: Container(
                        width: 306.h,
                        margin: EdgeInsets.only(left: 56.h, right: 67.h),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Don’t have an account?",
                                style: CustomTextStyles.bodySmallff030303,
                              ),
                              TextSpan(
                                text: " \n",
                                style: CustomTextStyles.bodySmallff4ba7f3,
                              ),
                              TextSpan(
                                text: "Create Account",
                                style: CustomTextStyles.labelLargeffc57941,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.v),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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

  Future<void> login(BuildContext context) async {
    var url = Uri.parse('http://192.168.0.117/login/');
    try {
      var response = await http.post(
        url,
        body: {
          'username': usernameController.text,
          'password': passwordController.text,
        },
      );
      if (response.statusCode == 200) {
        var token = json.decode(response.body)['access'];
        await storage.write(key: 'token', value: token);

        var userDataResponse = await fetchUserData();
        var userId = userDataResponse['id'].toString(); // Convert to string
        var username = userDataResponse['username'];
        var firstName = userDataResponse['first_name'];
        var lastName = userDataResponse['last_name'];
        var userImg = userDataResponse['image'];

        // Save user data to storage with separate keys
        await storage.write(key: 'userId', value: userId);
        await storage.write(key: 'username', value: username);
        await storage.write(key: 'firstName', value: firstName);
        await storage.write(key: 'lastName', value: lastName);
        await storage.write(key: 'image', value: userImg);

        Navigator.of(context)
            .pushReplacementNamed(AppRoutes.landingScreenContainerScreen);
      } else {
        print('Failed to log in');
        _showErrorDialog(context, 'Failed to log in');
      }
    } catch (e) {
      print('Error occurred while logging in: $e');
      _showErrorDialog(context, e.toString());
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  onTapTxtDonthaveanaccount(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.createAccountScreen);
  }
}
