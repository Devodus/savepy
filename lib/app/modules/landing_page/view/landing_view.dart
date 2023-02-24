import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/common/In_progress.dart';
import 'package:savepy/app/common/NoInternet.dart';
import 'package:savepy/app/common/navigation_drawer.dart';
import 'package:savepy/app/modules/home/views/home_view.dart';
import 'package:savepy/app/modules/landing_page/controller/landing_controller.dart';
import 'package:savepy/app/modules/my_profile/view/myprofile_view.dart';
import 'package:savepy/app/modules/payment_due/view/payment_due_view.dart';
import 'package:savepy/app/modules/payment_history/view/payment_histroy_view.dart';

class LandingPage extends StatelessWidget {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: HexColor(grey),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
  const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context, landingPageController) {
    return Obx(() =>
        MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
            child: SizedBox(
              height: 80,
              child: BottomNavigationBar(
                showUnselectedLabels: true,
                showSelectedLabels: true,
                onTap: landingPageController.changeTabIndex,
                currentIndex: landingPageController.tabIndex.value,
                backgroundColor: HexColor(blue_color),
                unselectedItemColor: HexColor(grey),
                selectedItemColor: HexColor(blue_color),
                unselectedLabelStyle: selectedLabelStyle,
                selectedLabelStyle: selectedLabelStyle,
                items: [
                  BottomNavigationBarItem(
                    icon: Container(
                      margin: const EdgeInsets.only(bottom: 0),
                      child: SvgPicture.asset(
                        'assets/images/home.svg',
                        width: 15,
                        height: 15,
                        color: HexColor(grey),
                      ),
                    ),
                    activeIcon: SvgPicture.asset(
                        'assets/images/home.svg',
                        width: 15,
                        height: 15,
                        color: HexColor(blue_color)
                    ),
                    label: "Home",
                    // backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      margin: const EdgeInsets.only(bottom: 0),
                      child: SvgPicture.asset(
                        'assets/images/due.svg',
                        width: 15,
                        height: 15,
                        color: HexColor(grey),
                      ),
                    ),
                    activeIcon: SvgPicture.asset(
                        'assets/images/due.svg',
                        width: 15,
                        height: 15,
                        color: HexColor(blue_color)
                    ),
                    label: "Payment",
                    // backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      margin: const EdgeInsets.only(bottom: 0),
                      child: SvgPicture.asset(
                        'assets/images/payment.svg',
                        width: 15,
                        height: 15,
                        color: HexColor(grey),
                      ),
                    ),
                    activeIcon: SvgPicture.asset(
                        'assets/images/payment.svg',
                        width: 15,
                        height: 15,
                        color: HexColor(blue_color)
                    ),
                    label: "History",
                    // backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      margin: const EdgeInsets.only(bottom: 0),
                      child: SvgPicture.asset(
                        'assets/images/profile.svg',
                        width: 15,
                        height: 15,
                        color: HexColor(grey),
                      ),
                    ),
                    activeIcon: SvgPicture.asset(
                        'assets/images/profile.svg',
                        width: 15,
                        height: 15,
                        color: HexColor(blue_color)
                    ),
                    label: "User",
                    // backgroundColor: Color.fromRGBO(36, 54, 101, 1.0),
                  ),

                ],
              ),
            )
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    final LandingPageController landingPageController = Get.put(LandingPageController(), permanent: false);

    print("landingPageController.connectionStatus");
    print(landingPageController.connectionStatus);
    return Scaffold(
      // appBar: AppBar(backgroundColor: Color(0xff004C88),elevation: 0,
      //   centerTitle: true,
      //   title: Obx(()=>Text(landingPageController.tabIndex.value==2?"My Transactions":landingPageController.tabIndex.value==3?"My Profile":landingPageController.tabIndex.value==1?"Payment Due":"")),
      // ),
      drawer: NavigationDrawer(),
      bottomNavigationBar: buildBottomNavigationMenu(context, landingPageController),
      body: Obx(() => IndexedStack(
        index: landingPageController.tabIndex.value,
        children: [
          landingPageController.connectionStatus==ConnectivityResult.none?NoInternet():HomeView(),
          landingPageController.connectionStatus==ConnectivityResult.none?NoInternet():PaymentDueView(),
          landingPageController.connectionStatus==ConnectivityResult.none?NoInternet():PaymentHistoryView(),
          landingPageController.connectionStatus==ConnectivityResult.none?NoInternet():MyProfile(),
        ],
      )),
    );
  }
}