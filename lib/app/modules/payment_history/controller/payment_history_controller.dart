import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savepy/app/Networking/url_provider.dart';
import 'package:savepy/app/common/session_timeout.dart';
import 'package:savepy/app/modules/home/model/grouplist_model.dart';
import 'package:savepy/app/modules/member_list/model/member_list_model.dart';
import 'package:savepy/app/modules/payment_history/model/payment_history_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentHistoryController extends GetxController {

  late TextEditingController groupNameController;

  var paymentHistoryList = <UserPaymentHistory>[].obs;

  var isPaymentListLoading =0.obs;
  var isPullRefresh =false.obs;
  late Dio _dio = Dio(BaseOptions(baseUrl:""));

  Future<void> pullRefresh() async {
    isPullRefresh.value=true;
    print("pull");
    getPaymentHistoryList().whenComplete(() => isPullRefresh.value=false);
    update();
    // why use freshNumbers var? https://stackoverflow.com/a/52992836/2301224
  }
Future<void> getPaymentHistoryList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');
    String? userId = prefs.getString('userId');

    print(token);

    try{
      Map data = {
        "email": email,
        "user_id": userId,
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
      var response = await _dio.post(UrlProvider.paymentHistoryListUrl(),options: options,data: data);

      print("payment list>>");

      if (response.statusCode == 200) {

        if(response.data['message']=="Access denied")
        {
          Get.offAll(TimeOut());
        }

        if (response.data['flag'] == "true") {
          UserPaymentHistoryModel paymentHistoryModel = UserPaymentHistoryModel.fromJson(response.data);
          paymentHistoryList.assignAll(paymentHistoryModel.userPaymentHistory!);
          // paymentHistoryList.reversed.toList();
          paymentHistoryList = RxList.from(paymentHistoryList.reversed.toList());
          isPaymentListLoading.value= 1;
        } else {
          isPaymentListLoading.value= 2;
        }
      } else if (response.statusCode != 200) {
        print("Status.ERROR");
        isPaymentListLoading.value=2;
      }
    }catch(e){
      // log('Error while getting data is $e');
      isPaymentListLoading.value=2;
      print('Error while getting data is $e');
    }finally{
      // isDataLoading(false);
    }

  }


  @override
  void onInit() {
    super.onInit();
    getPaymentHistoryList();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {

  }

}
