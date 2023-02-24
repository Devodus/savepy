import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/UiElements/size_config.dart';
import 'package:savepy/app/UiElements/widget.dart';
import 'package:savepy/app/modules/add_installment_plan/view/add_installment_plan_view.dart';
import 'package:savepy/app/modules/assign_member_to_group/view/assign_member.dart';
import 'package:savepy/app/modules/assign_member_to_group/view/assign_member_view.dart';
import 'package:savepy/app/modules/group_detail/controller/group_detail_controller.dart';
import 'package:savepy/app/modules/landing_page/view/landing_view.dart';
import 'package:savepy/app/payment_module/payment_sheet/payment_sheet_screen_custom_flow.dart';
import 'dart:math' as math;
import 'package:shimmer/shimmer.dart';

import '../../group_list/controller/group_list_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../payment_due/controller/payment_due_controller.dart';
import '../../payment_history/controller/payment_history_controller.dart';

class GroupDetailView extends GetView<GroupDetailController> {
  final String? lastPage;
  final String? groupId;
  final String? groupName;

  GroupDetailView(this.lastPage, this.groupId, this.groupName);

  @override
  Widget build(BuildContext context) {
    GroupDetailController _groupDetailController = Get.put(GroupDetailController(groupId));
    HomeController _homeController = Get.put(HomeController());
    PaymentHistoryController _paymentHistoryController = Get.put(PaymentHistoryController());
    PaymentDueController _paymentDueController = Get.put(PaymentDueController());
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() => SafeArea(
      child: Scaffold(

            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                // Status bar color
                statusBarColor: Colors.red,

                // Status bar brightness (optional)
                statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
                statusBarBrightness: Brightness.dark, // For iOS (dark icons)
              ),
              elevation: 0,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    {
                      Navigator.pop(context);
                    }
                  }),
              backgroundColor: HexColor(blue_color),
              centerTitle: true,
              title: textWidget(
                  groupName!, 18, FontWeight.bold, 'Lato', 0xffffffff, '', false),
              actions: [
                _groupDetailController.isLeader.value?
                IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.defaultDialog(
                          title: "Alert!",
                          textCancel: "No",
                          textConfirm: "Yes",
                          onCancel: (){
                            // _groupDetailController.getMemberList(groupId!).whenComplete(() => _groupDetailController.update());

                          },
                          buttonColor: Color(0xff004C88),
                          confirmTextColor: Colors.white,
                          cancelTextColor: Color(0xff004C88),
                          onConfirm: (){

                            _groupDetailController
                                .deleteGroup(groupId!)
                                .whenComplete(() =>
                                _homeController.getGroupList().whenComplete(() => _paymentDueController.getPaymentDueList().whenComplete(() => _paymentHistoryController.getPaymentHistoryList())));

                            Get.offAll(LandingPage());
                            // Get.back();
                          },
                          middleText: "Are you sure you want to delete this group?"

                      );
                    }):Container(),
                // IconButton(
                //     icon: SvgPicture.asset(
                //       'assets/images/bell.svg',
                //       fit: BoxFit.fitHeight,
                //       color: Colors.black,
                //     ),
                //     onPressed: () {
                //       // Get.to(NotificationView());
                //     }),
              ],
            ),
            bottomNavigationBar: Stack(
              children: [
                Container(
                  height: 50,
                  alignment: Alignment.center,
                  width: width,
                  // decoration: BoxDecoration(
                  //     boxShadow: <BoxShadow>[
                  //       BoxShadow(
                  //           color: Colors.white,
                  //           blurRadius: 2.0,
                  //           offset: Offset(0.0, -1))
                  //     ],
                  //     color: Colors.white,
                  //     borderRadius:
                  //     BorderRadius.vertical(top: Radius.circular(20.0))),
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => Cart()));
                          _groupDetailController.isOnPlanList.value = false;
                          _groupDetailController.isOnMemberList.value = true;
                        },
                        child: Container(
                          alignment: Alignment.center,
                          color: _groupDetailController.isOnMemberList.value
                              ? HexColor(blue_color)
                              : Colors.white,
                          width: width / 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              SvgPicture.asset(
                                'assets/images/profile.svg',
                                color: _groupDetailController.isOnMemberList.value
                                    ? Colors.white
                                    : HexColor(blue_color),
                              ),
                              Expanded(
                                child: textWidget(
                                    'Member List',
                                    16,
                                    FontWeight.normal,
                                    'Lato',
                                    _groupDetailController.isOnMemberList.value
                                        ? 0xffFFFFFF
                                        : 0xff004C88,
                                    '',
                                    false),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Material(
                        child: InkWell(
                          // borderRadius: BorderRadius.circular(100),
                          // splashColor: Colors.black,
                          // highlightColor: Colors.black,
                          onTap: () {
                            _groupDetailController.isOnPlanList.value = true;
                            _groupDetailController.isOnMemberList.value = false;
                            // Navigator.push( context,MaterialPageRoute(builder: (context) => AddInstallmentPlanView("group_detail",groupId)),);
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (context) => Cart()));
                            // _productDetailController.addToCart("${_productDetailController.user.value?.response?.sId}", "1", "${_productDetailController.user.value?.response?.esin}");
                            //
                            // _productDetailController.getCartCount();
                            // _productDetailController.update();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: width / 2,
                            color: _groupDetailController.isOnPlanList.value
                                ? Color(0xff004C88)
                                : Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                SvgPicture.asset('assets/images/cash.svg',
                                    color:
                                        _groupDetailController.isOnPlanList.value
                                            ? Colors.white
                                            : HexColor(blue_color)),
                                Expanded(
                                  child: textWidget(
                                      'Your Plans',
                                      16,
                                      FontWeight.normal,
                                      'Lato',
                                      _groupDetailController.isOnPlanList.value
                                          ? 0xffFFFFFF
                                          : 0xff004C88,
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
              ],
            ),
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                width: context.width,
                height: context.height,
                child: SingleChildScrollView(
                  child: _groupDetailController.isOnMemberList.value
                      ? Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0,
                                  left: 24.0,
                                  right: 24,
                                  bottom: height * 0.01),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget('Group Members', 15, FontWeight.bold,
                                      'Lato', 0xff000000, '', false),
                                  _groupDetailController.isMemberListLoading.value==0?
                                  Container():
                                  _groupDetailController.planList.isEmpty
                                      ? InkWell(
                                          borderRadius: BorderRadius.circular(10),
                                          splashColor: Colors.grey,
                                          onTap: () {
                                            if (_groupDetailController.userId == _groupDetailController.leaderDetails[0].userId)
                                            {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AssignMembers(groupId: groupId)));
                                            }
                                            else
                                            {
                                              Fluttertoast.showToast(
                                                  msg: "Only leader can add new members.",
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.CENTER,
                                                  backgroundColor: Colors.black54,
                                                  textColor: Colors.white,
                                                  timeInSecForIosWeb: 1);
                                            }

                                            // Get.to(MyTst());
                                          },
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.all(2),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Color(0xff004C88),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    top: 0,
                                                    bottom: 0),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    textWidget(
                                                        'Add new  '.tr,
                                                        12,
                                                        FontWeight.bold,
                                                        'Lato',
                                                        0xffFFFFFF,
                                                        '',
                                                        false),
                                                    CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Color(0xff004C88),
                                                        size: 15,
                                                      ),
                                                      // AssetImage("assets/images/demoimage.png"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))
                                      : Container(),
                                ],
                              ),
                            ),
                            if (_groupDetailController.isMemberListLoading.value == 1)
                              Container(
                                child: _groupDetailController
                                        .memberList.value.isNotEmpty
                                    ? Padding(
                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        // child: Row(
                                        //   mainAxisAlignment:
                                        //   MainAxisAlignment.spaceEvenly,
                                        //   // crossAxisAlignment: CrossAxisAlignment.start,
                                        //   children: [
                                        //     CircleAvatar(
                                        //       radius: 30,
                                        //       backgroundColor:  Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                        //       child: textWidget(
                                        //           '${_groupDetailController.planList.value[index].fldGroupName.toString()[0].toUpperCase()}',
                                        //           24,
                                        //           FontWeight.bold,
                                        //           'Lato',
                                        //           0xffffffff,
                                        //           '',
                                        //           false),
                                        //       // AssetImage("assets/images/demoimage.png"),
                                        //     ),
                                        //
                                        //     Container(
                                        //       // height: height * 0.17,
                                        //       // width: width * 0.3,
                                        //       child: textWidget(
                                        //           '${_groupDetailController.planList.value[index].fldGroupName}',
                                        //           16,
                                        //           FontWeight.normal,
                                        //           'Lato',
                                        //           0xffA8A8A8,
                                        //           'c',
                                        //           false),
                                        //     ),
                                        //
                                        //   ],
                                        // ),
                                        child: Card(
                                          elevation: 1,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                20, 20, 20, 20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                textWidget(
                                                    "${_groupDetailController.leaderDetails.first.firstName} ${_groupDetailController.leaderDetails.first.lastName} (leader)",
                                                    16,
                                                    FontWeight.bold,
                                                    'Lato',
                                                    0xff000000,
                                                    '',
                                                    false),
                                                SizedBox(
                                                  height: height * 0.00,
                                                ),
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      textWidget(
                                                          "Email:",
                                                          12,
                                                          FontWeight.bold,
                                                          'Lato',
                                                          0xff000000,
                                                          '',
                                                          false),
                                                      Spacer(),
                                                      textWidget(
                                                          "${_groupDetailController.leaderDetails.first.email}",
                                                          12,
                                                          FontWeight.bold,
                                                          'Lato',
                                                          0xffC0C0C0,
                                                          '',
                                                          false),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                                  child: Row(
                                                    children: [
                                                      textWidget(
                                                          "Mobile:",
                                                          12,
                                                          FontWeight.bold,
                                                          'Lato',
                                                          0xff000000,
                                                          '',
                                                          false),
                                                      Spacer(),
                                                      textWidget(
                                                          "${_groupDetailController.leaderDetails.first.fldMobile}",
                                                          12,
                                                          FontWeight.bold,
                                                          'Lato',
                                                          0xffC0C0C0,
                                                          '',
                                                          false),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(

                                      ),
                              ),
                            if (_groupDetailController.isMemberListLoading.value == 1)
                              Container(
                                child: _groupDetailController
                                        .memberList.value.isNotEmpty
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        itemCount: _groupDetailController.memberList.value.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return '${_groupDetailController.memberList.value[index].belongToGroup}' ==
                                                  "true"
                                              ? Dismissible(
                                            direction: _groupDetailController.userId.value == _groupDetailController.leaderDetails[0].userId ? DismissDirection.horizontal : DismissDirection.none,
                                            key: UniqueKey(),
                                            background: Container(
                                              color: Colors.red,
                                              margin: const EdgeInsets.symmetric(
                                                  horizontal: 15),
                                              alignment: Alignment.centerRight,
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                            onDismissed: (_) {
                                              if (_groupDetailController.memberList.value[index].id == _groupDetailController.leaderDetails[0].userId)
                                                {
                                                  Get.snackbar(
                                                    backgroundColor: Colors.white,
                                                    snackPosition: SnackPosition.BOTTOM,
                                                    "Delete Member",
                                                    "You can't remove yourself from the group.Please contact admin for the same.",
                                                  );
                                                  _groupDetailController.getMemberList(groupId!).whenComplete(() => _groupDetailController.update());

                                                }
                                              else{
                                                Get.defaultDialog(
                                                    title: "Alert!",
                                                    textCancel: "No",
                                                    textConfirm: "Yes",
                                                    onCancel: (){
                                                      _groupDetailController.getMemberList(groupId!).whenComplete(() => _groupDetailController.update());

                                                    },
                                                    buttonColor: Color(0xff004C88),
                                                    confirmTextColor: Colors.white,
                                                    cancelTextColor: Color(0xff004C88),
                                                    onConfirm: (){
                                                      _groupDetailController
                                                          .deleteMember("${_groupDetailController.memberList.value[index].id}",groupId!)
                                                          .whenComplete(() =>
                                                          _groupDetailController.getMemberList(groupId!))
                                                          .whenComplete(() =>
                                                          _groupDetailController.update());

                                                      Get.back();
                                                    },
                                                    middleText: "Are you sure you want to delete the member from this group?"

                                                );
                                              }



                                            },
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              child: InkWell(
                                                onTap: () {
                                                  // Get.to(MemberDetailView("home", '${_groupDetailController.memberList.value[index].fldMemberId}', '${_groupDetailController.memberList.value[index].fldMemberName}'));
                                                },
                                                child: Card(
                                                  elevation: 1,
                                                  child: ListTile(
                                                    contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                    leading: CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor: Color(
                                                          (math.Random()
                                                              .nextDouble() *
                                                              0x004C88)
                                                              .toInt())
                                                          .withOpacity(1.0),


                                                      child: Center(
                                                        child: textWidget(
                                                            '${_groupDetailController.memberList.value[index].firstName.toString()[0].toUpperCase()}',
                                                            18,
                                                            FontWeight.bold,
                                                            'Lato',
                                                            0xffffffff,
                                                            '',
                                                            false),
                                                      ),
                                                      // AssetImage("assets/images/demoimage.png"),
                                                    ),
                                                    title: textWidget(
                                                        '${_groupDetailController.memberList.value[index].firstName} ${_groupDetailController.memberList.value[index].lastName}',
                                                        16,
                                                        FontWeight.normal,
                                                        'Lato',
                                                        0xff000000,
                                                        '',
                                                        false),
                                                    subtitle: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        textWidget(
                                                            '${_groupDetailController.memberList.value[index].email}',
                                                            12, FontWeight.normal, 'Lato', 0xffA4A4A4, '', false),
                                                        '${_groupDetailController.memberList.value[index].userPaymentEligibility}'=="1"?
                                                        textWidget(
                                                            '${_groupDetailController.memberList.value[index].userPaymentEligibility}',
                                                            12, FontWeight.normal, 'Lato', 0xffA4A4A4, '', false):Container(),
                                                      ],
                                                    ),



                                                    trailing: PopupMenuButton(
                                                        icon: Icon(Icons.more_vert,color: Colors.grey), // add this line
                                                        itemBuilder: (_) => <PopupMenuItem<String>>[
                                                          new PopupMenuItem<String>(
                                                              child: Container(
                                                                  width: 100,
                                                                  // height: 30,
                                                                  child: Text(
                                                                    "Set Priority",
                                                                    style: TextStyle(color: Colors.black45),
                                                                  )), value: 'set'),

                                                        ],
                                                        onSelected: (index) async {
                                                          switch (index) {
                                                            case 'set':
                                                              Get.defaultDialog(
                                                                title: "Assign new members",
                                                                textCancel: "Cancel",
                                                                textConfirm: "Confirm",
                                                                onCancel: (){
                                                                  // navigator.pop();
                                                                },
                                                                content: Column(
                                                                  // mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    ClipOval(
                                                                      child:Image.asset("assets/images/logo.png",
                                                                        height: 80,
                                                                        width: 80,
                                                                        fit:BoxFit.fitWidth,),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 10.0,
                                                                    ),
                                                                    Text(
                                                                      'Are you sure you wants to set this member for priority for this month?',
                                                                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                  ],
                                                                ),
                                                                buttonColor: Color(0xff004C88),
                                                                confirmTextColor: Colors.white,
                                                                cancelTextColor: Color(0xff004C88),
                                                                onConfirm: (){
                                                                  // _groupDetailController.setPriority(groupId);
                                                                  _groupDetailController.setPriority();
                                                                  Get.back();
                                                                },
                                                                // middleText: "Are you sure you want to logout?"

                                                              );
                                                              // showDialog(
                                                              //     barrierDismissible: true,
                                                              //     context: context,
                                                              //     builder: (context) => ReportUser(
                                                              //       currentUser: widget.sender,
                                                              //       seconduser: widget.second,
                                                              //     )).then((value) => Navigator.pop(ct))
                                                              break;
                                                          }
                                                        }),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                              : Container();
                                        })
                                    : Container(
                                  padding:EdgeInsets.all(20),
                                  height: height/3,
                                  // decoration: const BoxDecoration(
                                  //     color: Colors.white,
                                  //     borderRadius: BorderRadius.all(Radius.circular(8))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [

                                      Spacer(),
                                      SvgPicture.asset(
                                        width: 40,
                                        height: 40,
                                        'assets/images/no_member.svg',
                                        color: Color(0xff125AAB),
                                      ),
                                      Center(
                                        child: textWidget(
                                            "You didn't added any members to this group",
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
                              ),
                            if (_groupDetailController
                                    .isMemberListLoading.value ==
                                0)
                              Center(
                                child: Container(
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      itemCount: 1,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Center(
                                          child: Opacity(
                                            opacity: 0.8,
                                            child: Shimmer.fromColors(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                child: Card(
                                                  elevation: 1,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(10)),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(
                                                        20, 20, 20, 20),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        textWidget(
                                                            "",
                                                            16,
                                                            FontWeight.bold,
                                                            'Lato',
                                                            0xff000000,
                                                            '',
                                                            false),
                                                        SizedBox(
                                                          height: height * 0.00,
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: Row(
                                                            children: [
                                                              textWidget(
                                                                  "Email:",
                                                                  12,
                                                                  FontWeight.bold,
                                                                  'Lato',
                                                                  0xff000000,
                                                                  '',
                                                                  false),
                                                              Spacer(),
                                                              textWidget(
                                                                  "",
                                                                  12,
                                                                  FontWeight.bold,
                                                                  'Lato',
                                                                  0xffC0C0C0,
                                                                  '',
                                                                  false),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: Row(
                                                            children: [
                                                              textWidget(
                                                                  "Mobile:",
                                                                  12,
                                                                  FontWeight.bold,
                                                                  'Lato',
                                                                  0xff000000,
                                                                  '',
                                                                  false),
                                                              Spacer(),
                                                              textWidget(
                                                                  "",
                                                                  12,
                                                                  FontWeight.bold,
                                                                  'Lato',
                                                                  0xffC0C0C0,
                                                                  '',
                                                                  false),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              baseColor: Colors.grey.shade300,
                                              highlightColor: Colors.grey.shade50,
                                              loop: 10,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            if (_groupDetailController
                                    .isMemberListLoading.value ==
                                0)
                              Center(
                                child: Container(
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      itemCount: 3,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Center(
                                          child: Opacity(
                                            opacity: 0.8,
                                            child: Shimmer.fromColors(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                child: Card(
                                                  elevation: 1,
                                                  child: ListTile(
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 0, 10, 0),
                                                    leading: CircleAvatar(
                                                      radius: 20,
                                                      backgroundColor: Color((math
                                                                          .Random()
                                                                      .nextDouble() *
                                                                  0x004C88)
                                                              .toInt())
                                                          .withOpacity(1.0),
                                                      child: Center(
                                                        child: textWidget(
                                                            '',
                                                            18,
                                                            FontWeight.bold,
                                                            'Lato',
                                                            0xffffffff,
                                                            '',
                                                            false),
                                                      ),
                                                      // AssetImage("assets/images/demoimage.png"),
                                                    ),
                                                    title: textWidget(
                                                        '',
                                                        16,
                                                        FontWeight.normal,
                                                        'Lato',
                                                        0xff000000,
                                                        '',
                                                        false),
                                                    subtitle: textWidget(
                                                        '',
                                                        12,
                                                        FontWeight.normal,
                                                        'Lato',
                                                        0xffA4A4A4,
                                                        '',
                                                        false),
                                                  ),
                                                ),
                                              ),
                                              baseColor: Colors.grey.shade300,
                                              highlightColor: Colors.grey.shade50,
                                              loop: 10,
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            if (_groupDetailController
                                    .isMemberListLoading.value ==
                                2)
                              Container(
                                child: Center(child: Text("No Data found")),
                              ),
                          ],
                        )
                      : Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 24.0, right: 24, bottom: height * 0.01),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      'Your Installment Plan',
                                      15,
                                      FontWeight.bold,
                                      'Lato',
                                      0xff000000,
                                      '',
                                      false),
                                  _groupDetailController.planList.isEmpty
                                      ? InkWell(
                                          borderRadius: BorderRadius.circular(10),
                                          splashColor: Colors.grey,
                                          onTap: () {
                                            // Get.defaultDialog(
                                            //     contentPadding: EdgeInsets.fromLTRB(10,0,10,10),
                                            //     title: 'Create New Plan',
                                            //     content:  SizedBox(
                                            //       width: double.maxFinite,
                                            //       child: ListView(
                                            //         shrinkWrap: true, // <-- Set this to true
                                            //         children: [
                                            //
                                            //           TextField(
                                            //             enableInteractiveSelection: false,
                                            //             controller: _groupDetailController.planNameController,
                                            //             keyboardType: TextInputType.text,
                                            //             maxLines: 1,
                                            //             decoration: InputDecoration(
                                            //                 labelText: 'Plan Name',
                                            //                 hintMaxLines: 1,
                                            //                 border: OutlineInputBorder(
                                            //                     borderSide: BorderSide(color: Colors.green, width: 4.0))),
                                            //           ),
                                            //           SizedBox(
                                            //             height: 10.0,
                                            //           ),
                                            //           TextField(
                                            //             enableInteractiveSelection: false,
                                            //             controller: _groupDetailController.amountController,
                                            //             keyboardType: TextInputType.number,
                                            //             maxLines: 1,
                                            //             decoration: InputDecoration(
                                            //                 labelText: 'Amount',
                                            //                 hintMaxLines: 1,
                                            //                 border: OutlineInputBorder(
                                            //                     borderSide: BorderSide(color: Colors.green, width: 4.0))),
                                            //           ),
                                            //           SizedBox(
                                            //             height: 10.0,
                                            //           ),
                                            //           TextField(
                                            //             enableInteractiveSelection: false,
                                            //             controller: _groupDetailController.durationController,
                                            //             keyboardType: TextInputType.number,
                                            //             maxLines: 1,
                                            //             decoration: InputDecoration(
                                            //                 labelText: 'Duration (in months)',
                                            //                 hintMaxLines: 1,
                                            //                 border: OutlineInputBorder(
                                            //                     borderSide: BorderSide(color: Colors.green, width: 4.0))),
                                            //           ),
                                            //           SizedBox(
                                            //             height: 10.0,
                                            //           ),
                                            //           RaisedButton(
                                            //             onPressed: () {
                                            //               if(_groupDetailController.planNameController.text.isEmpty)
                                            //               {
                                            //                 Get.snackbar(
                                            //                   backgroundColor: Colors.white,
                                            //                   snackPosition: SnackPosition.BOTTOM,
                                            //                   "Create Plan",
                                            //                   "Please enter plan name",
                                            //                 );
                                            //               }else  if(_groupDetailController.amountController.text.isEmpty)
                                            //               {
                                            //                 Get.snackbar(
                                            //                   backgroundColor: Colors.white,
                                            //                   snackPosition: SnackPosition.BOTTOM,
                                            //                   "Create Plan",
                                            //                   "Please enter amount",
                                            //                 );
                                            //               }
                                            //               else  if(_groupDetailController.durationController.text.isEmpty)
                                            //               {
                                            //                 Get.snackbar(
                                            //                   backgroundColor: Colors.white,
                                            //                   snackPosition: SnackPosition.BOTTOM,
                                            //                   "Create Plan",
                                            //                   "Please enter duration",
                                            //                 );
                                            //               }
                                            //               else {
                                            //                 _groupDetailController.durationController.clear();
                                            //                 _groupDetailController.amountController.clear();
                                            //                 _groupDetailController.planNameController.clear();
                                            //                 _groupDetailController.addInstallmentPlan(groupId!);
                                            //                 _groupDetailController.getPlanList(groupId!);
                                            //                 _groupDetailController.update();
                                            //                 Get.back();
                                            //               }
                                            //
                                            //             },
                                            //             child: Text(
                                            //               'Create Plan',
                                            //
                                            //               style: TextStyle(color: Colors.white, fontSize: 16.0),
                                            //             ),
                                            //             color: Color(0xff004C88),
                                            //           )
                                            //         ],
                                            //       ),
                                            //     ),
                                            //
                                            //     radius: 10.0);
                                            if (_groupDetailController.userId == _groupDetailController.leaderDetails[0].userId)
                                              {
                                                if (!_groupDetailController
                                                    .isMyMemberListEmpty.value) {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AddInstallmentPlanView(
                                                                  "group_detail",
                                                                  groupId)));
                                                } else {
                                                  Get.defaultDialog(
                                                    title: "Assign new members",
                                                    textCancel: "Cancel",
                                                    textConfirm: "Confirm",
                                                    onCancel: () {
                                                      // navigator.pop();
                                                    },
                                                    content: Column(
                                                      // mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        ClipOval(
                                                          child: Image.asset(
                                                            "assets/images/logo.png",
                                                            height: 80,
                                                            width: 80,
                                                            fit: BoxFit.fitWidth,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10.0,
                                                        ),
                                                        Text(
                                                          'You need to add members first before creating an installment plan',
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 16.0),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                                    buttonColor: Color(0xff004C88),
                                                    confirmTextColor: Colors.white,
                                                    cancelTextColor:
                                                    Color(0xff004C88),
                                                    onConfirm: () {
                                                      Get.back();
                                                    },
                                                    // middleText: "Are you sure you want to logout?"
                                                  );
                                                }
                                              }
                                            else
                                              {
                                                Fluttertoast.showToast(
                                                    msg: "Only leader can create plan.",
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.CENTER,
                                                    backgroundColor: Colors.black54,
                                                    textColor: Colors.white,
                                                    timeInSecForIosWeb: 1);
                                              }

                                          },
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.all(2),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Color(0xff004C88),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    top: 0,
                                                    bottom: 0),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    textWidget(
                                                        'Add new  '.tr,
                                                        12,
                                                        FontWeight.bold,
                                                        'Lato',
                                                        0xffFFFFFF,
                                                        '',
                                                        false),
                                                    CircleAvatar(
                                                      radius: 7,
                                                      backgroundColor:
                                                          Colors.white,
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Color(0xff004C88),
                                                        size: 15,
                                                      ),
                                                      // AssetImage("assets/images/demoimage.png"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))
                                      : Container(),
                                ],
                              ),
                            ),
                            if (_groupDetailController.isplanListLoading.value == 1)
                              // Padding(
                              //     padding: EdgeInsets.only(left: 2, right: 2),
                              //     child: GridView.builder(
                              //       shrinkWrap: true,
                              //       physics: ClampingScrollPhysics(),
                              //       itemCount: _groupDetailController.planList.value.length,
                              //       itemBuilder: (context, index) => planListItem(index),
                              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //         crossAxisCount: 2,
                              //         childAspectRatio: 0.9,
                              //       ),
                              //     )
                              // ),
                              Container(
                                child:
                                    _groupDetailController.planList.value.length != 0
                                        ? ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            itemCount: _groupDetailController
                                                .planList.value.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              // _groupDetailController.getPaymentHistoryList("${_groupDetailController.planList.value[index].fldGroupId}");
                                              return Padding(
                                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                // child: Row(
                                                //   mainAxisAlignment:
                                                //   MainAxisAlignment.spaceEvenly,
                                                //   // crossAxisAlignment: CrossAxisAlignment.start,
                                                //   children: [
                                                //     CircleAvatar(
                                                //       radius: 30,
                                                //       backgroundColor:  Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                                                //       child: textWidget(
                                                //           '${_groupDetailController.planList.value[index].fldGroupName.toString()[0].toUpperCase()}',
                                                //           24,
                                                //           FontWeight.bold,
                                                //           'Lato',
                                                //           0xffffffff,
                                                //           '',
                                                //           false),
                                                //       // AssetImage("assets/images/demoimage.png"),
                                                //     ),
                                                //
                                                //     Container(
                                                //       // height: height * 0.17,
                                                //       // width: width * 0.3,
                                                //       child: textWidget(
                                                //           '${_groupDetailController.planList.value[index].fldGroupName}',
                                                //           16,
                                                //           FontWeight.normal,
                                                //           'Lato',
                                                //           0xffA8A8A8,
                                                //           'c',
                                                //           false),
                                                //     ),
                                                //
                                                //   ],
                                                // ),
                                                child: Card(
                                                  elevation: 1,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(10)),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(
                                                        20, 20, 20, 20),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        textWidget(
                                                            "${_groupDetailController.planList.value[index].fldPlanName}",
                                                            16,
                                                            FontWeight.bold,
                                                            'Lato',
                                                            0xff000000,
                                                            '',
                                                            false),
                                                        SizedBox(
                                                          height: height * 0.00,
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: Row(
                                                            children: [
                                                              textWidget(
                                                                  "Amount:",
                                                                  12,
                                                                  FontWeight.bold,
                                                                  'Lato',
                                                                  0xff000000,
                                                                  '',
                                                                  false),
                                                              Spacer(),
                                                              textWidget(
                                                                  "${_groupDetailController.planList.value[index].fldAmount}",
                                                                  12,
                                                                  FontWeight.bold,
                                                                  'Lato',
                                                                  0xffC0C0C0,
                                                                  '',
                                                                  false),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Icon(
                                                                  Icons
                                                                      .monetization_on,
                                                                  color: HexColor(
                                                                      blue_color),
                                                                  size: 18,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.fromLTRB(
                                                                  0, 0, 0, 0),
                                                          child: Row(
                                                            children: [
                                                              textWidget(
                                                                  "Duration:",
                                                                  12,
                                                                  FontWeight.bold,
                                                                  'Lato',
                                                                  0xff000000,
                                                                  '',
                                                                  false),
                                                              Spacer(),
                                                              textWidget(
                                                                  "${_groupDetailController.planList.value[index].fldDuration}",
                                                                  12,
                                                                  FontWeight.bold,
                                                                  'Lato',
                                                                  0xffC0C0C0,
                                                                  '',
                                                                  false),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Icon(
                                                                  Icons
                                                                      .calendar_today_rounded,
                                                                  color: HexColor(
                                                                      blue_color),
                                                                  size: 18,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        // Padding(
                                                        //   padding:
                                                        //       EdgeInsets.fromLTRB(
                                                        //           0, 0, 0, 0),
                                                        //   child: Row(
                                                        //     children: [
                                                        //       textWidget(
                                                        //           "",
                                                        //           12,
                                                        //           FontWeight.bold,
                                                        //           'Lato',
                                                        //           0xff000000,
                                                        //           '',
                                                        //           false),
                                                        //       Spacer(),
                                                        //       InkWell(
                                                        //           borderRadius:
                                                        //               BorderRadius
                                                        //                   .circular(
                                                        //                       10),
                                                        //           splashColor:
                                                        //               Colors.grey,
                                                        //           onTap: () {
                                                        //             Navigator.of(
                                                        //                     context)
                                                        //                 .push(
                                                        //               MaterialPageRoute(
                                                        //                 builder: (BuildContext context) =>
                                                        //                     PaymentSheetScreenWithCustomFlow(_groupDetailController.planList.value[index].fldAmount.toString()),
                                                        //               ),
                                                        //             );
                                                        //           },
                                                        //           child: Center(
                                                        //             child:
                                                        //                 Container(
                                                        //               padding:
                                                        //                   EdgeInsets
                                                        //                       .all(2),
                                                        //               alignment:
                                                        //                   Alignment
                                                        //                       .center,
                                                        //               decoration: BoxDecoration(
                                                        //                   color: Color(
                                                        //                       0xff004C88),
                                                        //                   borderRadius:
                                                        //                       BorderRadius.circular(
                                                        //                           15),
                                                        //                   border: Border.all(
                                                        //                       color:
                                                        //                           Colors.black)),
                                                        //               child:
                                                        //                   Padding(
                                                        //                 padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 0, bottom: 0),
                                                        //                 child:
                                                        //                     Row(
                                                        //                   crossAxisAlignment:
                                                        //                       CrossAxisAlignment.center,
                                                        //                   mainAxisAlignment:
                                                        //                       MainAxisAlignment.spaceBetween,
                                                        //                   children: [
                                                        //                     textWidget(
                                                        //                         'Pay here'.tr,
                                                        //                         12,
                                                        //                         FontWeight.bold,
                                                        //                         'Lato',
                                                        //                         0xffFFFFFF,
                                                        //                         '',
                                                        //                         false),
                                                        //                   ],
                                                        //                 ),
                                                        //               ),
                                                        //             ),
                                                        //           ))
                                                        //     ],
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            })
                                        : Container(
                                            child: Center(
                                                child: Column(
                                              children: [
                                                // SizedBox(
                                                //   height: height * 0.1,
                                                // ),
                                                // SvgPicture.asset(
                                                //   'assets/images/HeartOutLarge.svg',
                                                // ),
                                                // SizedBox(
                                                //   height: 15,
                                                // ),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 24.0, right: 24),
                                                  child: Align(
                                                    child: textWidget(
                                                        'You didn’t created any installment plans yet',
                                                        16,
                                                        FontWeight.normal,
                                                        'Lato',
                                                        0xffA8A8A8,
                                                        'c',
                                                        false),
                                                  ),
                                                ),
                                              ],
                                            )),
                                          ),
                              ),
                            if (_groupDetailController.isplanListLoading.value ==
                                0)
                              Center(
                                child: Container(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            if (_groupDetailController.isplanListLoading.value ==
                                2)
                              Container(
                                padding:EdgeInsets.all(20),
                                height: 150,
                                // decoration: const BoxDecoration(
                                //     color: Colors.white,
                                //     borderRadius: BorderRadius.all(Radius.circular(8))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [

                                    // Spacer(),
                                    SvgPicture.asset(
                                      width: 40,
                                      height: 40,
                                      'assets/images/cash.svg',
                                      color: Color(0xff125AAB),
                                    ),
                                    Center(
                                      child: textWidget(
                                          "You didn’t created any installment plans yet",
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

                            Padding(
                              padding: EdgeInsets.only(
                                  left: 24.0,
                                  right: 24,
                                  top: 5,
                                  bottom: height * 0.01),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  textWidget(
                                      'All Transactions',
                                      15,
                                      FontWeight.bold,
                                      'Lato',
                                      0xff000000,
                                      '',
                                      false),
                                ],
                              ),
                            ),
                            if (_groupDetailController
                                    .isGroupPaymentListLoading.value ==
                                1)
                              // Padding(
                              //     padding: EdgeInsets.only(left: 2, right: 2),
                              //     child: GridView.builder(
                              //       shrinkWrap: true,
                              //       physics: ClampingScrollPhysics(),
                              //       itemCount: _groupDetailController.planList.value.length,
                              //       itemBuilder: (context, index) => planListItem(index),
                              //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //         crossAxisCount: 2,
                              //         childAspectRatio: 0.9,
                              //       ),
                              //     )
                              // ),
                              Container(
                                child: _groupDetailController
                                            .groupPaymentHistoryList
                                            .value
                                            .length !=
                                        0
                                    ? ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        itemCount: _groupDetailController.groupPaymentHistoryList.value.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          // _groupDetailController.getPaymentHistoryList("${_groupDetailController.groupPaymentHistoryList.value[index].firstName}");
                                          return _groupDetailController
                                                      .groupPaymentHistoryList[index]
                                                      .paymentHistory
                                                      ?.length ==
                                                  0
                                              ? Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 0, 0),
                                            child: Card(
                                              elevation: 1,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.all(
                                                    Radius.circular(
                                                        10)),
                                              ),
                                              child: ExpansionTile(
                                                maintainState: true,
                                                backgroundColor:
                                                Colors.transparent,
                                                title: textWidget(
                                                    "${_groupDetailController.groupPaymentHistoryList.value[index].firstName} ${_groupDetailController.groupPaymentHistoryList.value[index].lastName}",
                                                    16,
                                                    FontWeight.bold,
                                                    'Lato',
                                                    0xff000000,
                                                    '',
                                                    false),
                                                subtitle: textWidget(
                                                    "${_groupDetailController.groupPaymentHistoryList.value[index].email}",
                                                    14,
                                                    FontWeight.bold,
                                                    'Lato',
                                                    0xffA4A4A4,
                                                    '',
                                                    false),
                                                children: [
                                                  Column(
                                                    children: [
                                                      // SizedBox(
                                                      //   height: height * 0.1,
                                                      // ),
                                                      SvgPicture.asset(
                                                        'assets/images/no_payment.svg',
                                                        width: 50,
                                                        height: 50,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 24.0, right: 24,bottom: 24),
                                                        child: Align(
                                                          child: textWidget(
                                                              'No payment has been made yet.',
                                                              16,
                                                              FontWeight.normal,
                                                              'Lato',
                                                              0xffA8A8A8,
                                                              'c',
                                                              false),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              // child: Padding(
                                              //   padding: EdgeInsets.fromLTRB(10,20,10,20),
                                              //   child: Column(
                                              //     mainAxisAlignment: MainAxisAlignment.start,
                                              //     crossAxisAlignment: CrossAxisAlignment.start,
                                              //     children: [
                                              //
                                              //       Padding(
                                              //         padding: EdgeInsets.fromLTRB(0,0,0,0),
                                              //         child: Row(
                                              //
                                              //           children: [
                                              //             textWidget("${_groupDetailController.groupPaymentHistoryList.value[index].firstName} ${_groupDetailController.groupPaymentHistoryList.value[index].lastName}", 16, FontWeight.bold, 'Lato',
                                              //                 0xff000000, '', false),
                                              //             Spacer(),
                                              //             textWidget("\$ ${_groupDetailController.groupPaymentHistoryList.value[index].email}", 12, FontWeight.bold, 'Lato',
                                              //                 0xffC0C0C0, '', false),
                                              //
                                              //           ],
                                              //         ),
                                              //       ),
                                              //       ListView.builder(
                                              //         physics: NeverScrollableScrollPhysics(),
                                              //           padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              //           itemCount: _groupDetailController.groupPaymentHistoryList[index].paymentHistory?.length,
                                              //           shrinkWrap: true,
                                              //           itemBuilder: (context, ind) {
                                              //             return _groupDetailController.groupPaymentHistoryList[index].paymentHistory?.length==0?
                                              //             Container():
                                              //             Padding(
                                              //               padding: const EdgeInsets.only(left: 0.0),
                                              //               child: Theme(
                                              //                 data: Theme.of(context)
                                              //                     .copyWith(dividerColor: Colors.transparent),
                                              //                 child: ExpansionTile(
                                              //                   maintainState: true,
                                              //                   backgroundColor: Colors.transparent,
                                              //                   title: Row(
                                              //                     mainAxisAlignment: MainAxisAlignment.start,
                                              //                     children: [
                                              //
                                              //                       // SvgPicture.asset(
                                              //                       //   'assets/images/Shoe.svg',
                                              //                       //   height: 20,
                                              //                       // ),
                                              //
                                              //                       textWidget("${_groupDetailController.groupPaymentHistoryList[index].firstName}", 15, FontWeight.normal, 'Lato',
                                              //                           0xff000000, '', false),
                                              //
                                              //                     ],
                                              //                   ),
                                              //                   children: [
                                              //                     GestureDetector(
                                              //                       onTap: () {
                                              //                         // Navigator.push(
                                              //                         //     context,
                                              //                         //     MaterialPageRoute(
                                              //                         //         builder: (context) => CategoriesPageTwo()));
                                              //                       },
                                              //                       child: Padding(
                                              //                         padding: EdgeInsets.only(left: width * 0.27),
                                              //                         child: Align(
                                              //                           alignment: Alignment.centerLeft,
                                              //                           child: InkWell(
                                              //                             onTap: (){
                                              //                               // Get.to(SubCategory("categories", "${_categoriesController.categoryData[index].sId}", "${_categoriesController.categoryData[index].children![ind].sId}","${_categoriesController.categoryData[index].name?.en}","${_categoriesController.categoryData[index].children![ind].name?.en}"));
                                              //                             },
                                              //                             child: Padding(
                                              //                               padding: EdgeInsets.only(
                                              //                                   left: 5.0, right: 14, bottom: 10),
                                              //                               child: textWidget("${_groupDetailController.groupPaymentHistoryList[index].paymentHistory![ind].fldAmount}", 16, FontWeight.normal,
                                              //                                   'Lato', 0xff000000, '', false),
                                              //                             ),
                                              //                           ),
                                              //                         ),
                                              //                       ),
                                              //                     )
                                              //                   ],
                                              //                 ),
                                              //               ),
                                              //             );
                                              //           }),
                                              //
                                              //     ],
                                              //   ),
                                              // ),
                                            ),
                                          )
                                              : Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 0, 0, 0),
                                                  child: Card(
                                                    elevation: 1,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    child: ExpansionTile(
                                                      maintainState: true,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      title: textWidget(
                                                          "${_groupDetailController.groupPaymentHistoryList.value[index].firstName} ${_groupDetailController.groupPaymentHistoryList.value[index].lastName}",
                                                          16,
                                                          FontWeight.bold,
                                                          'Lato',
                                                          0xff000000,
                                                          '',
                                                          false),
                                                      subtitle: textWidget(
                                                          "${_groupDetailController.groupPaymentHistoryList.value[index].email}",
                                                          14,
                                                          FontWeight.bold,
                                                          'Lato',
                                                          0xffA4A4A4,
                                                          '',
                                                          false),
                                                      children: [
                                                        ListView.builder(
                                                            physics:
                                                                NeverScrollableScrollPhysics(),
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    0, 0, 0, 0),
                                                            itemCount:
                                                                _groupDetailController
                                                                    .groupPaymentHistoryList[
                                                                        index]
                                                                    .paymentHistory
                                                                    ?.length,
                                                            shrinkWrap: true,
                                                            itemBuilder:
                                                                (context, ind) {
                                                              return _groupDetailController
                                                                          .groupPaymentHistoryList[
                                                                              index]
                                                                          .paymentHistory
                                                                          ?.length ==
                                                                      0
                                                                  ? Container()
                                                                  : Padding(
                                                                      padding:
                                                                          const EdgeInsets.fromLTRB(
                                                                              15,
                                                                              2,
                                                                              15,
                                                                              2),
                                                                      child: Theme(
                                                                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                                                          child: Column(
                                                                            children: [
                                                                              Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  textWidget("${_groupDetailController.groupPaymentHistoryList[index].paymentHistory![ind].fldPaymentDate}", 12, FontWeight.normal, 'Lato', 0xffA4A4A4, '', false),
                                                                                  Spacer(),
                                                                                  Padding(
                                                                                    padding: EdgeInsets.all(5),
                                                                                    child: Icon(
                                                                                      Icons.monetization_on,
                                                                                      color: Colors.green,
                                                                                      size: 18,
                                                                                    ),
                                                                                  ),
                                                                                  textWidget("${_groupDetailController.groupPaymentHistoryList[index].paymentHistory![ind].fldAmount}", 15, FontWeight.normal, 'Lato', 0xff000000, '', false),
                                                                                ],
                                                                              ),
                                                                              Divider(
                                                                                color: Colors.grey,
                                                                              )
                                                                            ],
                                                                          )),
                                                                    );
                                                            }),
                                                      ],
                                                    ),
                                                    // child: Padding(
                                                    //   padding: EdgeInsets.fromLTRB(10,20,10,20),
                                                    //   child: Column(
                                                    //     mainAxisAlignment: MainAxisAlignment.start,
                                                    //     crossAxisAlignment: CrossAxisAlignment.start,
                                                    //     children: [
                                                    //
                                                    //       Padding(
                                                    //         padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                    //         child: Row(
                                                    //
                                                    //           children: [
                                                    //             textWidget("${_groupDetailController.groupPaymentHistoryList.value[index].firstName} ${_groupDetailController.groupPaymentHistoryList.value[index].lastName}", 16, FontWeight.bold, 'Lato',
                                                    //                 0xff000000, '', false),
                                                    //             Spacer(),
                                                    //             textWidget("\$ ${_groupDetailController.groupPaymentHistoryList.value[index].email}", 12, FontWeight.bold, 'Lato',
                                                    //                 0xffC0C0C0, '', false),
                                                    //
                                                    //           ],
                                                    //         ),
                                                    //       ),
                                                    //       ListView.builder(
                                                    //         physics: NeverScrollableScrollPhysics(),
                                                    //           padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                    //           itemCount: _groupDetailController.groupPaymentHistoryList[index].paymentHistory?.length,
                                                    //           shrinkWrap: true,
                                                    //           itemBuilder: (context, ind) {
                                                    //             return _groupDetailController.groupPaymentHistoryList[index].paymentHistory?.length==0?
                                                    //             Container():
                                                    //             Padding(
                                                    //               padding: const EdgeInsets.only(left: 0.0),
                                                    //               child: Theme(
                                                    //                 data: Theme.of(context)
                                                    //                     .copyWith(dividerColor: Colors.transparent),
                                                    //                 child: ExpansionTile(
                                                    //                   maintainState: true,
                                                    //                   backgroundColor: Colors.transparent,
                                                    //                   title: Row(
                                                    //                     mainAxisAlignment: MainAxisAlignment.start,
                                                    //                     children: [
                                                    //
                                                    //                       // SvgPicture.asset(
                                                    //                       //   'assets/images/Shoe.svg',
                                                    //                       //   height: 20,
                                                    //                       // ),
                                                    //
                                                    //                       textWidget("${_groupDetailController.groupPaymentHistoryList[index].firstName}", 15, FontWeight.normal, 'Lato',
                                                    //                           0xff000000, '', false),
                                                    //
                                                    //                     ],
                                                    //                   ),
                                                    //                   children: [
                                                    //                     GestureDetector(
                                                    //                       onTap: () {
                                                    //                         // Navigator.push(
                                                    //                         //     context,
                                                    //                         //     MaterialPageRoute(
                                                    //                         //         builder: (context) => CategoriesPageTwo()));
                                                    //                       },
                                                    //                       child: Padding(
                                                    //                         padding: EdgeInsets.only(left: width * 0.27),
                                                    //                         child: Align(
                                                    //                           alignment: Alignment.centerLeft,
                                                    //                           child: InkWell(
                                                    //                             onTap: (){
                                                    //                               // Get.to(SubCategory("categories", "${_categoriesController.categoryData[index].sId}", "${_categoriesController.categoryData[index].children![ind].sId}","${_categoriesController.categoryData[index].name?.en}","${_categoriesController.categoryData[index].children![ind].name?.en}"));
                                                    //                             },
                                                    //                             child: Padding(
                                                    //                               padding: EdgeInsets.only(
                                                    //                                   left: 5.0, right: 14, bottom: 10),
                                                    //                               child: textWidget("${_groupDetailController.groupPaymentHistoryList[index].paymentHistory![ind].fldAmount}", 16, FontWeight.normal,
                                                    //                                   'Lato', 0xff000000, '', false),
                                                    //                             ),
                                                    //                           ),
                                                    //                         ),
                                                    //                       ),
                                                    //                     )
                                                    //                   ],
                                                    //                 ),
                                                    //               ),
                                                    //             );
                                                    //           }),
                                                    //
                                                    //     ],
                                                    //   ),
                                                    // ),
                                                  ),
                                                );
                                        })
                                    : Container(
                                        child: Center(
                                            child: Column(
                                          children: [
                                            // SizedBox(
                                            //   height: height * 0.1,
                                            // ),
                                            SvgPicture.asset(
                                              'assets/images/no_payment.svg',
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 24.0, right: 24),
                                              child: Align(
                                                child: textWidget(
                                                    'No payment has been made yet.',
                                                    16,
                                                    FontWeight.normal,
                                                    'Lato',
                                                    0xffA8A8A8,
                                                    'c',
                                                    false),
                                              ),
                                            ),
                                          ],
                                        )),
                                      ),
                              ),
                            if (_groupDetailController
                                    .isGroupPaymentListLoading.value ==
                                0)
                              Center(
                                child: Container(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            if (_groupDetailController
                                    .isGroupPaymentListLoading.value ==
                                2)
                              Container(
                                child: Center(child: Container(
                                  child: Center(
                                      child: Column(
                                        children: [
                                          // SizedBox(
                                          //   height: height * 0.1,
                                          // ),
                                          SvgPicture.asset(
                                            'assets/images/no_payment.svg',
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 24.0, right: 24),
                                            child: Align(
                                              child: textWidget(
                                                  'No payment has been made yet.',
                                                  16,
                                                  FontWeight.normal,
                                                  'Lato',
                                                  0xffA8A8A8,
                                                  'c',
                                                  false),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),),
                              ),
                            // if(_groupDetailController.isPaymentListLoading.value == 1)
                            //   Container(
                            //     child: _groupDetailController.paymentHistoryList.value.length!=0?
                            //     ListView.builder(
                            //         physics: NeverScrollableScrollPhysics(),
                            //         padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            //         itemCount: _groupDetailController.paymentHistoryList.value.length,
                            //         shrinkWrap: true,
                            //         itemBuilder: (context, index) {
                            //           return Padding(
                            //             padding: EdgeInsets.fromLTRB(0,0,0,0),
                            //             // child: Row(
                            //             //   mainAxisAlignment:
                            //             //   MainAxisAlignment.spaceEvenly,
                            //             //   // crossAxisAlignment: CrossAxisAlignment.start,
                            //             //   children: [
                            //             //     CircleAvatar(
                            //             //       radius: 30,
                            //             //       backgroundColor:  Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                            //             //       child: textWidget(
                            //             //           '${_groupDetailController.planList.value[index].fldGroupName.toString()[0].toUpperCase()}',
                            //             //           24,
                            //             //           FontWeight.bold,
                            //             //           'Lato',
                            //             //           0xffffffff,
                            //             //           '',
                            //             //           false),
                            //             //       // AssetImage("assets/images/demoimage.png"),
                            //             //     ),
                            //             //
                            //             //     Container(
                            //             //       // height: height * 0.17,
                            //             //       // width: width * 0.3,
                            //             //       child: textWidget(
                            //             //           '${_groupDetailController.planList.value[index].fldGroupName}',
                            //             //           16,
                            //             //           FontWeight.normal,
                            //             //           'Lato',
                            //             //           0xffA8A8A8,
                            //             //           'c',
                            //             //           false),
                            //             //     ),
                            //             //
                            //             //   ],
                            //             // ),
                            //             child: Card(
                            //               elevation: 1,
                            //               shape: RoundedRectangleBorder(
                            //                 borderRadius: BorderRadius.all(Radius.circular(10)),
                            //
                            //               ),
                            //               child: Padding(
                            //                 padding: EdgeInsets.fromLTRB(20,20,20,20),
                            //                 child: Column(
                            //                   mainAxisAlignment: MainAxisAlignment.start,
                            //                   crossAxisAlignment: CrossAxisAlignment.start,
                            //                   children: [
                            //
                            //                     textWidget("${_groupDetailController.paymentHistoryList.value[index].fldAmount}", 16, FontWeight.bold, 'Lato',
                            //                         0xff000000, '', false),
                            //                     SizedBox(
                            //                       height: height * 0.00,
                            //                     ),
                            //
                            //                     SizedBox(
                            //                       height: height * 0.01,
                            //                     ),
                            //                     Padding(
                            //                       padding: EdgeInsets.fromLTRB(0,0,0,0),
                            //                       child: Row(
                            //
                            //                         children: [
                            //                           textWidget("Amount:", 12, FontWeight.bold, 'Lato',
                            //                               0xff000000, '', false),
                            //                           Spacer(),
                            //                           textWidget("${_groupDetailController.paymentHistoryList.value[index].fldAmount}", 12, FontWeight.bold, 'Lato',
                            //                               0xffC0C0C0, '', false),
                            //                           Padding(
                            //                             padding: EdgeInsets.all(5),
                            //                             child: Icon(Icons.monetization_on,color: HexColor(blue_color),size: 18,),
                            //                           )
                            //                         ],
                            //                       ),
                            //                     ),
                            //                     SizedBox(
                            //                       height: height * 0.01,
                            //                     ),
                            //                     Padding(
                            //                       padding: EdgeInsets.fromLTRB(0,0,0,0),
                            //                       child: Row(
                            //
                            //                         children: [
                            //                           textWidget("Duration:", 12, FontWeight.bold, 'Lato',
                            //                               0xff000000, '', false),
                            //                           Spacer(),
                            //                           textWidget("${_groupDetailController.paymentHistoryList.value[index].fldAmount}", 12, FontWeight.bold, 'Lato',
                            //                               0xffC0C0C0, '', false),
                            //                           Padding(
                            //                             padding: EdgeInsets.all(5),
                            //                             child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                            //                           )
                            //                         ],
                            //                       ),
                            //                     ),
                            //
                            //
                            //
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           );
                            //         }):
                            //     Container(
                            //       child: Center(
                            //           child: Column(
                            //             children: [
                            //               // SizedBox(
                            //               //   height: height * 0.1,
                            //               // ),
                            //               // SvgPicture.asset(
                            //               //   'assets/images/HeartOutLarge.svg',
                            //               // ),
                            //               // SizedBox(
                            //               //   height: 15,
                            //               // ),
                            //               Padding(
                            //                 padding: const EdgeInsets.only(left: 24.0, right: 24),
                            //                 child: Align(
                            //                   child: textWidget(
                            //                       'You didn’t created any installment plans yet',
                            //                       16,
                            //                       FontWeight.normal,
                            //                       'Lato',
                            //                       0xffA8A8A8,
                            //                       'c',
                            //                       false),
                            //                 ),
                            //               ),
                            //             ],
                            //           )
                            //       ),
                            //     ),
                            //   ),
                            // if(_groupDetailController.isPaymentListLoading.value == 0)
                            //   Center(
                            //     child: Container(
                            //
                            //       child: CircularProgressIndicator(),
                            //     ),
                            //   ),
                            // if(_groupDetailController.isPaymentListLoading.value == 2)
                            //   Container(
                            //     child: Center(child: Text("No Data found")),
                            //   ),
                          ],
                        ),
                ),
              ),
            ),
          ),
    ));
  }
}
