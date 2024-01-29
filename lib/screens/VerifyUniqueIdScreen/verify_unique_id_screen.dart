import 'package:eduventure_nodejs/apis/apis.dart';
import 'package:eduventure_nodejs/screens/VerifyUniqueIdScreen/apis/apis.dart';
import 'package:eduventure_nodejs/screens/RegisterScreen/register_screen.dart';
import 'package:eduventure_nodejs/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../utils/colors.dart';

class VerifyUniqueIdScreen extends StatefulWidget {
  const VerifyUniqueIdScreen({Key? key}) : super(key: key);

  @override
  State<VerifyUniqueIdScreen> createState() => _VerifyUniqueIdScreenState();
}

class _VerifyUniqueIdScreenState extends State<VerifyUniqueIdScreen> {
  VerifyUniqueIdApis apis = Get.put(VerifyUniqueIdApis());
  TextEditingController _uniqueId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorWhite,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: colorWhite,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: colorBlack),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3)
              : const EdgeInsets.symmetric(horizontal: 0),
          child: SingleChildScrollView(
            child: Obx(() {
              return Container(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Verify your student id",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                        color: colorPrimary,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    const Text(
                      "First verify your student id to register in Eduventure",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                      textAlign: TextAlign.start,
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
                                  borderRadius: BorderRadius.circular(26)),
                              child: Center(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: _uniqueId,
                                  decoration:  InputDecoration(
                                    hintText: "Enter your Student Id",
                                    hintStyle: TextStyle(color: colorPrimary),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () async{
                                  if(_uniqueId.text.isNotEmpty){
                                    String message = await apis.VerifyUniqueId(_uniqueId.text.trim());
                                    showSnackBar(message, context);
                                  }else{
                                    showSnackBar("Enter Student Id", context);
                                  }

                                },
                                style: ElevatedButton.styleFrom(
                                    shape: StadiumBorder(), backgroundColor: colorPrimary, elevation: 0),
                                child: apis.isLoading.value
                                    ? CircularProgressIndicator(
                                  color: colorWhite,
                                  strokeWidth: 2,
                                )
                                    : Text(
                                  "Verify",
                                  style: TextStyle(
                                      color: colorWhite,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 52,
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                      color: gray02,
                                      borderRadius: BorderRadius.circular(26)),
                                  child: Center(
                                    child: apis.email.value != ''?Text(
                                      "${apis.email.value}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ):Text(
                                      "Student Id Not Verified",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ),
                                ),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 52,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if(apis.email.value != ''){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => RegisterScreen(
                                            ),
                                          ),
                                        );
                                      }else{
                                        showSnackBar("Verify your Id first", context);
                                      }

                                    },
                                    style: ElevatedButton.styleFrom(
                                        shape: StadiumBorder(), backgroundColor: colorPrimary, elevation: 0),
                                    child: Text(
                                      "Next",
                                      style: TextStyle(
                                          color: colorWhite,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () async {
                            Apis().launchEmail();
                          },
                          child:  Text.rich(TextSpan(
                              text:
                              "In case you face any difficulty in verifying your student id. kindly contact us",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                              children: [
                                TextSpan(
                                    text: " Need Help",
                                    style: TextStyle(
                                        color: colorPrimary,
                                        fontWeight: FontWeight.w600))
                              ])),
                        ),
                      ],
                    )
                  ],
                ),
              );

            })
          ),
        ),
      ),
    );
  }
}
