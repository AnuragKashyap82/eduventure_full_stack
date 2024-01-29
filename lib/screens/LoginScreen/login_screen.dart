import 'package:eduventure_nodejs/apis/apis.dart';
import 'package:eduventure_nodejs/screens/LoginScreen/apis/login_apis.dart';
import 'package:eduventure_nodejs/screens/forgot_password_screen.dart';
import 'package:eduventure_nodejs/screens/VerifyUniqueIdScreen/verify_unique_id_screen.dart';
import 'package:eduventure_nodejs/screens/HomeScreen/home_page.dart';
import 'package:eduventure_nodejs/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginApis loginApis = Get.put(LoginApis());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          backgroundColor: colorPrimary,
        ),
      ),
      body: Container(
        padding: MediaQuery.of(context).size.width > webScreenSize
            ? EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 3)
            : const EdgeInsets.symmetric(horizontal: 0),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 80,
                ),
                Text(
                  "Welcome Back!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: colorPrimary,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Nice to meet you! please login to access \nand start learning to gain your knowledge",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Form(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 52,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: gray02,
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: Center(
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: "anurag@kashyap.com",
                                hintStyle: TextStyle(color: colorPrimary),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: 52,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: gray02,
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: Center(
                            child: TextFormField(
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              obscureText: _isPasswordVisible,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                hintText: "Enter your Password",
                                hintStyle: TextStyle(color: colorPrimary),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(
                                          () => _isPasswordVisible =
                                      !_isPasswordVisible,
                                    );
                                  },
                                  icon: _isPasswordVisible
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () async {
                                  Apis().launchEmail();
                                },
                                child: Text(
                                  "Need Help?",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                    ),
                                    context: context,
                                    builder: (context) => Container(
                                      padding: const EdgeInsets.all(30.0),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Forgot Password",
                                            style: TextStyle(
                                              color: colorBlack,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            "Select one of the options given below to reset your password",
                                            style: TextStyle(
                                              color: colorBlack,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.0,
                                          ),
                                          GestureDetector(
                                            onTap: () => {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgotPasswordScreen(),
                                                ),
                                              )
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(20.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.mail_outline_rounded,
                                                    size: 60,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Email",
                                                        style: TextStyle(
                                                          color: colorBlack,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Rest via E-mail Verification",
                                                        style: TextStyle(
                                                          color: colorBlack,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                              padding: const EdgeInsets.all(20.0),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.mobile_friendly_rounded,
                                                    size: 60,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Phone No.",
                                                        style: TextStyle(
                                                          color: colorBlack,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                      Text(
                                                        "Rest via Phone Verification",
                                                        style: TextStyle(
                                                          color: colorBlack,
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Obx(() {
                          return  SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () async{
                                if(_emailController.text.isEmpty){
                                  showSnackBar("Enter your Email", context);
                                }else if(_passwordController.text.length < 8){
                                  showSnackBar("Password must be 8 char", context);
                                }else{
                                  final message = await loginApis.login(_emailController.text.trim(), _passwordController.text.trim());
                                  if(message['status']){
                                   await loginApis.saveToken(message['token']);

                                    showSnackBar("Login successfully", context);
                                    Navigator.pushReplacement(
                                        context, MaterialPageRoute(builder: (context) =>  HomeScreen(), maintainState: false,));
                                  }else{
                                    showSnackBar("${message['msg']}", context);
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(),
                                  backgroundColor: colorPrimary,
                                  elevation: 0
                              ),
                              child: loginApis.isLoading.value
                                  ? CircularProgressIndicator(
                                color: colorWhite,
                                strokeWidth: 2,
                              )
                                  : Text(
                                "Login",
                                style: TextStyle(
                                  color: colorWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        })

                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 16,
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VerifyUniqueIdScreen(),
                          ),
                        );
                      },
                      child: Text.rich(
                        TextSpan(
                          text: "Don't have an account?",
                          style: TextStyle(
                            color: colorBlack,
                            fontWeight: FontWeight.w400,
                          ),
                          children:  [
                            TextSpan(
                              text: " Sign Up",
                              style: TextStyle(
                                color: colorPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
