import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/UiElements/size_config.dart';
import 'package:savepy/app/modules/auth/views/login_view.dart';
import 'package:savepy/app/modules/landing_page/controller/landing_controller.dart';
import 'package:savepy/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  final LandingPageController landingPageController = Get.put(LandingPageController(), permanent: false);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      width: SizeConfig.screenWidth*0.7,
      child: Container(
        child: Stack(
          children: [
            Container(
              // height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xff004C88), Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.2, 0.7],
                  tileMode: TileMode.repeated,
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                height: 180,
                width: SizeConfig.screenWidth*0.7,
                // color: Color(0xff004C88),
                child: Center(
                  child: Image.asset(
                    "assets/images/logo_white.png",
                    height: 86,
                    width: 151,
                    fit:BoxFit.fitWidth,),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 180, left: 0, right: 0, bottom: 0),
              child: ListView(
                children: [
                  // buildDrawerHeader(),
                  buildDrawerItem(
                    widget: SvgPicture.asset(
                      'assets/images/home.svg',
                      color: Colors.black,
                    ),
                    text: "Home",
                    onTap: () => navigate(0),
                    tileColor: Get.currentRoute == Routes.HOME ? Colors.blue : null,
                    textIconColor: Get.currentRoute == Routes.HOME
                        ? Colors.white
                        : Colors.black,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  buildDrawerItem(
                    widget: SvgPicture.asset(
                      width:20,
                      height: 20,
                      'assets/images/group.svg',
                      color: Colors.black,
                    ),
                    text: "My Groups",
                    onTap: () => navigate(1),
                    tileColor: Get.currentRoute == Routes.MYGROUPS ? Colors.blue : null,
                    textIconColor: Get.currentRoute == Routes.MYGROUPS
                        ? Colors.white
                        : Colors.black,
                  ),
                  Divider(
                    color: Colors.black,
                  ),
                  buildDrawerItem(
                      widget: SvgPicture.asset(
                        'assets/images/profile.svg',
                        color: Colors.black,
                      ),
                      text: "My Members",
                      onTap: () => navigate(2),
                      tileColor: Get.currentRoute == Routes.MYMEMBERS ? Colors.blue : null,
                      textIconColor: Get.currentRoute == Routes.MYMEMBERS
                          ? Colors.white
                          : Colors.black),
                  Divider(
                    color: Colors.black,
                  ),
                  buildDrawerItem(
                      widget: SvgPicture.asset(
                        'assets/images/profile.svg',
                        color: Colors.black,
                      ),
                      text: "My Profile",
                      onTap: () => navigate(3),
                      tileColor: Get.currentRoute == Routes.MYPROFILE ? Colors.blue : null,
                      textIconColor: Get.currentRoute == Routes.MYPROFILE
                          ? Colors.white
                          : Colors.black),
                  Divider(
                    color: Colors.black,
                  ),
                  buildDrawerItem(
                      widget: SvgPicture.asset(
                        'assets/images/payment.svg',
                        color: Colors.black,
                      ),
                      text: "Payment History",
                      onTap: () => navigate(4),
                      tileColor: Get.currentRoute == Routes.PAYMENTHISTORY ? Colors.blue : null,
                      textIconColor: Get.currentRoute == Routes.PAYMENTHISTORY
                          ? Colors.white
                          : Colors.black),
                  Divider(
                    color: Colors.black,
                  ),
                  buildDrawerItem(
                      widget: Icon(Icons.exit_to_app,color: Colors.black,size: 18,),
                      text: "Log Out",
                      onTap: () => navigate(5),
                      tileColor: Get.currentRoute == Routes.PAYMENTHISTORY ? Colors.blue : null,
                      textIconColor: Get.currentRoute == Routes.PAYMENTHISTORY
                          ? Colors.white
                          : Colors.black),
                  Divider(
                    color: Colors.black,
                  ),

                ],
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget buildDrawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text("Ripples Code"),
      accountEmail: Text("ripplescode@gmail.com"),
      currentAccountPicture: CircleAvatar(
        backgroundImage: AssetImage('image/logo.jpg'),
      ),
      currentAccountPictureSize: Size.square(72),
      otherAccountsPictures: [
        CircleAvatar(
          backgroundColor: Colors.white,
          child: Text("RC"),
        )
      ],
      otherAccountsPicturesSize: Size.square(50),
    );
  }

  Widget buildDrawerItem({
    required String text,
    required Widget widget,
    required Color textIconColor,
    required Color? tileColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: widget,
      title: Text(
        text,
        style: TextStyle(color: textIconColor),
      ),
      tileColor: tileColor,
      onTap: onTap,
    );
  }

  navigate(int index) {
    if (index == 0) {
      Get.back();
    }
    else if (index == 1) {
      Get.toNamed(Routes.MYGROUPS);
    }
    if (index == 2) {
      Get.toNamed(Routes.MYMEMBERS);
    }
    if (index == 3) {
      Get.back();
      landingPageController.tabIndex.value=3;
      // Get.toNamed(Routes.MYPROFILE);
    }
    if (index == 4) {
      Get.back();
      landingPageController.tabIndex.value=1;
      // Get.toNamed(Routes.PAYMENTHISTORY);
    }
    if (index == 5) {
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
            erase();
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
    }

  }

  Future erase() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getKeys();
    // String lang = preferences.getString('langkey');
    // for (String key in preferences.getKeys()) {
    //   if (key != "lat" &&
    //       key != "long" &&
    //       key != "langbool" && key != "langkey" &&
    //       key != "seen"
    //       ) {
    //     preferences.remove(key);
    //   }
    // }
    await preferences.clear();
  }
}
