import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/UiElements/size_config.dart';
import 'package:savepy/app/UiElements/widget.dart';
import 'package:savepy/app/modules/add_installment_plan/view/add_installment_plan_view.dart';
import 'package:savepy/app/modules/add_member/view/add_member_view.dart';
import 'package:savepy/app/modules/group_detail/view/group_detail_view.dart';
import 'package:savepy/app/modules/group_list/controller/group_list_controller.dart';
import 'package:savepy/app/modules/home/controllers/home_controller.dart';
import 'dart:math' as math;
import 'package:shimmer/shimmer.dart';

class GroupListView extends GetView<GroupListController>  {
  GroupListController _groupListController = Get.put(GroupListController());
  HomeController _homeController = Get.put(HomeController());
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
        title: textWidget("MyGroups", 18, FontWeight.bold, 'Lato',
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

                Padding(
                  padding: EdgeInsets.only(left: 24.0, right: 24, bottom: height * 0.01),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      textWidget('My Groups', 15, FontWeight.bold, 'Lato',
                          0xff000000, '', false),
                      InkWell(
                          borderRadius: BorderRadius.circular(10),
                          splashColor: Colors.grey,
                          onTap: () {
                            Get.defaultDialog(
                                contentPadding: EdgeInsets.fromLTRB(20,0,20,20),
                                title: 'Create New Group',
                                content: Column(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipOval(
                                      child:Image.asset(
                                        "assets/images/logo.png",
                                        height: 100,
                                        width: 100,
                                        fit:BoxFit.fitWidth,
                                      ),
                                    ),
                                    TextField(
                                      controller: _groupListController.groupNameController,
                                      keyboardType: TextInputType.text,
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                          labelText: 'Group Name',
                                          hintMaxLines: 1,
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.green, width: 4.0))),
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (_groupListController.groupNameController.text.isNotEmpty) {
                                          _groupListController.createGroup(_groupListController.groupNameController.text)
                                              .whenComplete(() => _groupListController.getGroupList()
                                              .whenComplete(() => _groupListController.update())
                                              .whenComplete(() => _homeController.getGroupList()).whenComplete(() => _homeController.update()));

                                          Get.back();
                                        } else {

                                          Get.snackbar(
                                            backgroundColor: Colors.white,
                                            snackPosition: SnackPosition.BOTTOM,
                                            "Create Group",
                                            "Please enter group name",
                                          );
                                        }
                                      },
                                      child: Text(
                                        'Create Group',

                                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                                      ),
                                      // color: Color(0xff004C88),
                                    )
                                  ],
                                ),
                                radius: 10.0);
                          },
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Color(0xff004C88),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(color: Colors.black)),
                              child: Padding(
                                padding: EdgeInsets.only(left: 10.0,right: 10.0, top: 0,bottom: 0 ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget('Create  '.tr, 12, FontWeight.bold, 'Lato', 0xffFFFFFF, '', false),
                                    CircleAvatar(
                                      radius: 7,
                                      backgroundColor:  Colors.white,
                                      child: Icon(Icons.add,color: Color(0xff004C88),size: 15,),
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
                if(_groupListController.isGroupListLoading.value == 0)
                  Center(
                    child: Container(
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                                      elevation: 1,
                                      child: ListTile(
                                        contentPadding: EdgeInsets.fromLTRB(10,0,10,0),
                                        leading: CircleAvatar(
                                          radius: 15,
                                          backgroundColor:  Color((math.Random().nextDouble() * 0x004C88).toInt()).withOpacity(1.0),
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
                  ),
                if(_groupListController.isGroupListLoading.value == 2)
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
                          'assets/images/no_group.svg',
                          color: Color(0xff125AAB),
                        ),
                        Center(
                          child: textWidget(
                              "You are not assigned to any group yet",
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
                if(_groupListController.isGroupListLoading.value == 1)
                  Container(
                    child: _groupListController.groupList.value.isNotEmpty?
                    ListView.builder(
                      reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        itemCount: _groupListController.groupList.value.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0,0,0,0),

                            child: InkWell(
                              onTap: (){
                                Get.to(GroupDetailView("home", '${_groupListController.groupList.value[index].fldGroupId}', '${_groupListController.groupList.value[index].fldGroupName}'));
                              },
                              child: Card(
                                elevation: 1,
                                child: ListTile(
                                  contentPadding: EdgeInsets.fromLTRB(10,0,10,0),
                                  leading: CircleAvatar(
                                    radius: 15,
                                    backgroundColor:  Color((math.Random().nextDouble() * 0x004C88).toInt()).withOpacity(1.0),
                                    child: Center(
                                      child: textWidget(
                                          '${_groupListController.groupList.value[index].fldGroupName.toString()[0].toUpperCase()}',
                                          18, FontWeight.bold, 'Lato', 0xffffffff, '', false),
                                    ),
                                    // AssetImage("assets/images/demoimage.png"),
                                  ),

                                  title:  textWidget(
                                      '${_groupListController.groupList.value[index].fldGroupName}',
                                      16,
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
                                      'You don’t create any groups yet',
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
  groupListItem(int index) {
    return GestureDetector(
      onTap: (){
        // Get.off(ProductDetailView("${_groupListController.productList.value[index].productId}","${_groupListController.productList.value[index].esin}"));
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
                  "${_groupListController.groupList.value[index].fldGroupName}",
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
