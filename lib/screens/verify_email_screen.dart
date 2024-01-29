import 'package:eduventure_nodejs/screens/LoginScreen/login_screen.dart';
import 'package:eduventure_nodejs/utils/colors.dart';
import 'package:flutter/material.dart';

import '../utils/global_variables.dart';
import 'HomeScreen/home_page.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool _isLoadingDetails = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loadUserDetails();
  }
  // void sendVerificationEmail() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user != null && !user.emailVerified) {
  //     await user.sendEmailVerification();
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(builder: (context) => VerifyEmailScreen()),
  //     );
  //   }
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // void loadUserDetails() async {
  //   setState(() {
  //     _isLoadingDetails = true;
  //   });
  //   try {
  //     var sellerSnap = await FirebaseFirestore.instance
  //         .collection("users")
  //         .doc(FirebaseAuth.instance.currentUser?.uid)
  //         .get();
  //     if (sellerSnap.exists) {
  //       setState(() {
  //         _isLoadingDetails = false;
  //       });
  //       setState(() {
  //         _userData = sellerSnap.data()!;
  //       });
  //       if (FirebaseAuth.instance.currentUser!.emailVerified) {
  //         Navigator.pushReplacement(
  //             context, MaterialPageRoute(builder: (context) => HomeScreen(),  maintainState: false));
  //       } else {
  //         setState(() {
  //           _isLoadingDetails = false;
  //         });
  //       }
  //     } else {}
  //   } catch (e) {
  //     showSnackBar(e.toString(), context);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isLoadingDetails
            ? Center(
                child: CircularProgressIndicator(
                color: colorPrimary,
                strokeWidth: 1,
              ))
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       Text(
                        "Email is not verified!!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: colorBlack,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                       Text(
                        "Verification Email has been sent to your registered Email, verify from there then you can be logged in",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w100,
                          color: colorBlack.withOpacity(0.54),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: (){
                          // sendVerificationEmail();
                        },
                        child: Text(
                          "Email: ${['email']}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w100,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          onPressed: () async {
            // FirebaseAuth.instance.signOut().then((value) {
            //   Navigator.pushReplacement(
            //       context, MaterialPageRoute(builder: (_) => LoginScreen(),  maintainState: false));
            // });
          },
          backgroundColor: colorPrimary,
          elevation: 0,
          child: Icon(
            Icons.logout,
            color: colorWhite,
          ),
        ),
      ),
    );
  }
}
