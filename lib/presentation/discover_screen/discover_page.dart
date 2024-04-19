import 'package:flutter/material.dart';
import 'package:nurmukhammed_s_application4/core/app_export.dart';

class DiscoverPage extends StatelessWidget {
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
            "Discover",
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
        child: SingleChildScrollView(
          child: Container(
            height: 872.v,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstant.imgRules),
                fit: BoxFit.fill,
              ),
            ),
            margin: EdgeInsets.only(top: 30.v),
          ),
        ),
      ),
    );
  }
}
