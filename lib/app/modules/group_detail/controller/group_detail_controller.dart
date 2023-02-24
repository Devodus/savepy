import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savepy/app/Networking/url_provider.dart';
import 'package:savepy/app/common/session_timeout.dart';
import 'package:savepy/app/modules/group_detail/model/group_payment_model.dart';
import 'package:savepy/app/modules/group_detail/model/payment_history_model.dart';
import 'package:savepy/app/modules/group_detail/model/plan_list_model.dart';
import 'package:savepy/app/modules/home/model/grouplist_model.dart';
import 'package:savepy/app/modules/member_list/model/member_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../payment_due/controller/payment_due_controller.dart';

class GroupDetailController extends GetxController {
  GroupDetailController (this.groupId);
  // ProductDetailModel? productDetailModel;
  var groupId;
  var memberList = <Userlist>[].obs;
  var leaderDetails = <LeaderData>[].obs;
  var paymentHistoryList = <UserPaymentHistory>[].obs;
  var groupPaymentHistoryList = <GroupPaymentHistory>[].obs;
  var isMemberListLoading =0.obs;
  var isLeader =false.obs;
  var isPaymentListLoading =0.obs;
  var isGroupPaymentListLoading =0.obs;
  var planList = <Planlist>[].obs;
  var isplanListLoading =0.obs;
  var isOnPlanList =false.obs;
  var isOnMemberList=true.obs;
  var isMyMemberListEmpty=true.obs;
  var userId="".obs;
  late Dio _dio = Dio(BaseOptions(baseUrl:""));
  late TextEditingController planNameController;
  late TextEditingController amountController;
  late TextEditingController durationController;

  Future<void> getPlanList(String groupId) async {
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

      var response = await _dio.post(UrlProvider.planListUrl(),options: options,data: data);

      print("plans list>> ");
      print(response.data);

      if (response.statusCode == 200) {
        if(response.data['message']=="Access denied")
        {
          Get.offAll(TimeOut());
        }
        if (response.data['flag'] == "true") {
          PlanListModel planListModel = PlanListModel.fromJson(response.data);
          planList.assignAll(planListModel.planlist!);

          isplanListLoading.value= 1;
        } else {
          isplanListLoading.value= 2;
        }
      } else if (response.statusCode != 200) {
        print("Status.ERROR");
        isplanListLoading.value=2;
      }
    }catch(e){
      // log('Error while getting data is $e');
      print('Error while getting data is $e');
      isplanListLoading.value=2;
    }finally{

    }

  }

  Future<void> getMemberList(String groupId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');
    userId.value = prefs.getString('userId')!;

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

      var response = await _dio.post(UrlProvider.memberListUrl(),options: options,data: data);

      print("member list details>>");
      print(response.data);

      if (response.statusCode == 200) {

        if(response.data['message']=="Access denied")
        {
          Get.offAll(TimeOut());
        }

        if (response.data['flag'] == "true") {
          MemberListModel memberListModel = MemberListModel.fromJson(response.data);
          memberList.assignAll(memberListModel.userlist!);
          leaderDetails.assign(memberListModel.leaderData!);
          print("ankit check");
          print(leaderDetails[0].userId);
          print("ankit check");

          if(leaderDetails[0].userId==userId.value)
            {
              isLeader(true);
            }
          else
            {
              isLeader(false);
            }
          print(isLeader);
          for(int i=0;i<memberList.length;i++)
            {
              if(memberList[i].belongToGroup==true)
                {
                  isMyMemberListEmpty.value=false;
                }
            }
          print("Member List Length");
          print(memberList.length);
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

  // Future<void> getPaymentHistoryList(String planId) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token');
  //   String? email = prefs.getString('email');
  //
  //   print(token);
  //
  //   try{
  //     Map data = {
  //       "plan_id": planId,
  //       // "group_id": groupId,
  //       // "deviceId": "",
  //       // "deviceType": Platform.isIOS ? '1' : '2'
  //     };
  //
  //     Options options = Options(
  //       headers: <String, String>{
  //         'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
  //         'Authorization': 'Bearer $token'
  //       },
  //     );
  //
  //     var response = await _dio.post(UrlProvider.paymentHistoryListUrl(),options: options,data: data);
  //
  //     print("member list details>>");
  //
  //     if (response.statusCode == 200) {
  //
  //       if(response.data['message']=="Access denied")
  //       {
  //         Get.offAll(TimeOut());
  //       }
  //
  //       if (response.data['flag'] == "true") {
  //         PaymentHistoryModel paymentHistoryModel = PaymentHistoryModel.fromJson(response.data);
  //         paymentHistoryList.assignAll(paymentHistoryModel.userPaymentHistory!);
  //
  //         isPaymentListLoading.value= 1;
  //       } else {
  //         isPaymentListLoading.value= 2;
  //       }
  //     } else if (response.statusCode != 200) {
  //       print("Status.ERROR");
  //       isPaymentListLoading.value=2;
  //     }
  //   }catch(e){
  //     // log('Error while getting data is $e');
  //     print('Error while getting data is $e');
  //   }finally{
  //     // isDataLoading(false);
  //   }
  //
  // }

  Future<void> getGroupPaymentHistoryList(String groupId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');

    print(token);

    try{
      Map data = {
        "group_id": groupId,
        // "group_id": groupId,
        // "deviceId": "",
        // "deviceType": Platform.isIOS ? '1' : '2'
      };

      Options options = Options(
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      var response = await _dio.post(UrlProvider.groupPaymentHistoryListUrl(),options: options,data: data);

      print("group payment list>>");

      if (response.statusCode == 200) {

        if(response.data['message']=="Access denied")
        {
          Get.offAll(TimeOut());
        }

        if (response.data['flag'] == "true") {
          GroupPaymentModel groupPaymentModel = GroupPaymentModel.fromJson(response.data);
          groupPaymentHistoryList.assignAll(groupPaymentModel.userPaymentHistory!);

          isGroupPaymentListLoading.value= 1;
        } else {
          isGroupPaymentListLoading.value= 2;
        }
      } else if (response.statusCode != 200) {
        print("Status.ERROR");
        isGroupPaymentListLoading.value=2;
      }
    }catch(e){
      // log('Error while getting data is $e');
      isGroupPaymentListLoading.value=2;
      print('Error while getting data is $e');
    }finally{
      // isDataLoading(false);
    }

  }

  Future<void> addInstallmentPlan(String groupId) async {
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
        "plan_name": planNameController.text,
        "amount": amountController.text,
        "duration": durationController.text,
        "email": email,
        "group_id": groupId,
      };
      var response = await _dio.post(UrlProvider.createPlanUrl(),options: options,data: data);
      if(response.statusCode == 200){
        ///data successfully
        // var result = jsonDecode(response.data.toString());
        // print(result);

        // user_model =  User_Model.fromJson(result);
        Fluttertoast.showToast(
            msg: "Plan Created",
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

  Future<void> setPriority() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');
    String? userId = prefs.getString('userId');

    try{

      Options options = Options(
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );
      var now = new DateTime.now();
      var current_mon = now.month;
      Map data = {
        "month": current_mon.toString(),
        "user_id": userId,
      };
      var response = await _dio.post(UrlProvider.setPriorityUrl(),options: options,data: data);
      if(response.statusCode == 200){
        ///data successfully
        // var result = jsonDecode(response.data.toString());
        // print(result);

        // user_model =  User_Model.fromJson(result);
        Fluttertoast.showToast(
            msg: "Priority Updated",
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

  Future<void> deleteMember(String memberId,String groupId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');
    String? userId = prefs.getString('userId');

    try{
      Options options = Options(
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      Map data = {
        "user_id": memberId,
        "group_id": groupId,
      };


      // var response = await _dio.post(UrlProvider.deleteMemberUrl(),options: options,data: data);
      var response = await http.post(Uri.parse(UrlProvider.deleteMemberUrl()),headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },body: data);
      if(response.statusCode == 200){
        ///data successfully
        // var result = jsonDecode(response.data.toString());
        // print(result);
        PaymentDueController _paymentDueController = Get.put(PaymentDueController());
        _paymentDueController.getPaymentDueList();
        _paymentDueController.update();
        GroupDetailController _groupDetailController = Get.put(GroupDetailController(groupId));
        _groupDetailController.getMemberList(groupId);
        _groupDetailController.getGroupPaymentHistoryList(groupId);
        _groupDetailController.getPlanList(groupId);
        // user_model =  User_Model.fromJson(result);
        Fluttertoast.showToast(
            msg: "Member Deleted Successfully",
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
  Future<void> deleteGroup(String groupId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');
    String? userId = prefs.getString('userId');

    try{
      Options options = Options(
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      Map data = {
        "group_id": groupId,
      };

      // var response = await _dio.post(UrlProvider.deleteMemberUrl(),options: options,data: data);
      var response = await http.post(Uri.parse(UrlProvider.deleteGroupUrl()),headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },body: data);
      if(response.statusCode == 200){
        ///data successfully
        // var result = jsonDecode(response.data.toString());
        // print(result);
        // PaymentDueController _paymentDueController = Get.put(PaymentDueController());
        // _paymentDueController.getPaymentDueList();
        // _paymentDueController.update();
        // GroupDetailController _groupDetailController = Get.put(GroupDetailController(groupId));
        // _groupDetailController.getMemberList(groupId);
        // _groupDetailController.getGroupPaymentHistoryList(groupId);
        // _groupDetailController.getPlanList(groupId);
        // user_model =  User_Model.fromJson(result);
        Fluttertoast.showToast(
            msg: "Group Deleted Successfully",
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
    planNameController = TextEditingController();
    amountController = TextEditingController();
    durationController = TextEditingController();
    getPlanList(groupId);
    getMemberList(groupId);
    getGroupPaymentHistoryList(groupId);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {

  }

}
