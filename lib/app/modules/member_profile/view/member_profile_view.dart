import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/UiElements/widget.dart';
import 'package:savepy/app/modules/auth/views/login_view.dart';
import 'package:savepy/app/modules/member_profile/controller/member_profile_controller.dart';
import 'package:shimmer/shimmer.dart';

class MemberProfile extends GetView<MemberProfileController> {
  final String? email;
  final String? memberId;
  MemberProfile(this.memberId,this.email);

  @override
  Widget build(BuildContext context) {
    MemberProfileController _memberProfileController = Get.put(MemberProfileController(email,memberId));
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: HexColor(blue_color),
              ),
              onPressed: () {
                {
                  Navigator.pop(context);
                }
              }),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: textWidget("Profile", 18, FontWeight.bold, 'Lato',
              0xff004C88, '', false),
        ),
        body: Obx(
                (){
                 return Container(
                    child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20.0,right: 20.0, top: height * 0.12,bottom: height * 0.03 ),
                                  child: Stack(
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
                                              textWidget("${_memberProfileController.user.value?.userProfileData?.firstName} ${_memberProfileController.user.value?.userProfileData?.lastName}",
                                                  16, FontWeight.bold, 'Lato',
                                                  0xff000000, '', false),
                                              SizedBox(
                                                height: height * 0.00,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                child: textWidget("${_memberProfileController.user.value?.userProfileData?.fldAddress}", 12, FontWeight.bold, 'Lato',
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
                                                    textWidget("${_memberProfileController.user.value?.userProfileData?.email}", 12, FontWeight.bold, 'Lato',
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
                                                    textWidget("${_memberProfileController.user.value?.userProfileData?.fldMobile}", 12, FontWeight.bold, 'Lato',
                                                        0xffC0C0C0, '', false),

                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ),
                                _memberProfileController.isMemberProfileLoading.value == 0?Padding(
                                  padding: EdgeInsets.only(left: 20.0,right: 20.0, top: height * 0.12,bottom: height * 0.03 ),
                                  child: Stack(
                                    children: [
                                      Shimmer.fromColors(
                                        child: Card(
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
                                                textWidget("${_memberProfileController.user.value?.userProfileData?.firstName} ${_memberProfileController.user.value?.userProfileData?.lastName}",
                                                    16, FontWeight.bold, 'Lato',
                                                    0xff000000, '', false),
                                                SizedBox(
                                                  height: height * 0.00,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                  child: textWidget("${_memberProfileController.user.value?.userProfileData?.fldAddress}", 12, FontWeight.bold, 'Lato',
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
                                                      textWidget("${_memberProfileController.user.value?.userProfileData?.email}", 12, FontWeight.bold, 'Lato',
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
                                                      textWidget("${_memberProfileController.user.value?.userProfileData?.fldMobile}", 12, FontWeight.bold, 'Lato',
                                                          0xffC0C0C0, '', false),

                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.01,
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade50,
                                        loop: 10,
                                      ),

                                    ],
                                  ),

                                ):Container(),
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
                                          (!["", null, false, 0,].contains(_memberProfileController.user.value?.userProfileData?.fldProfilePic)) ?
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundImage: NetworkImage("${_memberProfileController.user.value?.userProfileData?.fldProfilePic}",),
                                            // AssetImage("assets/images/demoimage.png"),
                                          ):
                                          ClipOval(
                                            child:Image.asset("assets/images/profile_pic.png",
                                              height: 100,
                                              width: 100,
                                              fit:BoxFit.fitWidth,),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),

                                    ],
                                  ),
                                ),
                                _memberProfileController.isMemberProfileLoading.value == 0?Padding(
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
                                          Shimmer.fromColors(
                                            child: ClipOval(
                                              child:Image.asset("assets/images/profile_pic.png",
                                                height: 100,
                                                width: 100,
                                                fit:BoxFit.fitWidth,),
                                            ),
                                            baseColor: Colors.grey.shade300,
                                            highlightColor: Colors.grey.shade50,
                                            loop: 10,
                                          ),

                                        ],
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),

                                    ],
                                  ),
                                ):Container(),
                              ],
                            ),

                            Container(
                              width: width *0.85,
                              height: 300,
                              child: DefaultTabController(
                                length: 12,
                                child: NestedScrollView(
                                  scrollDirection: Axis.vertical,
                                  headerSliverBuilder: (context, innerBoxIsScrolled) => [
                                    SliverToBoxAdapter( //headerSilverBuilder only accepts slivers
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: textWidget('Payment Details', 14, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                          ),
                                          TabBar(
                                            labelColor: Colors.blue,
                                            isScrollable: true,
                                            tabs: [
                                              Tab(child: textWidget('Jan', 10, FontWeight.bold, 'Lato', 0xff000000, '', false),),
                                              Tab(child: textWidget('Feb', 10, FontWeight.bold, 'Lato', 0xff000000, '', false),),
                                              Tab(child: textWidget('Mar', 10, FontWeight.bold, 'Lato', 0xff000000, '', false),),
                                              Tab(child: textWidget('April', 10, FontWeight.bold, 'Lato', 0xff000000, '', false),),
                                              Tab(child: textWidget('May', 10, FontWeight.bold, 'Lato', 0xff000000, '', false),),
                                              Tab(child: textWidget('June', 10, FontWeight.bold, 'Lato', 0xff000000, '', false),),
                                              Tab(child: textWidget('July', 10, FontWeight.bold, 'Lato', 0xff000000, '', false),),
                                              Tab(child: textWidget('Aug', 10, FontWeight.bold, 'Lato', 0xff000000, '', false),),
                                              Tab(child: textWidget('Sep', 10, FontWeight.bold, 'Lato', 0xff000000, '', false),),
                                              Tab(child: textWidget('Oct', 10, FontWeight.bold, 'Lato', 0xff000000, '', false),),
                                              Tab(child: textWidget('Nov', 10, FontWeight.bold, 'Lato', 0xff000000, '', false),),
                                              Tab(child: textWidget('Dec', 10, FontWeight.bold,'Lato', 0xff000000, '', false),),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                  body: TabBarView(
                                    children: [
                                      // I wrapped large widgets in the SingleChildScrollView
                                      if(_memberProfileController.isPaymentListLoading.value == 0)
                                        Center(
                                          child: Container(
                                            child: ListView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                itemCount: 5,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  return Center(
                                                    child: Opacity(
                                                      opacity: 0.8,
                                                      child: Shimmer.fromColors(
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                          child: Card(
                                                            elevation: 0.5,
                                                            child: ListTile(
                                                              contentPadding: EdgeInsets.fromLTRB(10,20,10,20),
                                                              leading: CircleAvatar(
                                                                radius: 15,
                                                                // backgroundColor:  Color((math.Random().nextDouble() * 0x004C88).toInt()).withOpacity(1.0),
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
                                        )
                                      else
                                      Container(
                                        child: _memberProfileController.paymentHistoryList.value.isNotEmpty?
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            itemCount: _memberProfileController.paymentHistoryList.value.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              // _groupDetailController.getPaymentHistoryList("${_groupDetailController.planList.value[index].fldGroupId}");
                                              // print(_memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7));


                                              return _memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7)=="01"?
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                child: Card(
                                                  elevation: 0.5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(20,20,20,20),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        textWidget("${_memberProfileController.paymentHistoryList.value[index].groupName}", 16, FontWeight.bold, 'Lato',
                                                            0xff000000, '', false),
                                                        SizedBox(
                                                          height: height * 0.00,
                                                        ),

                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                          child: Row(

                                                            children: [
                                                              textWidget("Amount:", 12, FontWeight.bold, 'Lato',
                                                                  0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldAmount}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.monetization_on,color: HexColor(blue_color),size: 18,),
                                                              )
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
                                                              textWidget("Paid on:", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldPaymentDate}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ):
                                              Container(
                                                child: Center(
                                                    child:Padding(
                                                      padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                      child: Align(
                                                        child: textWidget(
                                                            'No payment done for this month',
                                                            16,
                                                            FontWeight.normal,
                                                            'Lato',
                                                            0xffA8A8A8,
                                                            'c',
                                                            false),
                                                      ),
                                                    ),
                                                ),
                                              );
                                            }) :
                                        Container(
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
                                                    padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                    child: Align(
                                                      child: textWidget(
                                                          'No payment done for this month',
                                                          16,
                                                          FontWeight.normal,
                                                          'Lato',
                                                          0xffA8A8A8,
                                                          'c',
                                                          false),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: _memberProfileController.paymentHistoryList.value.isNotEmpty?
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            itemCount: _memberProfileController.paymentHistoryList.value.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              // _groupDetailController.getPaymentHistoryList("${_groupDetailController.planList.value[index].fldGroupId}");
                                              // print(_memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7));


                                              return _memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7)=="02"?
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                child: Card(
                                                  elevation: 0.5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(20,20,20,20),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        textWidget("${_memberProfileController.paymentHistoryList.value[index].groupName}", 16, FontWeight.bold, 'Lato',
                                                            0xff000000, '', false),
                                                        SizedBox(
                                                          height: height * 0.00,
                                                        ),

                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                          child: Row(

                                                            children: [
                                                              textWidget("Amount:", 12, FontWeight.bold, 'Lato',
                                                                  0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldAmount}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.monetization_on,color: HexColor(blue_color),size: 18,),
                                                              )
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
                                                              textWidget("Paid on:", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldPaymentDate}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ):
                                              Container(
                                                child: Center(
                                                    child:Padding(
                                                      padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                      child: Align(
                                                        child: textWidget(
                                                            'No payment done for this month',
                                                            16,
                                                            FontWeight.normal,
                                                            'Lato',
                                                            0xffA8A8A8,
                                                            'c',
                                                            false),
                                                      ),
                                                    ),
                                                ),
                                              );
                                            }) :
                                        Container(
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
                                                    padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                    child: Align(
                                                      child: textWidget(
                                                          'No payment done for this month',
                                                          16,
                                                          FontWeight.normal,
                                                          'Lato',
                                                          0xffA8A8A8,
                                                          'c',
                                                          false),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: _memberProfileController.paymentHistoryList.value.isNotEmpty?
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            itemCount: _memberProfileController.paymentHistoryList.value.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              // _groupDetailController.getPaymentHistoryList("${_groupDetailController.planList.value[index].fldGroupId}");
                                              // print(_memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7));


                                              return _memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7)=="03"?
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                child: Card(
                                                  elevation: 0.5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(20,20,20,20),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        textWidget("${_memberProfileController.paymentHistoryList.value[index].groupName}", 16, FontWeight.bold, 'Lato',
                                                            0xff000000, '', false),
                                                        SizedBox(
                                                          height: height * 0.00,
                                                        ),

                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                          child: Row(

                                                            children: [
                                                              textWidget("Amount:", 12, FontWeight.bold, 'Lato',
                                                                  0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldAmount}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.monetization_on,color: HexColor(blue_color),size: 18,),
                                                              )
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
                                                              textWidget("Paid on:", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldPaymentDate}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ):
                                              Container(
                                                child: Center(
                                                    child:Padding(
                                                      padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                      child: Align(
                                                        child: textWidget(
                                                            'No payment done for this month',
                                                            16,
                                                            FontWeight.normal,
                                                            'Lato',
                                                            0xffA8A8A8,
                                                            'c',
                                                            false),
                                                      ),
                                                    ),
                                                ),
                                              );
                                            }) :
                                        Container(
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
                                                    padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                    child: Align(
                                                      child: textWidget(
                                                          'No payment done for this month',
                                                          16,
                                                          FontWeight.normal,
                                                          'Lato',
                                                          0xffA8A8A8,
                                                          'c',
                                                          false),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: _memberProfileController.paymentHistoryList.value.isNotEmpty?
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            itemCount: _memberProfileController.paymentHistoryList.value.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              // _groupDetailController.getPaymentHistoryList("${_groupDetailController.planList.value[index].fldGroupId}");
                                              // print(_memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7));


                                              return _memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7)=="04"?
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                child: Card(
                                                  elevation: 0.5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(20,20,20,20),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        textWidget("${_memberProfileController.paymentHistoryList.value[index].groupName}", 16, FontWeight.bold, 'Lato',
                                                            0xff000000, '', false),
                                                        SizedBox(
                                                          height: height * 0.00,
                                                        ),

                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                          child: Row(

                                                            children: [
                                                              textWidget("Amount:", 12, FontWeight.bold, 'Lato',
                                                                  0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldAmount}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.monetization_on,color: HexColor(blue_color),size: 18,),
                                                              )
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
                                                              textWidget("Paid on:", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldPaymentDate}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ):
                                              Container(
                                                child: Center(
                                                    child:Padding(
                                                      padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                      child: Align(
                                                        child: textWidget(
                                                            'No payment done for this month',
                                                            16,
                                                            FontWeight.normal,
                                                            'Lato',
                                                            0xffA8A8A8,
                                                            'c',
                                                            false),
                                                      ),
                                                    ),
                                                ),
                                              );
                                            }) :
                                        Container(
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
                                                    padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                    child: Align(
                                                      child: textWidget(
                                                          'No payment done for this month',
                                                          16,
                                                          FontWeight.normal,
                                                          'Lato',
                                                          0xffA8A8A8,
                                                          'c',
                                                          false),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: _memberProfileController.paymentHistoryList.value.isNotEmpty?
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            itemCount: _memberProfileController.paymentHistoryList.value.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              // _groupDetailController.getPaymentHistoryList("${_groupDetailController.planList.value[index].fldGroupId}");
                                              // print(_memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7));


                                              return _memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7)=="05"?
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                child: Card(
                                                  elevation: 0.5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(20,20,20,20),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        textWidget("${_memberProfileController.paymentHistoryList.value[index].groupName}", 16, FontWeight.bold, 'Lato',
                                                            0xff000000, '', false),
                                                        SizedBox(
                                                          height: height * 0.00,
                                                        ),

                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                          child: Row(

                                                            children: [
                                                              textWidget("Amount:", 12, FontWeight.bold, 'Lato',
                                                                  0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldAmount}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.monetization_on,color: HexColor(blue_color),size: 18,),
                                                              )
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
                                                              textWidget("Paid on:", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldPaymentDate}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ):
                                              Container(
                                                child: Center(
                                                    child:Padding(
                                                      padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                      child: Align(
                                                        child: textWidget(
                                                            'No payment done for this month',
                                                            16,
                                                            FontWeight.normal,
                                                            'Lato',
                                                            0xffA8A8A8,
                                                            'c',
                                                            false),
                                                      ),
                                                    ),
                                                ),
                                              );
                                            }) :
                                        Container(
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
                                                    padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                    child: Align(
                                                      child: textWidget(
                                                          'No payment done for this month',
                                                          16,
                                                          FontWeight.normal,
                                                          'Lato',
                                                          0xffA8A8A8,
                                                          'c',
                                                          false),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: _memberProfileController.paymentHistoryList.value.isNotEmpty?
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            itemCount: _memberProfileController.paymentHistoryList.value.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              // _groupDetailController.getPaymentHistoryList("${_groupDetailController.planList.value[index].fldGroupId}");
                                              // print(_memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7));


                                              return _memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7)=="06"?
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                child: Card(
                                                  elevation: 0.5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(20,20,20,20),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        textWidget("${_memberProfileController.paymentHistoryList.value[index].groupName}", 16, FontWeight.bold, 'Lato',
                                                            0xff000000, '', false),
                                                        SizedBox(
                                                          height: height * 0.00,
                                                        ),

                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                          child: Row(

                                                            children: [
                                                              textWidget("Amount:", 12, FontWeight.bold, 'Lato',
                                                                  0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldAmount}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.monetization_on,color: HexColor(blue_color),size: 18,),
                                                              )
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
                                                              textWidget("Paid on:", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldPaymentDate}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ):
                                              Container(
                                                child: Center(
                                                    child:Padding(
                                                      padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                      child: Align(
                                                        child: textWidget(
                                                            'No payment done for this month',
                                                            16,
                                                            FontWeight.normal,
                                                            'Lato',
                                                            0xffA8A8A8,
                                                            'c',
                                                            false),
                                                      ),
                                                    ),
                                                ),
                                              );
                                            }) :
                                        Container(
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
                                                    padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                    child: Align(
                                                      child: textWidget(
                                                          'No payment done for this month',
                                                          16,
                                                          FontWeight.normal,
                                                          'Lato',
                                                          0xffA8A8A8,
                                                          'c',
                                                          false),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: _memberProfileController.paymentHistoryList.value.isNotEmpty?
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            itemCount: _memberProfileController.paymentHistoryList.value.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              // _groupDetailController.getPaymentHistoryList("${_groupDetailController.planList.value[index].fldGroupId}");
                                              // print(_memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7));


                                              return _memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7)=="07"?
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                child: Card(
                                                  elevation: 0.5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(20,20,20,20),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        textWidget("${_memberProfileController.paymentHistoryList.value[index].groupName}", 16, FontWeight.bold, 'Lato',
                                                            0xff000000, '', false),
                                                        SizedBox(
                                                          height: height * 0.00,
                                                        ),

                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                          child: Row(

                                                            children: [
                                                              textWidget("Amount:", 12, FontWeight.bold, 'Lato',
                                                                  0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldAmount}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.monetization_on,color: HexColor(blue_color),size: 18,),
                                                              )
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
                                                              textWidget("Paid on:", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldPaymentDate}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ):
                                              Container(
                                                child: Center(
                                                    child:Padding(
                                                      padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                      child: Align(
                                                        child: textWidget(
                                                            'No payment done for this month',
                                                            16,
                                                            FontWeight.normal,
                                                            'Lato',
                                                            0xffA8A8A8,
                                                            'c',
                                                            false),
                                                      ),
                                                    ),
                                                ),
                                              );
                                            }) :
                                        Container(
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
                                                    padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                    child: Align(
                                                      child: textWidget(
                                                          'No payment done for this month',
                                                          16,
                                                          FontWeight.normal,
                                                          'Lato',
                                                          0xffA8A8A8,
                                                          'c',
                                                          false),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: _memberProfileController.paymentHistoryList.value.isNotEmpty?
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            itemCount: _memberProfileController.paymentHistoryList.value.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              // _groupDetailController.getPaymentHistoryList("${_groupDetailController.planList.value[index].fldGroupId}");
                                              // print(_memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7));


                                              return _memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7)=="08"?
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                child: Card(
                                                  elevation: 0.5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(20,20,20,20),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        textWidget("${_memberProfileController.paymentHistoryList.value[index].groupName}", 16, FontWeight.bold, 'Lato',
                                                            0xff000000, '', false),
                                                        SizedBox(
                                                          height: height * 0.00,
                                                        ),

                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                          child: Row(

                                                            children: [
                                                              textWidget("Amount:", 12, FontWeight.bold, 'Lato',
                                                                  0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldAmount}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.monetization_on,color: HexColor(blue_color),size: 18,),
                                                              )
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
                                                              textWidget("Paid on:", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldPaymentDate}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ):
                                              Container(
                                                child: Center(
                                                    child:Padding(
                                                      padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                      child: Align(
                                                        child: textWidget(
                                                            'No payment done for this month',
                                                            16,
                                                            FontWeight.normal,
                                                            'Lato',
                                                            0xffA8A8A8,
                                                            'c',
                                                            false),
                                                      ),
                                                    ),
                                                ),
                                              );
                                            }) :
                                        Container(
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
                                                    padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                    child: Align(
                                                      child: textWidget(
                                                          'No payment done for this month',
                                                          16,
                                                          FontWeight.normal,
                                                          'Lato',
                                                          0xffA8A8A8,
                                                          'c',
                                                          false),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: _memberProfileController.paymentHistoryList.value.isNotEmpty?
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            itemCount: _memberProfileController.paymentHistoryList.value.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              // _groupDetailController.getPaymentHistoryList("${_groupDetailController.planList.value[index].fldGroupId}");
                                              // print(_memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7));


                                              return _memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7)=="09"?
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                child: Card(
                                                  elevation: 0.5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(20,20,20,20),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        textWidget("${_memberProfileController.paymentHistoryList.value[index].groupName}", 16, FontWeight.bold, 'Lato',
                                                            0xff000000, '', false),
                                                        SizedBox(
                                                          height: height * 0.00,
                                                        ),

                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                          child: Row(

                                                            children: [
                                                              textWidget("Amount:", 12, FontWeight.bold, 'Lato',
                                                                  0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldAmount}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.monetization_on,color: HexColor(blue_color),size: 18,),
                                                              )
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
                                                              textWidget("Paid on:", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldPaymentDate}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ):
                                              Container(
                                                child: Center(
                                                    child:Padding(
                                                      padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                      child: Align(
                                                        child: textWidget(
                                                            'No payment done for this month',
                                                            16,
                                                            FontWeight.normal,
                                                            'Lato',
                                                            0xffA8A8A8,
                                                            'c',
                                                            false),
                                                      ),
                                                    ),
                                                ),
                                              );
                                            }) :
                                        Container(
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
                                                    padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                    child: Align(
                                                      child: textWidget(
                                                          'No payment done for this month',
                                                          16,
                                                          FontWeight.normal,
                                                          'Lato',
                                                          0xffA8A8A8,
                                                          'c',
                                                          false),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: _memberProfileController.paymentHistoryList.value.isNotEmpty?
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            itemCount: _memberProfileController.paymentHistoryList.value.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              // _groupDetailController.getPaymentHistoryList("${_groupDetailController.planList.value[index].fldGroupId}");
                                              // print(_memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7));


                                              return _memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7)=="10"?
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                child: Card(
                                                  elevation: 0.5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(20,20,20,20),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        textWidget("${_memberProfileController.paymentHistoryList.value[index].groupName}", 16, FontWeight.bold, 'Lato',
                                                            0xff000000, '', false),
                                                        SizedBox(
                                                          height: height * 0.00,
                                                        ),

                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                          child: Row(

                                                            children: [
                                                              textWidget("Amount:", 12, FontWeight.bold, 'Lato',
                                                                  0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldAmount}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.monetization_on,color: HexColor(blue_color),size: 18,),
                                                              )
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
                                                              textWidget("Paid on:", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldPaymentDate}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ):
                                              Container(
                                                child: Center(
                                                    child:Padding(
                                                      padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                      child: Align(
                                                        child: textWidget(
                                                            'No payment done for this month',
                                                            16,
                                                            FontWeight.normal,
                                                            'Lato',
                                                            0xffA8A8A8,
                                                            'c',
                                                            false),
                                                      ),
                                                    ),
                                                ),
                                              );
                                            }) :
                                        Container(
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
                                                    padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                    child: Align(
                                                      child: textWidget(
                                                          'No payment done for this month',
                                                          16,
                                                          FontWeight.normal,
                                                          'Lato',
                                                          0xffA8A8A8,
                                                          'c',
                                                          false),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: _memberProfileController.paymentHistoryList.value.isNotEmpty?
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            itemCount: _memberProfileController.paymentHistoryList.value.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              // _groupDetailController.getPaymentHistoryList("${_groupDetailController.planList.value[index].fldGroupId}");
                                              // print(_memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7));


                                              return _memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7)=="11"?
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                child: Card(
                                                  elevation: 0.5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(20,20,20,20),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        textWidget("${_memberProfileController.paymentHistoryList.value[index].groupName}", 16, FontWeight.bold, 'Lato',
                                                            0xff000000, '', false),
                                                        SizedBox(
                                                          height: height * 0.00,
                                                        ),

                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                          child: Row(

                                                            children: [
                                                              textWidget("Amount:", 12, FontWeight.bold, 'Lato',
                                                                  0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldAmount}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.monetization_on,color: HexColor(blue_color),size: 18,),
                                                              )
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
                                                              textWidget("Paid on:", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldPaymentDate}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ):
                                              Container(
                                                child: Center(
                                                    child:Padding(
                                                      padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                      child: Align(
                                                        child: textWidget(
                                                            'No payment done for this month',
                                                            16,
                                                            FontWeight.normal,
                                                            'Lato',
                                                            0xffA8A8A8,
                                                            'c',
                                                            false),
                                                      ),
                                                    ),
                                                ),
                                              );
                                            }) :
                                        Container(
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
                                                    padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                    child: Align(
                                                      child: textWidget(
                                                          'No payment done for this month',
                                                          16,
                                                          FontWeight.normal,
                                                          'Lato',
                                                          0xffA8A8A8,
                                                          'c',
                                                          false),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: _memberProfileController.paymentHistoryList.value.isNotEmpty?
                                        ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            itemCount: _memberProfileController.paymentHistoryList.value.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              // _groupDetailController.getPaymentHistoryList("${_groupDetailController.planList.value[index].fldGroupId}");
                                              // print(_memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7));


                                              return _memberProfileController.paymentHistoryList.value[index].fldPaymentDate?.substring(5,7)=="12"?
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                child: Card(
                                                  elevation: 0.5,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(20,20,20,20),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [

                                                        textWidget("${_memberProfileController.paymentHistoryList.value[index].groupName}", 16, FontWeight.bold, 'Lato',
                                                            0xff000000, '', false),
                                                        SizedBox(
                                                          height: height * 0.00,
                                                        ),

                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(0,0,0,0),
                                                          child: Row(

                                                            children: [
                                                              textWidget("Amount:", 12, FontWeight.bold, 'Lato',
                                                                  0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldAmount}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.monetization_on,color: HexColor(blue_color),size: 18,),
                                                              )
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
                                                              textWidget("Paid on:", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                                              Spacer(),
                                                              textWidget("${_memberProfileController.paymentHistoryList.value[index].fldPaymentDate}", 12, FontWeight.bold, 'Lato',
                                                                  0xffC0C0C0, '', false),
                                                              Padding(
                                                                padding: EdgeInsets.all(5),
                                                                child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                                                              )
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ):
                                              Container(
                                                child: Center(
                                                    child:Padding(
                                                      padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                      child: Align(
                                                        child: textWidget(
                                                            'No payment done for this month',
                                                            16,
                                                            FontWeight.normal,
                                                            'Lato',
                                                            0xffA8A8A8,
                                                            'c',
                                                            false),
                                                      ),
                                                    ),
                                                ),
                                              );
                                            }) :
                                        Container(
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
                                                    padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                                                    child: Align(
                                                      child: textWidget(
                                                          'No payment done for this month',
                                                          16,
                                                          FontWeight.normal,
                                                          'Lato',
                                                          0xffA8A8A8,
                                                          'c',
                                                          false),
                                                    ),
                                                  ),
                                                ],
                                              )
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),

                            // if(_memberProfileController.isPaymentListLoading.value == 2)
                            //   Container(
                            //     child: Center(child: Text("No transaction history")),
                            //   ),
                            // if(_memberProfileController.isPaymentListLoading.value == 1)
                            //   Container(
                            //     child: _memberProfileController.paymentHistoryList.value.isNotEmpty?
                            //     ListView.builder(
                            //         physics: NeverScrollableScrollPhysics(),
                            //         padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            //         itemCount: _memberProfileController.paymentHistoryList.value.length,
                            //         shrinkWrap: true,
                            //         itemBuilder: (context, index) {
                            //           // _groupDetailController.getPaymentHistoryList("${_groupDetailController.planList.value[index].fldGroupId}");
                            //           return Padding(
                            //             padding: EdgeInsets.fromLTRB(0,0,0,0),
                            //             child: Card(
                            //               elevation: 1,
                            //               shape: RoundedRectangleBorder(
                            //                 borderRadius: BorderRadius.all(Radius.circular(10)),
                            //               ),
                            //               child: Padding(
                            //                 padding: EdgeInsets.fromLTRB(20,20,20,20),
                            //                 child: Column(
                            //                   mainAxisAlignment: MainAxisAlignment.start,
                            //                   crossAxisAlignment: CrossAxisAlignment.start,
                            //                   children: [
                            //
                            //                     textWidget("${_memberProfileController.paymentHistoryList.value[index].groupName}", 16, FontWeight.bold, 'Lato',
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
                            //                           textWidget("${_memberProfileController.paymentHistoryList.value[index].fldAmount}", 12, FontWeight.bold, 'Lato',
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
                            //                           textWidget("Paid on:", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                            //                           Spacer(),
                            //                           textWidget("${_memberProfileController.paymentHistoryList.value[index].fldPaymentDate}", 12, FontWeight.bold, 'Lato',
                            //                               0xffC0C0C0, '', false),
                            //                           Padding(
                            //                             padding: EdgeInsets.all(5),
                            //                             child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                            //                           )
                            //                         ],
                            //                       ),
                            //                     ),
                            //
                            //                   ],
                            //                 ),
                            //               ),
                            //             ),
                            //           );
                            //         }) :
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
                            //                 padding: const EdgeInsets.only(top:50,left: 24.0, right: 24),
                            //                 child: Align(
                            //                   child: textWidget(
                            //                       'No payment done for this month',
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

                          ],
                        )
                    ),
                  );


            }
        ),

    );
  }
}
