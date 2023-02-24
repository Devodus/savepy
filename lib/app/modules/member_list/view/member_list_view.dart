import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/UiElements/size_config.dart';
import 'package:savepy/app/UiElements/widget.dart';
import 'package:savepy/app/modules/add_installment_plan/view/add_installment_plan_view.dart';
import 'package:savepy/app/modules/add_member/view/add_member_view.dart';
import 'package:savepy/app/modules/member_list/controller/member_list_controller.dart';
import 'package:savepy/app/modules/member_list/controller/member_list_controller.dart';
import 'package:savepy/app/modules/member_profile/view/member_profile_view.dart';
import 'dart:math' as math;

class MemberListView extends GetView<MemberListController> {
  MemberListController _memberListController = Get.put(MemberListController());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() => Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: const Icon(
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
        title: textWidget("My Members", 18, FontWeight.bold, 'Lato',
            0xffffffff, '', false),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          width: context.width,
          height: context.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top:20, left: 24.0, right: 24, bottom: height * 0.01),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget('Member List', 15, FontWeight.bold, 'Lato',
                          0xff000000, '', false),
                      InkWell(
                          borderRadius: BorderRadius.circular(10),
                          splashColor: Colors.grey,
                          onTap: () {
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => AddMemberView()));
                          },
                          child: Center(
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: const Color(0xff004C88),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.black)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0,right: 10.0, top: 0,bottom: 0 ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget('Add new  '.tr, 12, FontWeight.bold, 'Lato', 0xffFFFFFF, '', false),
                                    const CircleAvatar(
                                      radius: 7,
                                      backgroundColor:  Colors.white,
                                      child: const Icon(Icons.add,color: Color(0xff004C88),size: 15,),
                                      // AssetImage("assets/images/demoimage.png"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                if(_memberListController.isMemberListLoading.value == 1)

                  Container(
                    child: _memberListController.memberList.value.isNotEmpty?
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        itemCount: _memberListController.memberList.value.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,0,0),

                            child: InkWell(
                              onTap: (){
                                Get.to(MemberProfile('${_memberListController.memberList.value[index].id}','${_memberListController.memberList.value[index].email}'));
                                },
                              child: Card(
                                elevation: 0.5,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.fromLTRB(10,0,10,0),
                                  leading: CircleAvatar(
                                    radius: 20,
                                    backgroundColor:  Color((math.Random().nextDouble() * 0x004C88).toInt()).withOpacity(1.0),
                                    child: Center(
                                      child: textWidget(
                                          '${_memberListController.memberList.value[index].firstName.toString()[0].toUpperCase()}',
                                          18,
                                          FontWeight.bold,
                                          'Lato',
                                          0xffffffff,
                                          '',
                                          false),
                                    ),
                                    // AssetImage("assets/images/demoimage.png"),
                                  ),

                                  title:  textWidget(
                                      '${_memberListController.memberList.value[index].firstName} ${_memberListController.memberList.value[index].lastName}',
                                      16,
                                      FontWeight.normal,
                                      'Lato',
                                      0xff000000,
                                      '',
                                      false),
                                  subtitle: textWidget(
                                      '${_memberListController.memberList.value[index].email}',
                                      14,
                                      FontWeight.bold,
                                      'Lato',
                                      0xffD4CFCF,
                                      '',
                                      false),

                                ),
                              ),
                            ),
                          );
                        }):
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

                          Spacer(),
                          SvgPicture.asset(
                            width: 40,
                            height: 40,
                            'assets/images/no_member.svg',
                            color: Color(0xff125AAB),
                          ),
                          Center(
                            child: textWidget(
                                "You didn't add any members yet",
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
                if(_memberListController.isMemberListLoading.value == 0)
                  Center(
                    child: Container(
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                if(_memberListController.isMemberListLoading.value == 2)
                  Container(
                    child: Center(child: Text("No Product found".tr)),
                  ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
  memberListItem(int index) {
    return GestureDetector(
      onTap: (){
        // Get.off(ProductDetailView("${_memberListController.productList.value[index].productId}","${_memberListController.productList.value[index].esin}"));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 14.0, right: 0, bottom: SizeConfig.screenHeight * 0.012),
        child: Container(
          // height: 317,
          color: Colors.white,
          width: SizeConfig.screenWidth * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              // textWidget(l[index + 1], 16, FontWeight.bold,
              //     'Lato', 0xff000000, '', false),
              const SizedBox(
                height: 5,
              ),

              ClipOval(
                child:Image.asset("assets/images/profile_pic.png",
                  height: 100,
                  width: 100,
                  fit:BoxFit.fitWidth,),
              ),
              Expanded(child: textWidget(
                  "${_memberListController.memberList.value[index].firstName}",
                  18,
                  FontWeight.bold,
                  'Lato',
                  0xff929292,
                  '',
                  false),),

              const SizedBox(
                height: 5,
              ),

            ],
          ),
        ),
      ),
    );

  }
}
