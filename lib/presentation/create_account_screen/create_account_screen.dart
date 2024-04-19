import 'package:flutter/material.dart';
import 'package:nurmukhammed_s_application4/widgets/custom_text_form_field.dart';
import 'package:nurmukhammed_s_application4/widgets/custom_icon_button.dart';
import 'package:nurmukhammed_s_application4/core/app_export.dart';
import 'package:http/http.dart' as http;

class CreateAccountScreen extends StatefulWidget {
  CreateAccountScreen({Key? key}) : super(key: key);

  @override
  _CreateAccountScreenState createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  FocusNode firstNameFocus = FocusNode();
  FocusNode lastNameFocus = FocusNode();
  FocusNode usernameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode confirmPasswordFocus = FocusNode();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // firstname lastname username password password2

  @override
  void dispose() {
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    usernameFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: SizeUtils.width,
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 17.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: CustomImageView(
                      imagePath: ImageConstant.img61795511TracedRed400,
                      height: 156.v,
                      width: 394.h,
                    ),
                  ),
                  SizedBox(height: 27.v),
                  Padding(
                    padding: EdgeInsets.only(left: 50.h),
                    child: Text("Create Account",
                        style: theme.textTheme.titleLarge),
                  ),
                  SizedBox(height: 12.v),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 306.h,
                      margin: EdgeInsets.only(left: 50.h, right: 37.h),
                      child: Text(
                        "Fill in the form to proceed combat",
                        maxLines: null,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ),
                  SizedBox(height: 30.v),
                  _buildFirstName(context),
                  SizedBox(height: 30.v),
                  _buildLastName(context),
                  SizedBox(height: 30.v),
                  _buildUserName(context),
                  SizedBox(height: 30.v),
                  _buildPassword(context),
                  SizedBox(height: 30.v),
                  _buildConfirmpassword(context),
                  SizedBox(height: 40.v),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        onTapButton(context);
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
                                      appTheme.red300
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Create Account",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 23.v),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Connect With:",
                      textAlign: TextAlign.center,
                      style: CustomTextStyles.labelLargeRed400,
                    ),
                  ),
                  SizedBox(height: 7.v),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconButton(
                          height: 35.v,
                          width: 36.h,
                          padding: EdgeInsets.all(10.h),
                          child: CustomImageView(
                              imagePath: ImageConstant.imgUpload),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.h),
                          child: CustomIconButton(
                            height: 35.v,
                            width: 36.h,
                            padding: EdgeInsets.all(12.h),
                            decoration: IconButtonStyleHelper.fillBlue,
                            child: CustomImageView(
                                imagePath: ImageConstant.imgFacebook),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.v),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        onTapTxtAlreadyhavean(context);
                      },
                      child: Container(
                        width: 306.h,
                        margin: EdgeInsets.only(left: 38.h, right: 49.h),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Already have an account? \n",
                                style: CustomTextStyles.bodySmallff030303,
                              ),
                              TextSpan(
                                text: "Login",
                                style: CustomTextStyles.labelLargeffc57941,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
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
    );
  }

  Future<void> register(BuildContext context) async {
    var url = Uri.parse('http://192.168.0.193/register/');
    try {
      var response = await http.post(
        url,
        body: {
          'username': usernameController.text,
          'first_name': firstNameController.text,
          'last_name': lastNameController.text,
          'password': passwordController.text,
          'password2': confirmPasswordController.text,
        },
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        // Registration successful
        print('Account created successfully');
      } else {
        // Error handling
        print('Failed to create account');
      }
    } catch (e) {
      print('Error occurred while registering: $e');
    }
  }

  /// Section Widget
  Widget _buildFirstName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 48.h),
      child: CustomTextFormField(
        focusNode: firstNameFocus,
        width: 263.h,
        controller: firstNameController,
        hintText: "First Name",
      ),
    );
  }

  /// Section Widget
  Widget _buildLastName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 48.h),
      child: CustomTextFormField(
        focusNode: lastNameFocus,
        width: 263.h,
        controller: lastNameController,
        hintText: "Last Name",
      ),
    );
  }

  /// Section Widget
  Widget _buildUserName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 48.h),
      child: CustomTextFormField(
        focusNode: usernameFocus,
        width: 263.h,
        controller: usernameController,
        hintText: "User Name",
      ),
    );
  }

  /// Section Widget
  Widget _buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 48.h),
      child: CustomTextFormField(
        focusNode: passwordFocus,
        width: 263.h,
        controller: passwordController,
        hintText: "Password",
        textInputType: TextInputType.visiblePassword,
        obscureText: true,
      ),
    );
  }

  /// Section Widget
  Widget _buildConfirmpassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 48.h),
      child: CustomTextFormField(
        focusNode: confirmPasswordFocus,
        width: 263.h,
        controller: confirmPasswordController,
        hintText: "Confirm Password",
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        obscureText: true,
      ),
    );
  }

  /// Navigates to the landingScreenContainerScreen when the action is triggered.
  onTapButton(BuildContext context) {
    register(context);
    Navigator.pushNamed(context, AppRoutes.landingScreenContainerScreen);
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapTxtAlreadyhavean(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}
