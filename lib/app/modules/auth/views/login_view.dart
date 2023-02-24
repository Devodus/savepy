import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/UiElements/size_config.dart';
import 'package:savepy/app/UiElements/widget.dart';
import 'package:savepy/app/modules/auth/views/registration_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginController _loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 0, left: 20, right: 20),
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight,
              child: SingleChildScrollView(
                child: Form(
                  key: controller.loginFormKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Image.asset(
                        "assets/images/logo.png",
                        height: 100,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Login to continue",
                        style: heading(),
                      ),
                      // Visibility(
                      //   child: Container(
                      //     margin: EdgeInsets.fromLTRB(3,5,3,0),
                      //     height: 20,
                      //     width: 20,
                      //     child:
                      //     CircularProgressIndicator(
                      //       backgroundColor: HexColor(blue_color),
                      //       valueColor: AlwaysStoppedAnimation(Colors.blue),
                      //       strokeWidth: 3,
                      //     ),
                      //   ),
                      //   visible: flagIndicator,
                      // ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: controller.emailController,
                        keyboardType: TextInputType.text,
                        decoration: textFieldInputDecoration(
                            "Email Address", Icon(Icons.email_outlined)),
                        validator: (value) {
                          return controller.validateEmail(value!);
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: controller.passwordController,
                        keyboardType: TextInputType.text,
                        decoration:
                        textFieldInputDecoration("Password", Icon(Icons.key)),
                        validator: (value) {
                          return controller.validatePassword(value!);
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 17,
                      ),
                      GestureDetector(
                        onTap: () {
                          _loginController.checkLogin();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                colors: [
                                  HexColor(blue_color),
                                  HexColor(blue_color),
                                ],
                              )),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            "Login",
                            style: biggerTextStyle(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 17,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push( context,MaterialPageRoute(builder: (context) => RegistrationView()),);
                            },
                            child: Text(
                              "Registration",
                              style: TextStyle(
                                color: HexColor(blue_color),
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Obx(() => AbsorbPointer(
              child: Visibility(
                  visible: controller.isDataLoading.value,
                  child: Center(
                    child: CircularProgressIndicator(),
                  )
              ),
            ))

          ],
        )
      ),
    );
  }
}
