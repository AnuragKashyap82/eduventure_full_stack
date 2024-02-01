import 'package:eduventure_nodejs/screens/LoginScreen/login_screen.dart';
import 'package:eduventure_nodejs/screens/HomeScreen/home_page.dart';
import 'package:eduventure_nodejs/utils/colors.dart';
import 'package:eduventure_nodejs/utils/custom_scrool_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// This widget is the root of your application.
  Future<Widget> checkLogin(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token') ?? ''; // Set default value as empty string
    if (token.isNotEmpty) {
      return HomeScreen();
    } else {
      return LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eduventure NodeJs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "NunitoSansSemiBold",
          useMaterial3: true,
          indicatorColor: colorPrimary,
          textSelectionTheme:  TextSelectionThemeData(
              cursorColor: colorPrimary,
              selectionColor: colorPrimary,
              selectionHandleColor: colorPrimary),
          appBarTheme:  AppBarTheme(
            surfaceTintColor: colorPrimary,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: colorPrimary,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.dark,
            ),
          )),
      scrollBehavior: MyCustomScrollBehavior(),
      home: FutureBuilder(
        future: checkLogin(context),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colorPrimary,
                ),
              ),
            );
          } else {
            return snapshot.data ?? LoginScreen(); // Return a default Scaffold if data is null
          }
        },
      ),
    );
  }
}
