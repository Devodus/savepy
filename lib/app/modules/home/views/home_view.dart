import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/UiElements/widget.dart';
import 'package:savepy/app/modules/add_member/view/add_member_view.dart';
import 'package:savepy/app/modules/group_detail/view/group_detail_view.dart';
import 'package:savepy/app/modules/group_list/view/group_list_view.dart';
import 'package:savepy/app/modules/member_list/view/member_list_view.dart';
import 'package:savepy/app/modules/member_profile/view/member_profile_view.dart';
import 'package:savepy/app/modules/payment_due/controller/payment_due_controller.dart';
import 'package:savepy/app/modules/payment_due/view/payment_due_view.dart';
import 'package:savepy/app/modules/payment_history/controller/payment_history_controller.dart';
import 'package:shimmer/shimmer.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeController _homeController = Get.put(HomeController());
  PaymentHistoryController _paymentHistoryController = Get.put(PaymentHistoryController());
  PaymentDueController _paymentDueController = Get.put(PaymentDueController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffEFEFEF).withOpacity(0.9),
      appBar: AppBar(
        backgroundColor: Color(0xff004C88),elevation: 0,
        centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                {
                  Scaffold.of(context).openDrawer();
                }
              }),
        // title: Obx(()=>Text(landingPageController.tabIndex.value==2?"My Transactions":landingPageController.tabIndex.value==3?"My Profile":landingPageController.tabIndex.value==1?"Payment Due":"")),
      ),
      // appBar: AppBar(
      //   elevation: 0,
      //   // leading: IconButton(
      //   //     icon: Icon(
      //   //       Icons.arrow_back_ios,
      //   //       color: Colors.white,
      //   //     ),
      //   //     onPressed: () {
      //   //       {
      //   //         Navigator.pop(context);
      //   //       }
      //   //     }),
      //   backgroundColor: Colors.white,
      //   centerTitle: true,
      //   title: Image.asset("assets/images/logo.png",
      //     height: 50,
      //     width: 50,
      //     fit:BoxFit.fitWidth,),
      // ),
      body: Obx(
            () =>
        //     SafeArea(
        //     child: SingleChildScrollView(
        //       child: Column(
        //         children: [
        //           Padding(
        //             padding: EdgeInsets.only(top: 5, left: 24.0, right: 24, bottom: 5),
        //             child: Row(
        //               crossAxisAlignment: CrossAxisAlignment.end,
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 textWidget('My Groups'.tr, 18, FontWeight.bold, 'Lato',
        //                     0xff000000, '', false),
        //                 InkWell(
        //                   onTap: (){
        //                     Get.to(GroupListView());
        //                   },
        //                   child: textWidget('See all'.tr, 12, FontWeight.normal, 'Lato',
        //                       0xff000000, '', false),
        //                 ),
        //
        //               ],
        //             ),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.only(top: 5, left: 10.0, right: 10, bottom: 5),
        //             child: Container(
        //               color: Colors.white,
        //               height: 95,
        //               margin: EdgeInsets.fromLTRB(5,5,5,5),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   if(_homeController.isGroupListLoading.value == 0)
        //                     Center(
        //                       child: Container(
        //                         child: ListView.builder(
        //                             physics: NeverScrollableScrollPhysics(),
        //                             padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        //                             itemCount: 1,
        //                             shrinkWrap: true,
        //                             itemBuilder: (context, index) {
        //                               return Center(
        //                                 child: Opacity(
        //                                   opacity: 0.8,
        //                                   child: Shimmer.fromColors(
        //                                     child: Padding(
        //                                       padding: const EdgeInsets.only(right: 20.0),
        //                                       child: Row(
        //                                         children: [
        //                                           Container(
        //                                             height: 90,
        //                                             child: Column(
        //                                               children: [
        //                                                 CircleAvatar(
        //                                                   radius: 25,
        //                                                   backgroundColor:  Color((math.Random().nextDouble() * 0xffffffff).toInt()).withOpacity(1.0),
        //                                                   child: Center(
        //                                                     child: textWidget(
        //                                                         "",
        //                                                         18,
        //                                                         FontWeight.bold,
        //                                                         'Lato',
        //                                                         0xffffffff,
        //                                                         '',
        //                                                         false),
        //                                                   ),
        //
        //                                                   // AssetImage("assets/images/demoimage.png"),
        //                                                 ),
        //
        //
        //                                               ],
        //                                             ),
        //                                           ),
        //                                           SizedBox(width: 10,),
        //                                           Container(
        //                                             height: 90,
        //                                             child: Column(
        //                                               children: [
        //                                                 CircleAvatar(
        //                                                   radius: 25,
        //                                                   backgroundColor:  Color((math.Random().nextDouble() * 0xffffffff).toInt()).withOpacity(1.0),
        //                                                   child: Center(
        //                                                     child: textWidget(
        //                                                         "",
        //                                                         18,
        //                                                         FontWeight.bold,
        //                                                         'Lato',
        //                                                         0xffffffff,
        //                                                         '',
        //                                                         false),
        //                                                   ),
        //
        //                                                   // AssetImage("assets/images/demoimage.png"),
        //                                                 ),
        //
        //
        //                                               ],
        //                                             ),
        //                                           ),
        //                                           SizedBox(width: 10,),
        //                                           Container(
        //                                             height: 90,
        //                                             child: Column(
        //                                               children: [
        //                                                 CircleAvatar(
        //                                                   radius: 25,
        //                                                   backgroundColor:  Color((math.Random().nextDouble() * 0xffffffff).toInt()).withOpacity(1.0),
        //                                                   child: Center(
        //                                                     child: textWidget(
        //                                                         "",
        //                                                         18,
        //                                                         FontWeight.bold,
        //                                                         'Lato',
        //                                                         0xffffffff,
        //                                                         '',
        //                                                         false),
        //                                                   ),
        //
        //                                                   // AssetImage("assets/images/demoimage.png"),
        //                                                 ),
        //
        //
        //                                               ],
        //                                             ),
        //                                           ),
        //                                           SizedBox(width: 10,),
        //                                           Container(
        //                                             height: 90,
        //                                             child: Column(
        //                                               children: [
        //                                                 CircleAvatar(
        //                                                   radius: 25,
        //                                                   backgroundColor:  Color((math.Random().nextDouble() * 0xffffffff).toInt()).withOpacity(1.0),
        //                                                   child: Center(
        //                                                     child: textWidget(
        //                                                         "",
        //                                                         18,
        //                                                         FontWeight.bold,
        //                                                         'Lato',
        //                                                         0xffffffff,
        //                                                         '',
        //                                                         false),
        //                                                   ),
        //
        //                                                   // AssetImage("assets/images/demoimage.png"),
        //                                                 ),
        //
        //
        //                                               ],
        //                                             ),
        //                                           ),
        //                                           SizedBox(width: 10,),
        //                                           Container(
        //                                             height: 90,
        //                                             child: Column(
        //                                               children: [
        //                                                 CircleAvatar(
        //                                                   radius: 25,
        //                                                   backgroundColor:  Color((math.Random().nextDouble() * 0xffffffff).toInt()).withOpacity(1.0),
        //                                                   child: Center(
        //                                                     child: textWidget(
        //                                                         "",
        //                                                         18,
        //                                                         FontWeight.bold,
        //                                                         'Lato',
        //                                                         0xffffffff,
        //                                                         '',
        //                                                         false),
        //                                                   ),
        //
        //                                                   // AssetImage("assets/images/demoimage.png"),
        //                                                 ),
        //
        //
        //                                               ],
        //                                             ),
        //                                           ),
        //                                         ],
        //                                       ),
        //                                     ),
        //                                     baseColor: Colors.grey.shade300,
        //                                     highlightColor: Colors.grey.shade50,
        //                                     loop: 10,
        //                                   ),
        //                                 ),
        //                               );
        //                             }),
        //                       ),
        //                     ),
        //                   if(_homeController.isGroupListLoading.value == 2)
        //                     Container(
        //                       child: Center(child: Text("No Product found".tr)),
        //                     ),
        //                   if(_homeController.isGroupListLoading.value == 1)
        //                     Expanded(
        //                     child: ListView.builder(
        //                         padding: const EdgeInsets.fromLTRB(0,0,0,0),
        //                         scrollDirection: Axis.horizontal,
        //                         itemCount: _homeController.groupList.value.length,
        //                         shrinkWrap: true,
        //                         itemBuilder: (context, index) {
        //                           return categoryListItem(index);
        //                         }),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.only(top: 5, left: 24.0, right: 24, bottom: 5),
        //             child: Row(
        //               crossAxisAlignment: CrossAxisAlignment.end,
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 textWidget('My Members', 18, FontWeight.bold, 'Lato',
        //                     0xff000000, '', false),
        //                 InkWell(
        //                   onTap: (){
        //                     Navigator.of(context).push(
        //                         MaterialPageRoute(builder: (context) => MemberListView()));
        //                   },
        //                   child: textWidget('See All', 12, FontWeight.normal, 'Lato',
        //                       0xff000000, '', false),
        //                 ),
        //
        //               ],
        //             ),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.only(top: 5, left: 10.0, right: 10, bottom: 5),
        //             child: Container(
        //               color: Colors.white,
        //               height: 150,
        //               margin: EdgeInsets.fromLTRB(5,5,5,5),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   if(_homeController.isMemberListLoading.value == 0)
        //                     Center(
        //                       child: Container(
        //                         child: ListView.builder(
        //                             physics: NeverScrollableScrollPhysics(),
        //                             padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        //                             itemCount: 1,
        //                             shrinkWrap: true,
        //                             itemBuilder: (context, index) {
        //                               return Center(
        //                                 child: Opacity(
        //                                   opacity: 0.8,
        //                                   child: Shimmer.fromColors(
        //                                     child: Padding(
        //                                       padding: const EdgeInsets.only(right: 20.0),
        //                                       child: Row(
        //                                         children: [
        //                                           Container(
        //                                             height: 150,
        //                                             width: 90,
        //
        //                                             // child: Column(
        //                                             //   children: [
        //                                             //
        //                                             //
        //                                             //     CircleAvatar(
        //                                             //       radius: 25,
        //                                             //       backgroundColor:  Color((math.Random().nextDouble() * 0x004C88).toInt()).withOpacity(1.0),
        //                                             //       child: Center(
        //                                             //         child: textWidget(
        //                                             //             "${_homeController.memberList.value[index].firstName!}".toUpperCase()[0],
        //                                             //             18,
        //                                             //             FontWeight.bold,
        //                                             //             'Lato',
        //                                             //             0xffffffff,
        //                                             //             '',
        //                                             //             false),
        //                                             //       ),
        //                                             //
        //                                             //       // AssetImage("assets/images/demoimage.png"),
        //                                             //     ),
        //                                             //     SizedBox(
        //                                             //       height: 14,
        //                                             //     ),
        //                                             //     textWidget("${_homeController.memberList.value[index].firstName!} ${_homeController.memberList.value[index].lastName!}", 12, FontWeight.normal, 'Lato',
        //                                             //         0xff000000, '', false)
        //                                             //   ],
        //                                             // ),
        //                                             child: Padding(
        //                                               padding: const EdgeInsets.all(8.0),
        //                                               child: Card(
        //                                                 color: Color(0xffE6E6E6),
        //                                                 shape: RoundedRectangleBorder(
        //                                                   borderRadius: BorderRadius.circular(10.0),
        //                                                 ),
        //                                                 elevation: 0.5,
        //                                                 child: Container(
        //                                                   child: Column(
        //                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                                     crossAxisAlignment: CrossAxisAlignment.center,
        //                                                     children: [
        //                                                       SizedBox(height: 0,),
        //                                                       textWidget(
        //                                                           "",
        //                                                           24,
        //                                                           FontWeight.bold,
        //                                                           'Lato',
        //                                                           0xff004C88,
        //                                                           '',
        //                                                           false),
        //                                                       Container(
        //                                                         padding: EdgeInsets.all(10),
        //                                                         decoration: BoxDecoration(
        //                                                           color: Color((math.Random().nextDouble() * 0x004C88).toInt()).withOpacity(1.0),
        //                                                           borderRadius: BorderRadius.only(
        //                                                               bottomRight: Radius.circular(10.0),
        //                                                               bottomLeft: Radius.circular(10.0)),
        //                                                         ),
        //                                                         child: Align(
        //                                                           child: textWidget(
        //                                                               "",
        //                                                               12,
        //                                                               FontWeight.w400,
        //                                                               'Lato',
        //                                                               0xffffffff,
        //                                                               'c',
        //                                                               false),
        //                                                         ),
        //                                                       )
        //                                                     ],
        //                                                   ),
        //                                                 ),
        //                                               ),
        //                                             ),
        //                                           ),
        //                                           SizedBox(width: 10,),
        //                                           Container(
        //                                             height: 150,
        //                                             width: 90,
        //
        //                                             // child: Column(
        //                                             //   children: [
        //                                             //
        //                                             //
        //                                             //     CircleAvatar(
        //                                             //       radius: 25,
        //                                             //       backgroundColor:  Color((math.Random().nextDouble() * 0x004C88).toInt()).withOpacity(1.0),
        //                                             //       child: Center(
        //                                             //         child: textWidget(
        //                                             //             "${_homeController.memberList.value[index].firstName!}".toUpperCase()[0],
        //                                             //             18,
        //                                             //             FontWeight.bold,
        //                                             //             'Lato',
        //                                             //             0xffffffff,
        //                                             //             '',
        //                                             //             false),
        //                                             //       ),
        //                                             //
        //                                             //       // AssetImage("assets/images/demoimage.png"),
        //                                             //     ),
        //                                             //     SizedBox(
        //                                             //       height: 14,
        //                                             //     ),
        //                                             //     textWidget("${_homeController.memberList.value[index].firstName!} ${_homeController.memberList.value[index].lastName!}", 12, FontWeight.normal, 'Lato',
        //                                             //         0xff000000, '', false)
        //                                             //   ],
        //                                             // ),
        //                                             child: Padding(
        //                                               padding: const EdgeInsets.all(8.0),
        //                                               child: Card(
        //                                                 color: Color(0xffE6E6E6),
        //                                                 shape: RoundedRectangleBorder(
        //                                                   borderRadius: BorderRadius.circular(10.0),
        //                                                 ),
        //                                                 elevation: 0.5,
        //                                                 child: Container(
        //                                                   child: Column(
        //                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                                     crossAxisAlignment: CrossAxisAlignment.center,
        //                                                     children: [
        //                                                       SizedBox(height: 0,),
        //                                                       textWidget(
        //                                                           "",
        //                                                           24,
        //                                                           FontWeight.bold,
        //                                                           'Lato',
        //                                                           0xff004C88,
        //                                                           '',
        //                                                           false),
        //                                                       Container(
        //                                                         padding: EdgeInsets.all(10),
        //                                                         decoration: BoxDecoration(
        //                                                           color: Color((math.Random().nextDouble() * 0x004C88).toInt()).withOpacity(1.0),
        //                                                           borderRadius: BorderRadius.only(
        //                                                               bottomRight: Radius.circular(10.0),
        //                                                               bottomLeft: Radius.circular(10.0)),
        //                                                         ),
        //                                                         child: Align(
        //                                                           child: textWidget(
        //                                                               "",
        //                                                               12,
        //                                                               FontWeight.w400,
        //                                                               'Lato',
        //                                                               0xffffffff,
        //                                                               'c',
        //                                                               false),
        //                                                         ),
        //                                                       )
        //                                                     ],
        //                                                   ),
        //                                                 ),
        //                                               ),
        //                                             ),
        //                                           ),
        //                                           SizedBox(width: 10,),
        //                                           Container(
        //                                             height: 150,
        //                                             width: 90,
        //
        //                                             // child: Column(
        //                                             //   children: [
        //                                             //
        //                                             //
        //                                             //     CircleAvatar(
        //                                             //       radius: 25,
        //                                             //       backgroundColor:  Color((math.Random().nextDouble() * 0x004C88).toInt()).withOpacity(1.0),
        //                                             //       child: Center(
        //                                             //         child: textWidget(
        //                                             //             "${_homeController.memberList.value[index].firstName!}".toUpperCase()[0],
        //                                             //             18,
        //                                             //             FontWeight.bold,
        //                                             //             'Lato',
        //                                             //             0xffffffff,
        //                                             //             '',
        //                                             //             false),
        //                                             //       ),
        //                                             //
        //                                             //       // AssetImage("assets/images/demoimage.png"),
        //                                             //     ),
        //                                             //     SizedBox(
        //                                             //       height: 14,
        //                                             //     ),
        //                                             //     textWidget("${_homeController.memberList.value[index].firstName!} ${_homeController.memberList.value[index].lastName!}", 12, FontWeight.normal, 'Lato',
        //                                             //         0xff000000, '', false)
        //                                             //   ],
        //                                             // ),
        //                                             child: Padding(
        //                                               padding: const EdgeInsets.all(8.0),
        //                                               child: Card(
        //                                                 color: Color(0xffE6E6E6),
        //                                                 shape: RoundedRectangleBorder(
        //                                                   borderRadius: BorderRadius.circular(10.0),
        //                                                 ),
        //                                                 elevation: 0.5,
        //                                                 child: Container(
        //                                                   child: Column(
        //                                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                                     crossAxisAlignment: CrossAxisAlignment.center,
        //                                                     children: [
        //                                                       SizedBox(height: 0,),
        //                                                       textWidget(
        //                                                           "",
        //                                                           24,
        //                                                           FontWeight.bold,
        //                                                           'Lato',
        //                                                           0xff004C88,
        //                                                           '',
        //                                                           false),
        //                                                       Container(
        //                                                         padding: EdgeInsets.all(10),
        //                                                         decoration: BoxDecoration(
        //                                                           color: Color((math.Random().nextDouble() * 0x004C88).toInt()).withOpacity(1.0),
        //                                                           borderRadius: BorderRadius.only(
        //                                                               bottomRight: Radius.circular(10.0),
        //                                                               bottomLeft: Radius.circular(10.0)),
        //                                                         ),
        //                                                         child: Align(
        //                                                           child: textWidget(
        //                                                               "",
        //                                                               12,
        //                                                               FontWeight.w400,
        //                                                               'Lato',
        //                                                               0xffffffff,
        //                                                               'c',
        //                                                               false),
        //                                                         ),
        //                                                       )
        //                                                     ],
        //                                                   ),
        //                                                 ),
        //                                               ),
        //                                             ),
        //                                           ),
        //
        //
        //                                         ],
        //                                       ),
        //                                     ),
        //                                     baseColor: Colors.grey.shade300,
        //                                     highlightColor: Colors.grey.shade50,
        //                                     loop: 10,
        //                                   ),
        //                                 ),
        //                               );
        //                             }),
        //                       ),
        //                     ),
        //                   if(_homeController.isMemberListLoading.value == 2)
        //                     Container(
        //                       child: Center(child: Text("No Product found")),
        //                     ),
        //                   if(_homeController.isMemberListLoading.value == 1)
        //                     Expanded(
        //                     child: ListView.builder(
        //                         padding: const EdgeInsets.fromLTRB(0,0,0,0),
        //                         scrollDirection: Axis.horizontal,
        //                         itemCount: _homeController.memberList.value.length,
        //                         shrinkWrap: true,
        //                         itemBuilder: (context, index) {
        //                           return memberListItem(index);
        //                         }),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.only(top: 5, left: 24.0, right: 24, bottom: 5),
        //             child: Row(
        //               crossAxisAlignment: CrossAxisAlignment.end,
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 textWidget('Recent Payments', 18, FontWeight.bold, 'Lato',
        //                     0xff000000, '', false),
        //                 // InkWell(
        //                 //   onTap: (){
        //                 //     Navigator.of(context).push(
        //                 //         MaterialPageRoute(builder: (context) => AddMemberView()));
        //                 //   },
        //                 //   child: textWidget('Add new', 12, FontWeight.normal, 'Lato',
        //                 //       0xff000000, '', false),
        //                 // ),
        //
        //               ],
        //             ),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.only(top: 5, left: 10.0, right: 10, bottom: 5),
        //             child: Container(
        //               color: Colors.white,
        //               height: 150,
        //               margin: EdgeInsets.fromLTRB(5,5,5,5),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   if(_paymentHistoryController.isPaymentListLoading.value == 0)
        //                     Container(
        //                       child: CircularProgressIndicator(),
        //                     ),
        //                   if(_paymentHistoryController.isPaymentListLoading.value == 2)
        //                     Container(
        //                       child: Center(child: Text("No Product found")),
        //                     ),
        //                   if(_paymentHistoryController.isPaymentListLoading.value == 1)
        //                     Expanded(
        //                       child: ListView.builder(
        //                           padding: const EdgeInsets.fromLTRB(0,0,0,0),
        //                           scrollDirection: Axis.horizontal,
        //                           itemCount: _paymentHistoryController.paymentHistoryList.value.length,
        //                           shrinkWrap: true,
        //                           itemBuilder: (context, index) {
        //                             return Stack(
        //                               children: [
        //                                 Padding(
        //                                   padding: const EdgeInsets.all(8.0),
        //                                   child: Card(
        //                                     shape: RoundedRectangleBorder(
        //                                       borderRadius: BorderRadius.circular(10.0),
        //                                     ),
        //                                     elevation: 0.5,
        //                                     child: Container(
        //                                       width: width * 0.75,
        //                                       child: Column(
        //                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                                         crossAxisAlignment: CrossAxisAlignment.center,
        //                                         children: [
        //                                           SizedBox(height: 0,),
        //                                           SvgPicture.asset(
        //                                             width:30,
        //                                             height:30,
        //                                             'assets/images/payment.svg',
        //                                             color:Color(0xff9BA680),
        //                                           ),
        //                                           Container(
        //                                             padding: EdgeInsets.all(10),
        //                                             decoration: BoxDecoration(
        //                                               color: Color(0xff9BA680),
        //                                               borderRadius: BorderRadius.only(
        //                                                   bottomRight: Radius.circular(10.0),
        //                                                   bottomLeft: Radius.circular(10.0)),
        //                                             ),
        //                                             child: Align(
        //                                               child: textWidget(
        //                                                   "\$ ${_paymentHistoryController.paymentHistoryList.value[index].fldAmount}",
        //                                                   16,
        //                                                   FontWeight.w400,
        //                                                   'Lato',
        //                                                   0xffffffff,
        //                                                   'c',
        //                                                   false),
        //                                             ),
        //                                           )
        //                                         ],
        //                                       ),
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 Positioned(
        //                                   top: 15,
        //                                   left: 15,
        //                                   child: textWidget(
        //                                       "${_paymentHistoryController.paymentHistoryList.value[index].groupName}",
        //                                       14,
        //                                       FontWeight.w400,
        //                                       'Lato',
        //                                       0xff9BA680,
        //                                       'c',
        //                                       false),
        //                                 ),
        //                                 Positioned(
        //                                   bottom: 60,
        //                                   right: 20,
        //                                   child: textWidget(
        //                                       "${_paymentHistoryController.paymentHistoryList.value[index].fldPaymentDate}",
        //                                       14,
        //                                       FontWeight.w400,
        //                                       'Lato',
        //                                       0xff9BA680,
        //                                       'c',
        //                                       false),
        //                                 ),
        //                               ],
        //                             );
        //                           }),
        //                     ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     )
        //
        // ),
        SafeArea(
            child: Stack(
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.only(
                //         bottomLeft: Radius.circular(100),
                //         bottomRight: Radius.circular(100)),
                //     color: HexColor(blue_color),
                //     shape: BoxShape.rectangle,
                //   ),
                //   height: height/4,
                //   width: width+100,
                // ),
                Positioned(
                  top: -30,
                  child: Image.asset(
                    "assets/images/homepage_bg.png",
                    // height: 100,
                    width: width+15,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo_white.png",
                        height: 86,
                        width: 151,
                        fit: BoxFit.fitWidth,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 130, left: 0, right: 0, bottom: 10),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10.0, right: 10, bottom: 5),
                          child: Container(
                            color: Colors.transparent,
                            height: 180,
                            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                if (_paymentHistoryController
                                    .isPaymentListLoading.value ==
                                    0)
                                  Center(
                                    child: Opacity(
                                      opacity: 0.8,
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade50,
                                        loop: 10,
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Padding(
                                                padding: const EdgeInsets.all(0),
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10.0),
                                                  ),
                                                  elevation: 0.5,
                                                  child: SizedBox(
                                                    width: width * 0.9,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 10,
                                                              right: 10,
                                                              bottom: 10),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              textWidget(
                                                                  'Recent Payments'
                                                                      .tr,
                                                                  18,
                                                                  FontWeight.bold,
                                                                  'Lato',
                                                                  0xff004C88,
                                                                  '',
                                                                  false),
                                                              Container(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                                width: 91,
                                                                height: 24,
                                                                alignment: Alignment
                                                                    .center,
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: const Color(
                                                                      0xff04A7ED),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                  // border: Border.all(color: Colors.black)
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                      10.0,
                                                                      right:
                                                                      10.0,
                                                                      top: 0,
                                                                      bottom:
                                                                      0),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      textWidget(
                                                                          "",
                                                                          12,
                                                                          FontWeight
                                                                              .bold,
                                                                          'Lato',
                                                                          0xffFFFFFF,
                                                                          '',
                                                                          false),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 10,
                                                              right: 10,
                                                              bottom: 10),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              textWidget(
                                                                  "",
                                                                  28,
                                                                  FontWeight.bold,
                                                                  'Lato',
                                                                  0xff323232,
                                                                  'c',
                                                                  false),
                                                              Container(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                                alignment: Alignment
                                                                    .center,
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                      10.0,
                                                                      right:
                                                                      10.0,
                                                                      top: 0,
                                                                      bottom:
                                                                      0),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      const Padding(
                                                                        padding:
                                                                        EdgeInsets
                                                                            .all(2),
                                                                        child: Icon(
                                                                          Icons
                                                                              .calendar_today_rounded,
                                                                          color: Color(
                                                                              0xff000000),
                                                                          size: 15,
                                                                        ),
                                                                      ),
                                                                      textWidget(
                                                                          "",
                                                                          12,
                                                                          FontWeight
                                                                              .bold,
                                                                          'Lato',
                                                                          0xff000000,
                                                                          '',
                                                                          false),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                if (_paymentHistoryController
                                    .isPaymentListLoading.value ==
                                    2)
                                  Container(
                                    padding:EdgeInsets.all(20),
                                    height: 150,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(8))),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        textWidget(
                                            'Recent Payments'
                                                .tr,
                                            18,
                                            FontWeight.bold,
                                            'Lato',
                                            0xff004C88,
                                            '',
                                            false),
                                        Spacer(),
                                        SvgPicture.asset(
                                          width: 40,
                                          height: 40,
                                          'assets/images/no_payment.svg',
                                          color: Color(0xff125AAB),
                                        ),
                                        Center(
                                          child: textWidget(
                                              "You didn't make any payments yet",
                                              13,
                                              FontWeight.w400,
                                              'Lato',
                                              0xff125AAB,
                                              '',
                                              false),
                                        ),
                                        // Center(
                                        //   child: textWidget(
                                        //       "Tap to add new member",
                                        //       13,
                                        //       FontWeight.w400,
                                        //       'Lato',
                                        //       0xff125AAB,
                                        //       '',
                                        //       false),
                                        // ),
                                      ],
                                    ),
                                  ),
                                if (_paymentHistoryController
                                    .isPaymentListLoading.value ==
                                    1)
                                  Expanded(
                                    child: ListView.builder(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _paymentHistoryController
                                            .paymentHistoryList.value.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(10.0),
                                                ),
                                                elevation: 0.5,
                                                child: SizedBox(
                                                  width: width * 0.83,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            top: 20,
                                                            left: 20,
                                                            right: 20,
                                                            bottom: 0),
                                                        child: textWidget(
                                                            'Recent Payments'
                                                                .tr,
                                                            12,
                                                            FontWeight.bold,
                                                            'Lato',
                                                            0xff004C88,
                                                            '',
                                                            false),
                                                      ),
                                                      !["", null, "null"].contains("${_paymentHistoryController.paymentHistoryList.value[index].groupName}")?
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            top: 0,
                                                            left: 20,
                                                            right: 20,
                                                            bottom: 5),
                                                        child: Container(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(5),
                                                          // width: 91,
                                                          // height: 24,
                                                          alignment:
                                                          Alignment.center,
                                                          decoration:
                                                          BoxDecoration(
                                                            color: const Color(
                                                                0xff04A7ED),
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                8),
                                                            // border: Border.all(color: Colors.black)
                                                          ),
                                                          child: textWidget(
                                                              "${_paymentHistoryController.paymentHistoryList.value[index].groupName}",
                                                              12,
                                                              FontWeight
                                                                  .bold,
                                                              'Lato',
                                                              0xffFFFFFF,
                                                              '',
                                                              false),
                                                        ),
                                                      ):
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            top: 0,
                                                            left: 20,
                                                            right: 20,
                                                            bottom: 5),
                                                        child: Container(
                                                          padding:
                                                          const EdgeInsets
                                                              .all(5),
                                                          // width: 91,
                                                          // height: 24,
                                                          alignment:
                                                          Alignment.center,
                                                          decoration:
                                                          BoxDecoration(
                                                            color: Colors.redAccent.shade400,
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                8),
                                                            // border: Border.all(color: Colors.black)
                                                          ),

                                                          child: textWidget(
                                                              "This group doesn't exist anymore.\n Deleted by leader/admin.",
                                                              12,
                                                              FontWeight
                                                                  .bold,
                                                              'Lato',
                                                              0xffFFFFFF,
                                                              '',
                                                              false),
                                                        ),
                                                      ),

                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            top: 5,
                                                            left: 20,
                                                            right: 0,
                                                            bottom: 20),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                "\$ ${_paymentHistoryController.paymentHistoryList.value[index].fldAmount}",
                                                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
                                                                maxLines: 1,
                                                                // overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                padding: const EdgeInsets.all(2),
                                                                alignment: Alignment.center,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(
                                                                      left: 10.0,
                                                                      right: 10.0,
                                                                      top: 0,
                                                                      bottom: 0),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      const Padding(
                                                                        padding:
                                                                        EdgeInsets
                                                                            .all(
                                                                            2),
                                                                        child: Icon(
                                                                          Icons
                                                                              .calendar_today_rounded,
                                                                          color: Color(
                                                                              0xff000000),
                                                                          size: 15,
                                                                        ),
                                                                      ),

                                                                      textWidget(
                                                                          "${_paymentHistoryController.paymentHistoryList.value[index].fldPaymentDate}",
                                                                          12,
                                                                          FontWeight
                                                                              .bold,
                                                                          'Lato',
                                                                          0xff000000,
                                                                          '',
                                                                          false),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),


                                                            // textWidget(
                                                            //     "\$ ${_paymentHistoryController.paymentHistoryList.value[index].fldAmount}",
                                                            //     28,
                                                            //     FontWeight.bold,
                                                            //     'Lato',
                                                            //     0xff323232,
                                                            //     'c',
                                                            //     false),

                                                          ],
                                                        ),
                                                      ),
                                                      // Padding(
                                                      //   padding:
                                                      //       const EdgeInsets.only(
                                                      //           top: 5,
                                                      //           left: 20,
                                                      //           right: 20,
                                                      //           bottom: 20),
                                                      //   child: Row(
                                                      //     crossAxisAlignment:
                                                      //         CrossAxisAlignment
                                                      //             .end,
                                                      //     mainAxisAlignment:
                                                      //         MainAxisAlignment
                                                      //             .spaceBetween,
                                                      //     children: [
                                                      //       textWidget(
                                                      //           "\$ 1000000000",
                                                      //           28,
                                                      //           FontWeight.bold,
                                                      //           'Lato',
                                                      //           0xff323232,
                                                      //           'c',
                                                      //           false),
                                                      //       Container(
                                                      //         padding: const EdgeInsets.all(2),
                                                      //         alignment: Alignment.center,
                                                      //         child: Padding(
                                                      //           padding: const EdgeInsets.only(
                                                      //                   left: 10.0,
                                                      //                   right: 10.0,
                                                      //                   top: 0,
                                                      //                   bottom: 0),
                                                      //           child: Row(
                                                      //             crossAxisAlignment:
                                                      //                 CrossAxisAlignment
                                                      //                     .center,
                                                      //             mainAxisAlignment:
                                                      //                 MainAxisAlignment
                                                      //                     .center,
                                                      //             children: [
                                                      //               const Padding(
                                                      //                 padding:
                                                      //                     EdgeInsets
                                                      //                         .all(
                                                      //                             2),
                                                      //                 child: Icon(
                                                      //                   Icons
                                                      //                       .calendar_today_rounded,
                                                      //                   color: Color(
                                                      //                       0xff000000),
                                                      //                   size: 15,
                                                      //                 ),
                                                      //               ),
                                                      //               textWidget(
                                                      //                   "${_paymentHistoryController.paymentHistoryList.value[index].fldPaymentDate}",
                                                      //                   12,
                                                      //                   FontWeight
                                                      //                       .bold,
                                                      //                   'Lato',
                                                      //                   0xff000000,
                                                      //                   '',
                                                      //                   false),
                                                      //             ],
                                                      //           ),
                                                      //         ),
                                                      //       ),
                                                      //     ],
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10.0, right: 10, bottom: 5),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(8))),
                            height: 140,
                            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 24.0, right: 24, bottom: 5),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget(
                                          'My Groups'.tr,
                                          18,
                                          FontWeight.bold,
                                          'Lato',
                                          0xff004C88,
                                          '',
                                          false),
                                      InkWell(
                                        onTap: () {
                                          Get.to(GroupListView());
                                        },
                                        child: textWidget(
                                            'See All'.tr,
                                            12,
                                            FontWeight.normal,
                                            'Lato',
                                            0xff004C88,
                                            '',
                                            false),
                                      ),
                                    ],
                                  ),
                                ),
                                if (_homeController.isGroupListLoading.value == 0)
                                  Center(
                                    child: Opacity(
                                      opacity: 0.8,
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade50,
                                        loop: 10,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20, 10, 20, 0),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                height: 90,
                                                child: Column(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundColor: Color((math
                                                          .Random()
                                                          .nextDouble() *
                                                          0xffffffff)
                                                          .toInt())
                                                          .withOpacity(1.0),
                                                      child: Center(
                                                        child: textWidget(
                                                            "",
                                                            18,
                                                            FontWeight.bold,
                                                            'Lato',
                                                            0xffffffff,
                                                            '',
                                                            false),
                                                      ),
                                                      // AssetImage("assets/images/demoimage.png"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                height: 90,
                                                child: Column(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundColor: Color((math
                                                          .Random()
                                                          .nextDouble() *
                                                          0xffffffff)
                                                          .toInt())
                                                          .withOpacity(1.0),
                                                      child: Center(
                                                        child: textWidget(
                                                            "",
                                                            18,
                                                            FontWeight.bold,
                                                            'Lato',
                                                            0xffffffff,
                                                            '',
                                                            false),
                                                      ),
                                                      // AssetImage("assets/images/demoimage.png"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                height: 90,
                                                child: Column(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundColor: Color((math
                                                          .Random()
                                                          .nextDouble() *
                                                          0xffffffff)
                                                          .toInt())
                                                          .withOpacity(1.0),
                                                      child: Center(
                                                        child: textWidget(
                                                            "",
                                                            18,
                                                            FontWeight.bold,
                                                            'Lato',
                                                            0xffffffff,
                                                            '',
                                                            false),
                                                      ), // AssetImage("assets/images/demoimage.png"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                height: 90,
                                                child: Column(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundColor: Color((math
                                                          .Random()
                                                          .nextDouble() *
                                                          0xffffffff)
                                                          .toInt())
                                                          .withOpacity(1.0),
                                                      child: Center(
                                                        child: textWidget(
                                                            "",
                                                            18,
                                                            FontWeight.bold,
                                                            'Lato',
                                                            0xffffffff,
                                                            '',
                                                            false),
                                                      ),

                                                      // AssetImage("assets/images/demoimage.png"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                height: 90,
                                                child: Column(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 25,
                                                      backgroundColor: Color((math
                                                          .Random()
                                                          .nextDouble() *
                                                          0xffffffff)
                                                          .toInt())
                                                          .withOpacity(1.0),
                                                      child: Center(
                                                        child: textWidget(
                                                            "",
                                                            18,
                                                            FontWeight.bold,
                                                            'Lato',
                                                            0xffffffff,
                                                            '',
                                                            false),
                                                      ),

                                                      // AssetImage("assets/images/demoimage.png"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (_homeController.isGroupListLoading.value == 2)
                                  Container(
                                    child: Expanded(
                                        child: GestureDetector(
                                          onTap: (){
                                            Get.to(GroupListView());
                                          },
                                          child: Column(
                                            children: [
                                              SvgPicture.asset(
                                                width: 40,
                                                height: 40,
                                                'assets/images/no_group.svg',
                                                color: Color(0xff125AAB),
                                              ),
                                              Center(
                                                child: textWidget(
                                                    "You are not assigned to any group",
                                                    13,
                                                    FontWeight.w400,
                                                    'Lato',
                                                    0xff125AAB,
                                                    '',
                                                    false),
                                              ),
                                              Center(
                                                child: textWidget(
                                                    "Tap to add new group",
                                                    13,
                                                    FontWeight.w400,
                                                    'Lato',
                                                    0xff125AAB,
                                                    '',
                                                    false),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                if (_homeController.isGroupListLoading.value == 1)
                                  Expanded(
                                    child: Container(
                                      child: ListView.builder(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 0, 10),
                                          scrollDirection: Axis.horizontal,
                                          reverse: false,
                                          itemCount: _homeController.groupList.value.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return categoryListItem(index);
                                          }),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 10.0, right: 10, bottom: 5),
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(8))),
                            // color: Colors.white,
                            height: 150,
                            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5, left: 24.0, right: 24, bottom: 5),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      textWidget('My Members', 18, FontWeight.bold,
                                          'Lato', 0xff004C88, '', false),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MemberListView()));
                                        },
                                        child: textWidget(
                                            'See All',
                                            12,
                                            FontWeight.normal,
                                            'Lato',
                                            0xff004C88,
                                            '',
                                            false),
                                      ),
                                    ],
                                  ),
                                ),
                                if (_homeController.isMemberListLoading.value == 0)
                                  Center(
                                    child: Container(
                                      child: ListView.builder(
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          itemCount: 1,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Center(
                                              child: Opacity(
                                                opacity: 0.8,
                                                child: Shimmer.fromColors(
                                                  baseColor: Colors.grey.shade300,
                                                  highlightColor:
                                                  Colors.grey.shade50,
                                                  loop: 10,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.fromLTRB(
                                                        30, 10, 30, 0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Container(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                            decoration:
                                                            const BoxDecoration(
                                                              color:
                                                              Color(0xffCBCACA),
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                      10.0)),
                                                            ),
                                                            child: Container(
                                                              // height: 150,
                                                              // width: 150,
                                                              decoration:
                                                              const BoxDecoration(
                                                                shape:
                                                                BoxShape.circle,
                                                                color: Colors.white,
                                                              ),
                                                              child: const ClipOval(
                                                                child: Icon(
                                                                    Icons.person),
                                                              ),
                                                            )),
                                                        // SizedBox(width: 10,),
                                                        Container(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                            decoration:
                                                            const BoxDecoration(
                                                              color:
                                                              Color(0xffCBCACA),
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                      10.0)),
                                                            ),
                                                            child: Container(
                                                              // height: 150,
                                                              // width: 150,
                                                              decoration:
                                                              const BoxDecoration(
                                                                shape:
                                                                BoxShape.circle,
                                                                color: Colors.white,
                                                              ),
                                                              child: const ClipOval(
                                                                child: Icon(
                                                                    Icons.person),
                                                              ),
                                                            )),
                                                        // SizedBox(width: 10,),
                                                        Container(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(15),
                                                            decoration:
                                                            const BoxDecoration(
                                                              color:
                                                              Color(0xffCBCACA),
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                      10.0)),
                                                            ),
                                                            child: Container(
                                                              // height: 150,
                                                              // width: 150,
                                                              decoration:
                                                              const BoxDecoration(
                                                                shape:
                                                                BoxShape.circle,
                                                                color: Colors.white,
                                                              ),
                                                              child: const ClipOval(
                                                                child: Icon(
                                                                    Icons.person),
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                if (_homeController.isMemberListLoading.value == 2)
                                  Container(
                                    child: Expanded(
                                        child: GestureDetector(
                                          onTap: (){
                                            Navigator.of(context).push(
                                                MaterialPageRoute(builder: (context) => AddMemberView()));
                                          },
                                          child: Column(
                                            children: [
                                              SvgPicture.asset(
                                                width: 40,
                                                height: 40,
                                                'assets/images/no_member.svg',
                                                color: Color(0xff125AAB),
                                              ),
                                              Center(
                                                child: textWidget(
                                                    "You didn't added any member yet",
                                                    13,
                                                    FontWeight.w400,
                                                    'Lato',
                                                    0xff125AAB,
                                                    '',
                                                    false),
                                              ),
                                              Center(
                                                child: textWidget(
                                                    "Tap to add new member",
                                                    13,
                                                    FontWeight.w400,
                                                    'Lato',
                                                    0xff125AAB,
                                                    '',
                                                    false),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                if (_homeController.isMemberListLoading.value == 1)
                                  Expanded(
                                    child: _homeController.memberList.value.length!=0?
                                    ListView.builder(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _homeController.memberList.value.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return memberListItem(index);
                                        }):
                                    Container(
                                      child: GestureDetector(
                                        onTap: (){
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context) => AddMemberView()));
                                        },
                                        child: Column(
                                          children: [
                                            SvgPicture.asset(
                                              width: 40,
                                              height: 40,
                                              'assets/images/no_member.svg',
                                              color: Color(0xff125AAB),
                                            ),
                                            Center(
                                              child: textWidget(
                                                  "You didn't added any member yet",
                                                  13,
                                                  FontWeight.w400,
                                                  'Lato',
                                                  0xff125AAB,
                                                  '',
                                                  false),
                                            ),
                                            Center(
                                              child: textWidget(
                                                  "Tap to add new member",
                                                  13,
                                                  FontWeight.w400,
                                                  'Lato',
                                                  0xff125AAB,
                                                  '',
                                                  false),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 24.0, right: 24, bottom: 5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              textWidget('Due Payments', 18, FontWeight.bold,
                                  'Lato', 0xff000000, '', false),
                              // InkWell(
                              //   onTap: (){
                              //     Navigator.of(context).push(
                              //         MaterialPageRoute(builder: (context) => AddMemberView()));
                              //   },
                              //   child: textWidget('Add new', 12, FontWeight.normal, 'Lato',
                              //       0xff000000, '', false),
                              // ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 10.0, right: 10, bottom: 10),
                          child: Container(
                            color: Colors.transparent,
                            height: 200,
                            margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (_paymentDueController.isPaymentListLoading.value == 0)
                                  Center(
                                    child: Opacity(
                                      opacity: 0.8,
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade50,
                                        loop: 10,
                                        child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: Container(
                                              color: Colors.transparent,
                                              child: Padding(
                                                padding: const EdgeInsets.all(0),
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.circular(10.0),
                                                  ),
                                                  elevation: 0.5,
                                                  child: SizedBox(
                                                    width: width * 0.9,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 10,
                                                              right: 10,
                                                              bottom: 10),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              textWidget(
                                                                  'Recent Payments'
                                                                      .tr,
                                                                  18,
                                                                  FontWeight.bold,
                                                                  'Lato',
                                                                  0xff004C88,
                                                                  '',
                                                                  false),
                                                              Container(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                                width: 91,
                                                                height: 24,
                                                                alignment: Alignment
                                                                    .center,
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: const Color(
                                                                      0xff04A7ED),
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8),
                                                                  // border: Border.all(color: Colors.black)
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                      10.0,
                                                                      right:
                                                                      10.0,
                                                                      top: 0,
                                                                      bottom:
                                                                      0),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      textWidget(
                                                                          "",
                                                                          12,
                                                                          FontWeight
                                                                              .bold,
                                                                          'Lato',
                                                                          0xffFFFFFF,
                                                                          '',
                                                                          false),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 10,
                                                              right: 10,
                                                              bottom: 10),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              textWidget(
                                                                  "",
                                                                  28,
                                                                  FontWeight.bold,
                                                                  'Lato',
                                                                  0xff323232,
                                                                  'c',
                                                                  false),
                                                              Container(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                                alignment: Alignment
                                                                    .center,
                                                                child: Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left:
                                                                      10.0,
                                                                      right:
                                                                      10.0,
                                                                      top: 0,
                                                                      bottom:
                                                                      0),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                    children: [
                                                                      const Padding(
                                                                        padding:
                                                                        EdgeInsets
                                                                            .all(2),
                                                                        child: Icon(
                                                                          Icons
                                                                              .calendar_today_rounded,
                                                                          color: Color(
                                                                              0xff000000),
                                                                          size: 15,
                                                                        ),
                                                                      ),
                                                                      textWidget(
                                                                          "",
                                                                          12,
                                                                          FontWeight
                                                                              .bold,
                                                                          'Lato',
                                                                          0xff000000,
                                                                          '',
                                                                          false),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ),
                                if (_paymentDueController.isPaymentListLoading.value == 2)
                                  Container(
                                    padding:EdgeInsets.all(20),
                                    height: 150,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(8))),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        textWidget(
                                            'Due Payments'
                                                .tr,
                                            18,
                                            FontWeight.bold,
                                            'Lato',
                                            0xff004C88,
                                            '',
                                            false),
                                        Spacer(),
                                        SvgPicture.asset(
                                          width: 40,
                                          height: 40,
                                          'assets/images/no_payment.svg',
                                          color: Color(0xff125AAB),
                                        ),
                                        Center(
                                          child: textWidget(
                                              "You don't have any due payment",
                                              13,
                                              FontWeight.w400,
                                              'Lato',
                                              0xff125AAB,
                                              '',
                                              false),
                                        ),
                                        // Center(
                                        //   child: textWidget(
                                        //       "Tap to add new member",
                                        //       13,
                                        //       FontWeight.w400,
                                        //       'Lato',
                                        //       0xff125AAB,
                                        //       '',
                                        //       false),
                                        // ),
                                      ],
                                    ),
                                  ),
                                if (_paymentDueController.isPaymentListLoading.value == 1)
                                  _paymentDueController.paymentDueList.value.length!=0?
                                  Expanded(
                                    child: ListView.builder(
                                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: _paymentDueController.paymentDueList.value.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          int diff=0;
                                          double perc=0.0;
                                          List<MonthList> monthList = [
                                            // BubbleData(sender: 'Not Me', text: 'Hey Mi', isMe: false),
                                            // BubbleData(sender: 'Not Me', text: 'What\'s new?', isMe: false)
                                          ];
                                          if(_paymentDueController.paymentDueList[index].planData!.isNotEmpty)
                                          {
                                            DateTime dt = DateTime.parse(_paymentDueController.paymentDueList[index].planData![0].fldStartDate.toString());
                                            int a =dt.month;
                                            int yr =dt.year;
                                            int b =DateTime.now().month;
                                            int difference = b-a+1;
                                            diff = int.parse(_paymentDueController.paymentDueList[index].planData![0].fldDuration.toString())-_paymentDueController.paymentDueList[index].paymentData!.length;
                                            perc= double.parse(_paymentDueController.paymentDueList[index].paymentData!.length.toString())/double.parse(_paymentDueController.paymentDueList[index].planData![0].fldDuration.toString());


                                            int i=a;
                                            int d=_paymentDueController.paymentDueList[index].paymentData!.length;
                                            // print(a);
                                            // print(int.parse(_paymentDueController.paymentDueList[index].planData![0].fldDuration.toString()));
                                            for(int j=1;j<=int.parse(_paymentDueController.paymentDueList[index].planData![0].fldDuration.toString());j++){

                                              String mName="";
                                              if(i==1)
                                              {
                                                mName="Jan";
                                              }
                                              if(i==2)
                                              {
                                                mName="Feb";
                                              }
                                              if(i==3)
                                              {
                                                mName="March";
                                              }
                                              if(i==4)
                                              {
                                                mName="April";
                                              }
                                              if(i==5)
                                              {
                                                mName="May";
                                              }
                                              if(i==6)
                                              {
                                                mName="June";
                                              }
                                              if(i==7)
                                              {
                                                mName="July";
                                              }
                                              if(i==8)
                                              {
                                                mName="Aug";
                                              }
                                              if(i==9)
                                              {
                                                mName="Sep";
                                              }
                                              if(i==10)
                                              {
                                                mName="Oct";
                                              }
                                              if(i==11)
                                              {
                                                mName="Nov";
                                              }
                                              if(i==12)
                                              {
                                                mName="Dec";
                                              }
                                              bool clr=false;
                                              if(d>0)
                                              {
                                                clr=true;
                                              }
                                              else{
                                                clr=false;
                                              }

                                              if(i<12)
                                              {
                                                monthList.add(MonthList(name: mName, color: clr,ind: i,year: yr));
                                              }
                                              if(i<24)
                                              {
                                                monthList.add(MonthList(name: mName, color: clr,ind: i,year: yr+1));
                                              }
                                              if(i<36)
                                              {
                                                monthList.add(MonthList(name: mName, color: clr,ind: i,year: yr+2));
                                              }
                                              if(i<48)
                                              {
                                                monthList.add(MonthList(name: mName, color: clr,ind: i,year: yr+3));
                                              }
                                              if(i<60)
                                              {
                                                monthList.add(MonthList(name: mName, color: clr,ind: i,year: yr+4));
                                              }

                                              i++;
                                              d--;
                                            }
                                          }

                                          return diff>0?
                                          Container(
                                            color: Colors.transparent,
                                            padding: const EdgeInsets.all(0),
                                            margin: const EdgeInsets.all(0),
                                            child: Padding(
                                              padding: const EdgeInsets.all(0),
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0),
                                                ),
                                                elevation: 0.5,
                                                child: Container(
                                                  padding: const EdgeInsets.all(10),
                                                  width: width * 0.83,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Expanded(
                                                              flex:7,
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  textWidget("${_paymentDueController.paymentDueList.value[index].fldGroupName}".toTitleCase(), 20, FontWeight.bold, 'Lato',
                                                                      0xff000000, '', false),
                                                                  const SizedBox(height: 10,),
                                                                  textWidget(_paymentDueController.paymentDueList.value[index].planData![0].fldPlanName.toString().toTitleCase(), 15, FontWeight.w500, 'Lato',
                                                                      0xff000000, '', false),
                                                                ],
                                                              )
                                                          ),

                                                          // Expanded(
                                                          //   flex:3,
                                                          //     child: CircularPercentIndicator(
                                                          //       radius: 40.0,
                                                          //       lineWidth: 10.0,
                                                          //       animation: true,
                                                          //       percent: perc,
                                                          //       center: Text(
                                                          //         "${_paymentDueController.paymentDueList[index].paymentData!.length}/${_paymentDueController.paymentDueList[index].planData![0].fldDuration}",
                                                          //         style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13.0),
                                                          //       ),
                                                          //       // footer: new Text(
                                                          //       //   "Sales this week",
                                                          //       //   style:
                                                          //       //   new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                                                          //       // ),
                                                          //       circularStrokeCap: CircularStrokeCap.round,
                                                          //       progressColor: Colors.red.shade400,
                                                          //     ),
                                                          // ),
                                                          Expanded(
                                                            flex:3,
                                                            child: CircularPercentIndicator(
                                                              radius: 40.0,
                                                              animation: true,
                                                              animationDuration: 1200,
                                                              lineWidth: 10.0,
                                                              percent: perc,
                                                              center: Text(
                                                                "${_paymentDueController.paymentDueList[index].paymentData!.length}/${_paymentDueController.paymentDueList[index].planData![0].fldDuration}",
                                                                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13.0),
                                                              ),
                                                              circularStrokeCap: CircularStrokeCap.butt,
                                                              backgroundColor: Colors.redAccent.shade200,
                                                              progressColor: Colors.green,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.00,
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                                        child: Row(
                                                          children: [
                                                            textWidget("Amount:", 12, FontWeight.bold, 'Lato',
                                                                0xff000000, '', false),
                                                            const Spacer(),
                                                            textWidget("${_paymentDueController.paymentDueList.value[index].planData![0].fldDueAmount}", 12, FontWeight.bold, 'Lato',
                                                                0xffC0C0C0, '', false),
                                                            Padding(
                                                              padding: const EdgeInsets.all(5),
                                                              child: Icon(Icons.monetization_on,color: HexColor(blue_color),size: 18,),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.01,
                                                      ),
                                                      _paymentDueController.paymentDueList.value[index].paymentData!.length==0?
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                                        child: Row(
                                                          children: [
                                                            textWidget("No previous payment received.", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                                          ],
                                                        ),
                                                      ):
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                                        child: Row(

                                                          children: [
                                                            textWidget("Last Payment on:", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                                            const Spacer(),
                                                            textWidget(_paymentDueController.paymentDueList.value[index].paymentData!.last.fldPaymentDate.toString(), 12, FontWeight.bold, 'Lato',
                                                                0xffC0C0C0, '', false),
                                                            Padding(
                                                              padding: const EdgeInsets.all(5),
                                                              child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ):
                                          Container(
                                            color: Colors.transparent,

                                          );
                                        }),
                                  ):Container(
                                    padding:EdgeInsets.all(20),
                                    height: 150,
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(Radius.circular(8))),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        textWidget(
                                            'Due Payments'
                                                .tr,
                                            18,
                                            FontWeight.bold,
                                            'Lato',
                                            0xff004C88,
                                            '',
                                            false),
                                        Spacer(),
                                        SvgPicture.asset(
                                          width: 40,
                                          height: 40,
                                          'assets/images/no_payment.svg',
                                          color: Color(0xff125AAB),
                                        ),
                                        Center(
                                          child: textWidget(
                                              "You don't have any due payment",
                                              13,
                                              FontWeight.w400,
                                              'Lato',
                                              0xff125AAB,
                                              '',
                                              false),
                                        ),
                                        // Center(
                                        //   child: textWidget(
                                        //       "Tap to add new member",
                                        //       13,
                                        //       FontWeight.w400,
                                        //       'Lato',
                                        //       0xff125AAB,
                                        //       '',
                                        //       false),
                                        // ),
                                      ],
                                    ),
                                  )
                                ,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),

    );
  }

  categoryListItem(int index) {
    return InkWell(
      onTap: () {
        Get.to(GroupDetailView(
            "home",
            '${_homeController.groupList.value[index].fldGroupId}',
            '${_homeController.groupList.value[index].fldGroupName}'));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: SizedBox(
          height: 120,
          child: Column(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor:
                    Color((math.Random().nextDouble() * 0xffffffff).toInt())
                        .withOpacity(1.0),
                child: Center(
                  child: textWidget(
                      "${_homeController.groupList.value[index].fldGroupName!}"
                          .toUpperCase()[0],
                      18,
                      FontWeight.bold,
                      'Lato',
                      0xffffffff,
                      '',
                      false),
                ),

                // AssetImage("assets/images/demoimage.png"),
              ),
              const SizedBox(
                height: 14,
              ),
              textWidget(
                  "${_homeController.groupList.value[index].fldGroupName!}",
                  12,
                  FontWeight.normal,
                  'Lato',
                  0xff000000,
                  '',
                  false)
            ],
          ),
        ),
      ),
    );
  }

  memberListItem(int index) {
    return InkWell(
      onTap: () {
        Get.to(MemberProfile('${_homeController.memberList.value[index].id}',
            '${_homeController.memberList.value[index].email}'));
        // print('${_homeController.memberList.value[index].email}');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 0.0),
        child: SizedBox(
          height: 120,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 0,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 0,
                    ),
                    Container(
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                          color: Color(0xffCBCACA),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Container(
                          // height: 150,
                          // width: 150,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const ClipOval(
                            child: Icon(Icons.person),
                          ),
                        )),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Align(
                        child: textWidget(
                            "${_homeController.memberList.value[index].firstName!} ${_homeController.memberList.value[index].lastName!}",
                            12,
                            FontWeight.w400,
                            'Lato',
                            0xff004C88,
                            'c',
                            false),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}

class ItemTile extends StatelessWidget {
  final int itemNo;

  const ItemTile(
    this.itemNo,
  );

  @override
  Widget build(BuildContext context) {
    final Color color = Colors.primaries[itemNo % Colors.primaries.length];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0.5,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 0,
              ),
              SvgPicture.asset(
                width: 30,
                height: 30,
                'assets/images/group.svg',
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0)),
                ),
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
