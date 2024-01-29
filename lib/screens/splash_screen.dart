import 'dart:async';
import 'package:eduventure_nodejs/screens/LoginScreen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';
import '../utils/global_variables.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool _isLoading = false;

  checkIsLoggedIn() async {
    Timer(Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
       SystemUiOverlayStyle(statusBarColor: colorWhite).copyWith(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark),
    );

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          backgroundColor: colorWhite,
        ),
      ),
      body: _isLoading
          ? CircularProgressIndicator(
              color: colorPrimary,
              strokeWidth: 2,
            )
          : Container(
              height: double.infinity,
              width: double.infinity,
              color: colorWhite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(200),
                          child: Image.asset("assets/images/logo.png", ))
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  Text(
                    "Eduventure",
                    style: TextStyle(
                        color: colorBlack.withOpacity(0.87),
                        fontSize: 25, fontWeight: FontWeight.w500),
                  )
                ],
              )),
    );
  }
}
