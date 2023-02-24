import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/UiElements/size_config.dart';
import 'package:savepy/app/UiElements/widget.dart';

import 'package:savepy/app/modules/add_installment_plan/view/add_installment_plan_view.dart';
import 'package:savepy/app/modules/add_member/view/add_member_view.dart';
import 'package:savepy/app/modules/assign_member_to_group/controller/assign_member_controller.dart';
import 'package:savepy/app/modules/member_list/controller/member_list_controller.dart';
import 'package:savepy/app/modules/member_list/controller/member_list_controller.dart';
import 'package:savepy/app/modules/member_list/model/member_list_model.dart';

import 'dart:math' as math;

class AssignMemberView extends GetView<AssignMemberController> {
  AssignMemberController _assignMemberController = Get.put(AssignMemberController());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() => Scaffold(
      appBar: AppBar(
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
        title: textWidget("Assign Members", 18, FontWeight.bold, 'Lato',
            0xffffffff, '', false),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 30, left: 10, right: 10),
          width: context.width,
          height: context.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                if(_assignMemberController.isMemberListLoading.value == 0)
                  Center(
                    child: Container(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if(_assignMemberController.isMemberListLoading.value == 2)
                  Container(
                    child: Center(child: Text("No Product found".tr)),
                  ),

                Padding(
                  padding: EdgeInsets.only(top:20, left: 24.0, right: 24, bottom: height * 0.01),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget('Available Members', 15, FontWeight.bold, 'Lato',
                          0xff000000, '', false),
                      // InkWell(
                      //     borderRadius: BorderRadius.circular(10),
                      //     splashColor: Colors.grey,
                      //     onTap: () {
                      //
                      //     },
                      //     child: Center(
                      //       child: Container(
                      //         padding: EdgeInsets.all(2),
                      //         alignment: Alignment.center,
                      //         decoration: BoxDecoration(
                      //             color: Color(0xff004C88),
                      //             borderRadius: BorderRadius.circular(15),
                      //             border: Border.all(color: Colors.black)),
                      //         child: Padding(
                      //           padding: EdgeInsets.only(left: 10.0,right: 10.0, top: 0,bottom: 0 ),
                      //           child: Row(
                      //             crossAxisAlignment: CrossAxisAlignment.center,
                      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //             children: [
                      //               textWidget('Add new  '.tr, 12, FontWeight.bold, 'Lato', 0xffFFFFFF, '', false),
                      //               CircleAvatar(
                      //                 radius: 7,
                      //                 backgroundColor:  Colors.white,
                      //                 child: Icon(Icons.add,color: Color(0xff004C88),size: 15,),
                      //                 // AssetImage("assets/images/demoimage.png"),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     )
                      // ),
                    ],
                  ),
                ),

                if(_assignMemberController.isMemberListLoading.value == 1)

                  Container(
                    child: _assignMemberController.members.value.isNotEmpty?
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        itemCount: _assignMemberController.members.value.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0,0,0,0),

                            child: InkWell(
                              onTap: (){
                                if(_assignMemberController.members[index].isSelected=="true")
                                  {
                                    int i=_assignMemberController.members.indexWhere((element) => element.id == _assignMemberController.members[index].id);
                                    _assignMemberController.members[i].isSelected = false;

                                  }
                                else
                                  {
                                    int i=_assignMemberController.members.indexWhere((element) => element.id == _assignMemberController.members[index].id);
                                    _assignMemberController.members[i].isSelected = false;
                                  }

                                print(_assignMemberController.members[index].isSelected);
                                print(index);
                                // print(_assignMemberController.isSelected.value);
                                // _assignMemberController.update();
                                // _assignMemberController.memberList();
                                // Get.to(MemberDetailView("home", '${_assignMemberController.memberList.value[index].fldMemberId}', '${_assignMemberController.memberList.value[index].fldMemberName}'));
                              },
                              child: Card(
                                elevation: 5,
                                child: ListTile(


                                  contentPadding: EdgeInsets.fromLTRB(10,0,10,0),
                                  leading: _assignMemberController.members[index].isSelected=="true"?
                                  Icon(Icons.check_circle,color: HexColor(blue_color)):Icon(Icons.check_circle,),


                                  title:  textWidget(
                                      '${_assignMemberController.members.value[index].name}',
                                      16,
                                      FontWeight.normal,
                                      'Lato',
                                      0xff000000,
                                      '',
                                      false),
                                  subtitle: textWidget(
                                      '${_assignMemberController.members.value[index].email}',
                                      14,
                                      FontWeight.normal,
                                      'Lato',
                                      0xff000000,
                                      '',
                                      false),

                                ),
                              ),
                            ),
                          );
                        }):
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
                                padding: const EdgeInsets.only(left: 24.0, right: 24),
                                child: Align(
                                  child: textWidget(
                                      "No members are available for this this group please add new.",
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
    ));
  }
  assignMemberItem(int index) {
    return GestureDetector(
      onTap: (){
        // Get.off(ProductDetailView("${_assignMemberController.productList.value[index].productId}","${_assignMemberController.productList.value[index].esin}"));
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
              SizedBox(
                height: 5,
              ),

              ClipOval(
                child:Image.asset("assets/images/profile_pic.png",
                  height: 100,
                  width: 100,
                  fit:BoxFit.fitWidth,),
              ),
              Expanded(child: textWidget(
                  "${_assignMemberController.memberList.value[index].firstName}",
                  18,
                  FontWeight.bold,
                  'Lato',
                  0xff929292,
                  '',
                  false),),

              SizedBox(
                height: 5,
              ),

            ],
          ),
        ),
      ),
    );

  }
}
