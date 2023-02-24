import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/UiElements/widget.dart';
import 'package:savepy/app/modules/auth/views/login_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controller/myprofile_controller.dart';

class MyProfile extends GetView<MyProfileController> {
  MyProfileController myProfileController = Get.put(MyProfileController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff004C88),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                {
                  Scaffold.of(context).openDrawer();
                }
              }),
          title: const Text("Profile"),
        ),
        body: Obx(
            (){
              return Container(
                color: Colors.white,
                height: height *0.9,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20.0,right: 20.0, top: height * 0.12,bottom: height * 0.03 ),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),

                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(20,20,20,20),
                                          child: Column(
                                            children: [

                                              SizedBox(
                                                height: height * 0.07,
                                              ),
                                              textWidget("${myProfileController.user.value?.userProfileData?.firstName} ${myProfileController.user.value?.userProfileData?.lastName}", 16, FontWeight.bold, 'Lato',
                                                  0xff000000, '', false),
                                              SizedBox(
                                                height: height * 0.00,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                child: textWidget("${myProfileController.user.value?.userProfileData?.fldAddress}", 12, FontWeight.bold, 'Lato',
                                                    0xffC0C0C0, '', false),
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                child: Row(

                                                  children: [
                                                    textWidget("Email:", 12, FontWeight.bold, 'Lato',
                                                        0xff000000, '', false),
                                                    Spacer(),
                                                    textWidget("${myProfileController.user.value?.userProfileData?.email}", 12, FontWeight.bold, 'Lato',
                                                        0xffC0C0C0, '', false),

                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                child: Row(

                                                  children: [
                                                    textWidget("Phone:", 12, FontWeight.bold, 'Lato',
                                                        0xff000000, '', false),
                                                    Spacer(),
                                                    textWidget("${myProfileController.user.value?.userProfileData?.fldMobile}", 12, FontWeight.bold, 'Lato',
                                                        0xffC0C0C0, '', false),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              // Padding(
                                              //   padding: EdgeInsets.fromLTRB(0,0,0,0),
                                              //   child: Row(
                                              //
                                              //     children: [
                                              //       textWidget("Phone:", 12, FontWeight.bold, 'Lato',
                                              //           0xff000000, '', false),
                                              //       Spacer(),
                                              //       textWidget("${myProfileController.user.value?.userProfileData?.fldMobile}", 12, FontWeight.bold, 'Lato',
                                              //           0xffC0C0C0, '', false),
                                              //
                                              //     ],
                                              //   ),
                                              // ),
                                              // SizedBox(
                                              //   height: height * 0.01,
                                              // ),


                                              // Material(
                                              //   child: InkWell(
                                              //     borderRadius: BorderRadius.circular(4),
                                              //     splashColor: Color(0xff0864B1),
                                              //     onDoubleTap: () {
                                              //       // Navigator.push(context,
                                              //       //     MaterialPageRoute(builder: (context) => NoQuery()));
                                              //     },
                                              //     onTap: () {
                                              //       // Navigator.push(context,
                                              //       //     MaterialPageRoute(builder: (context) => MyQuery()));
                                              //       // myProfileController.erase();
                                              //       // Get.offAll(LoginView());
                                              //       Get.defaultDialog(
                                              //           title: "LogOut",
                                              //           textCancel: "No",
                                              //           textConfirm: "Yes",
                                              //           onCancel: (){
                                              //             // navigator.pop();
                                              //           },
                                              //           onConfirm: (){
                                              //             myProfileController.erase();
                                              //             // Get.put(LoginController());
                                              //             // Get.offAll(() => LoginView());
                                              //             Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                              //                 LoginView()), (Route<dynamic> route) => false);
                                              //             // Navigator.push(
                                              //             //     context,
                                              //             //     MaterialPageRoute(
                                              //             //         builder: (context) =>
                                              //             //             LoginView()));
                                              //             // Get.offAll(LoginView());
                                              //           },
                                              //           middleText: "Are you sure you want to logout?".tr
                                              //
                                              //       );
                                              //
                                              //     },
                                              //     child: Padding(
                                              //       padding: EdgeInsets.only(
                                              //           left: 24.0,
                                              //           top: height * 0.05,
                                              //           right: 24,
                                              //           bottom: height * 0.05),
                                              //       child: Row(
                                              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //         children: [
                                              //           Row(
                                              //             children: [
                                              //               // SvgPicture.asset('assets/images/logouticon.svg'),
                                              //               SizedBox(
                                              //                 width: 15,
                                              //               ),
                                              //               textWidget("Logout", 16, FontWeight.normal, 'Lato',
                                              //                   0xff000000, '', false),
                                              //             ],
                                              //           ),
                                              //           Icon(
                                              //             Icons.arrow_forward_ios,
                                              //             size: 15,
                                              //           )
                                              //         ],
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Spacer(),
                                            InkWell(
                                              onTap: (){
                                                Get.defaultDialog(
                                                    title: "Delete my Account?",
                                                    textCancel: "No",
                                                    textConfirm: "Yes",
                                                    onCancel: (){
                                                      // navigator.pop();
                                                    },
                                                    buttonColor: Color(0xff004C88),
                                                    confirmTextColor: Colors.white,
                                                    cancelTextColor: Color(0xff004C88),
                                                    onConfirm: (){
                                                      myProfileController.deleteUser().whenComplete(() => myProfileController.erase()).whenComplete(() =>
                                                          Navigator.of(context).pushAndRemoveUntil(
                                                              MaterialPageRoute(builder: (context) =>
                                                                  LoginView()), (Route<dynamic> route) => false));

                                                      // Get.put(LoginController());
                                                      // Get.offAll(() => LoginView());

                                                      // Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             LoginView()));
                                                      // Get.offAll(LoginView());
                                                    },
                                                    middleText: "Once your request is submitted our team will review that you don't have any payment due in the group(s) you are associated with. Your account and all related data will be deleted within 30 days and you will get the update on your registered email. Are you sure you want to delete your account?"

                                                );
                                              },
                                              child: textWidget("Delete my account", 16, FontWeight.bold, 'Lato',
                                                  0xff000000, 'e', true),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Positioned(
                                  //     top: 10, right: 10, //give the values according to your requirement
                                  //     child: CircleAvatar(
                                  //       radius: 15,
                                  //       backgroundColor: HexColor(blue_color),
                                  //       child: Icon(Icons.edit,color: Colors.white,size: 18,),
                                  //       // backgroundImage: NetworkImage("${myProfileController.user.value?.userProfileData?.fldProfilePic}",),
                                  //       // AssetImage("assets/images/demoimage.png"),
                                  //     )
                                  // ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 24.0,right: 24.0, top: height * 0.05,bottom: 0 ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [

                                  SizedBox(
                                    width: 10,
                                  ),
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      (!["", null, false, 0,].contains(myProfileController.user.value?.userProfileData?.fldProfilePic)) ?
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage("${myProfileController.user.value?.userProfileData?.fldProfilePic}",),
                                        // AssetImage("assets/images/demoimage.png"),
                                      ):
                                      ClipOval(
                                        child:Image.asset("assets/images/profile_pic.png",
                                          height: 100,
                                          width: 100,
                                          fit:BoxFit.fitWidth,),
                                      ),
                                      // Positioned(
                                      //   bottom: 2, right: 2, //give the values according to your requirement
                                      //   child: Icon(Icons.edit,color: HexColor(blue_color),),
                                      // ),
                                      // Positioned(
                                      //     bottom: 2, right: 0, //give the values according to your requirement
                                      //     child: CircleAvatar(
                                      //       radius: 20,
                                      //       backgroundColor: Colors.grey[300],
                                      //       child: Icon(Icons.image,color: Colors.white,),
                                      //       // backgroundImage: NetworkImage("${myProfileController.user.value?.userProfileData?.fldProfilePic}",),
                                      //       // AssetImage("assets/images/demoimage.png"),
                                      //     )
                                      // ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),

                                ],
                              ),
                            ),
                          ],
                        )
                    )
                  ],
                ),
              );
            }
        ),
        bottomSheet: Container(
          color: Colors.white,
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child:Container(
                color: Colors.white,
                width: Get.width * 0.9,
                alignment: Alignment.center,
                height: 50,
                child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    splashColor: Colors.grey,
                    onTap: () {
                      Get.defaultDialog(
                          title: "LogOut",
                          textCancel: "No",
                          textConfirm: "Yes",
                          onCancel: (){
                            // navigator.pop();
                          },
                          buttonColor: Color(0xff004C88),
                          confirmTextColor: Colors.white,
                          cancelTextColor: Color(0xff004C88),
                          onConfirm: (){
                            myProfileController.erase();
                            // Get.put(LoginController());
                            // Get.offAll(() => LoginView());
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) =>
                                LoginView()), (Route<dynamic> route) => false);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             LoginView()));
                            // Get.offAll(LoginView());
                          },
                          middleText: "Are you sure you want to logout?"

                      );
                    },
                    child: Center(
                      child: Container(

                        width: Get.width * 0.9,
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xff004C88),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.black)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 24.0,right: 24.0, top: 0,bottom: 0 ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.exit_to_app,color: Colors.white,size: 18,),
                              SizedBox(
                                width: 20,
                              ),
                              textWidget('Sign out'.tr, 16, FontWeight.bold,
                                  'Lato', 0xffFFFFFF, '', false),
                            ],
                          ),
                        ),
                      ),
                    )
                ),
              )
          ),
        )
    );
  }
}
