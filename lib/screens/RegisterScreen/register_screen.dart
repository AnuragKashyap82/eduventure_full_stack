import 'package:eduventure_nodejs/screens/RegisterScreen/apis/regester_apis.dart';
import 'package:eduventure_nodejs/screens/HomeScreen/home_page.dart';
import 'package:eduventure_nodejs/screens/LoginScreen/login_screen.dart';
import 'package:eduventure_nodejs/utils/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../utils/colors.dart';
import '../VerifyUniqueIdScreen/apis/apis.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  VerifyUniqueIdApis apis = Get.find();
  RegisterApi registerApi = Get.put(RegisterApi());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  bool _isPasswordVisible = true;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _cPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController =
        TextEditingController(text: apis.email.toString());

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorWhite,
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
                  "Create an Account",
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
                  "Create an account to be able to learn everything online and boost your knowledge",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 16,
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
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: "Enter your Name",
                                hintStyle: TextStyle(color: colorPrimary),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
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
                              enabled: false,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: "Enter your Email",
                                hintStyle: TextStyle(color: colorPrimary),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
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
                              textInputAction: TextInputAction.next,
                              obscureText: _isPasswordVisible,
                              controller: _passwordController,
                              decoration: InputDecoration(
                                hintText: "Enter your password",
                                hintStyle: TextStyle(color: colorPrimary),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() => _isPasswordVisible =
                                        !_isPasswordVisible);
                                  },
                                  icon: _isPasswordVisible
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
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
                              controller: _cPasswordController,
                              decoration: InputDecoration(
                                hintText: "Confirm your Password",
                                hintStyle: TextStyle(color: colorPrimary),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() => _isPasswordVisible =
                                        !_isPasswordVisible);
                                  },
                                  icon: _isPasswordVisible
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 42.0,
                        ),
                        Obx(() {
                          return SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_nameController.text.trim().isEmpty) {
                                  showSnackBar("Enter Your Name", context);
                                } else if (_nameController.text
                                    .trim()
                                    .isEmpty) {
                                  showSnackBar("Enter Your Name", context);
                                } else if (_passwordController.text
                                    .length < 8) {
                                  showSnackBar(" Password must be of 8 char", context);
                                } else if (_passwordController.text.trim() !=
                                    _cPasswordController.text.trim()) {
                                  showSnackBar(
                                      "Password doesn't match", context);
                                } else {
                                  final message = await registerApi.register(
                                      apis.email.toString(),
                                      _passwordController.text.trim(),
                                      _nameController.text.trim(),
                                      apis.userType.toString(),
                                      apis.studentId.toString());
                                  if(message['status']){
                                    Navigator.pushReplacement(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (_) => LoginScreen(),
                                            maintainState: false));
                                  }else{
                                    showSnackBar("${message['msg']}", context);
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: StadiumBorder(),
                                  elevation: 0,
                                  backgroundColor: colorPrimary),
                              child: registerApi.isLoading.value
                                  ? CircularProgressIndicator(
                                      color: colorWhite,
                                      strokeWidth: 2,
                                    )
                                  : Text(
                                      "Sign Up",
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
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Already have an account?",
                            style: TextStyle(
                              color: colorBlack,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: " Sign In",
                                style: TextStyle(
                                  color: colorPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
