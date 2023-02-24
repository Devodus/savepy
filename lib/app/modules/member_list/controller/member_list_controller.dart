import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savepy/app/Networking/url_provider.dart';
import 'package:savepy/app/common/session_timeout.dart';
import 'package:savepy/app/modules/group_list/model/group_list_model.dart';
import 'package:savepy/app/modules/member_list/model/member_list_model.dart';
import 'package:savepy/app/common/session_timeout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberListController extends GetxController {

  late TextEditingController memberNameController;
  var memberList = <Userlist>[].obs;
  var isMemberListLoading =0.obs;
  late Dio _dio = Dio(BaseOptions(baseUrl:""));
  Future<void> getMemberList(String groupId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');

    print(token);

    try{
      Map data = {
        "email": email,
        "group_id": email,
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

      print("myprofile details>> ");

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
      print('Error while getting data is $e');
    }finally{
      // isDataLoading(false);
    }

  }

  // Future<void> createMember(String memberName) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token');
  //   String? email = prefs.getString('email');
  //
  //   try{
  //
  //     Options options = Options(
  //       headers: <String, String>{
  //         'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
  //         'Authorization': 'Bearer $token'
  //       },
  //     );
  //
  //     Map data = {
  //       "member_name": memberName,
  //       "email": email,
  //     };
  //     var response = await _dio.post(UrlProvider.createMemberUrl(),options: options,data: data);
  //     if(response.statusCode == 200){
  //       ///data successfully
  //       // var result = jsonDecode(response.data.toString());
  //       // print(result);
  //
  //       // user_model =  User_Model.fromJson(result);
  //       Fluttertoast.showToast(
  //           msg: "Member Created",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           backgroundColor: Colors.black54,
  //           textColor: Colors.white,
  //           timeInSecForIosWeb: 1);
  //
  //     }else{
  //       ///error
  //     }
  //   }catch(e){
  //     // log('Error while getting data is $e');
  //     print('Error while getting data is $e');
  //   }finally{
  //
  //   }
  // }

  @override
  void onInit() {
    super.onInit();
    getMemberList("");
    memberNameController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    memberNameController.dispose();
  }

}
