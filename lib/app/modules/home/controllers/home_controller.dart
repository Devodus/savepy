import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savepy/app/Networking/url_provider.dart';
import 'package:savepy/app/common/session_timeout.dart';
import 'package:savepy/app/modules/home/model/grouplist_model.dart';
import 'package:savepy/app/modules/member_list/model/member_list_model.dart';
import 'package:savepy/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {

  late TextEditingController groupNameController;
  var groupList = <Grouplistusr>[].obs;
  var memberList = <Userlist>[].obs;
  var isGroupListLoading =0.obs;
  var isMemberListLoading =0.obs;
  var currentIndex =0.obs;
  late Dio _dio = Dio(BaseOptions(baseUrl:""));
  var isPullRefresh =false.obs;

  Future<void> getGroupList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');
    var response;
    try{
      Map data = {
        "leader_email": email,
        // "deviceId": "",
        // "deviceType": Platform.isIOS ? '1' : '2'
      };

      Options options = Options(
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      response = await _dio.post(UrlProvider.groupListUrl(),options: options,data: data);
      print("Group List>> ");

      if (response.statusCode == 200) {
        if(response.data['message']=="Access denied")
        {
          Get.offAll(TimeOut());
        }
        if (response.data['flag'] == "true") {
          GroupListModel groupListModel = GroupListModel.fromJson(response.data);
          groupList.assignAll(groupListModel.grouplistusr!);
          groupList = RxList.from(groupList.reversed.toList());
          isGroupListLoading.value= 1;
        } else {
          isGroupListLoading.value= 2;
        }
      } else if (response.statusCode != 200) {
        print("Status.ERROR");
        isGroupListLoading.value=2;
      }
    }catch(e){
      // log('Error while getting data is $e');
      isGroupListLoading.value= 2;
      print('Error while getting data is $e');
    }finally{
      // isDataLoading(false);
      // isGroupListLoading.value= 2;
    }
  }

  Future<void> getMemberList(String groupId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');

    print(token);

    try{
      Map data = {
        "email": email,
        "group_id": groupId,
        // "deviceId": "",
        // "deviceType": Platform.isIOS ? '1' : '2'
      };

      Options options = Options(
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      var response = await _dio.post(UrlProvider.memberListOneUrl(),options: options,data: data);

      print("member list details>>");

      if (response.statusCode == 200) {

        if(response.data['message']=="Access denied")
        {
          Get.offAll(TimeOut());
        }

        if (response.data['flag'] == "true") {
          MemberListModel memberListModel = MemberListModel.fromJson(response.data);
          memberList.assignAll(memberListModel.userlist!);
          isMemberListLoading.value= 1;
        } else {
          isMemberListLoading.value= 2;
        }
      } else if (response.statusCode != 200) {
        print("Status.ERROR");
        isMemberListLoading.value=2;
      }
    }catch(e){
      // log('Error while getting data is $e');
      isMemberListLoading.value=2;
      print('Error while getting data is $e');
    }finally{
      // isDataLoading(false);
    }

  }

  Future<void> createGroup(String groupName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');

    try{

      Options options = Options(
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      Map data = {
        "group_name": groupName,
        "email": email,
      };
      var response = await _dio.post(UrlProvider.createGroupUrl(),options: options,data: data);
      if(response.statusCode == 200){
        ///data successfully
        // var result = jsonDecode(response.data.toString());
        // print(result);

        // user_model =  User_Model.fromJson(result);
        Fluttertoast.showToast(
            msg: "Group Created",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            timeInSecForIosWeb: 1);

      }else{
        ///error
      }
    }catch(e){
      // log('Error while getting data is $e');
      print('Error while getting data is $e');
    }finally{

    }
  }

  @override
  void onInit() {
    super.onInit();
    getGroupList();
    getMemberList("");
    groupNameController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    groupNameController.dispose();

  }

}
