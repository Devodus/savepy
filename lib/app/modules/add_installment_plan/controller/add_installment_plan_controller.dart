import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:savepy/app/Networking/url_provider.dart';
import 'package:savepy/app/modules/group_detail/controller/group_detail_controller.dart';
import 'package:savepy/app/modules/group_detail/view/group_detail_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddInstallmentPlanController extends GetxController {
  AddInstallmentPlanController (this.groupId);
  var groupId;

  final GlobalKey<FormState> addInstallmentPlanFormKey = GlobalKey<FormState>();
  late Dio _dio = Dio(BaseOptions(baseUrl:""));
  var isDataLoading =false.obs;
  late TextEditingController planNameController, amountController, emailController,durationController;
  var planName = '';
  var amount = '';
  var duration = '';
  var today=DateTime.now().toString().obs;
  Rx<String> selectedDate = "Date".obs;
  void setDate(String selectedDate) {
    String b = DateFormat('yyyy-MM').format(DateTime.parse(selectedDate));
    this.selectedDate.value = "$b-01";
    //updating the value of Rx Variable.
  }

  @override
  void onInit() {
    super.onInit();
    planNameController = TextEditingController();
    durationController = TextEditingController();
    amountController = TextEditingController();
    emailController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {

    planNameController.dispose();
    amountController.dispose();
    emailController.dispose();
    durationController.dispose();

  }


  String? validateDuration(String value) {
    if(value=="")
    {
      return "Please Enter Durtaion";
    }
    return null;
  }
  String? validatePlanName(String value) {
    if(value=="")
    {
      return "Please Enter Plan Name";
    }
    return null;
  }
  String? validateAmount(String value) {
    if(value=="")
    {
      return "Please Enter Amount";
    }
    return null;
  }


  Future<void> addInstallmentPlan(String groupId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');
    GroupDetailController _groupDetailController = Get.put(GroupDetailController(groupId));
    try{
      isDataLoading(true);
      Options options = Options(
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      Map data = {
        "plan_name": planNameController.text,
        "amount": amountController.text,
        "start_date": selectedDate.toString(),
        "email": email,
        "group_id": groupId,
      };
      var response = await _dio.post(UrlProvider.createPlanUrl(),options: options,data: data);
      if(response.statusCode == 200){
        ///data successfully
        // var result = jsonDecode(response.data.toString());
        // print(result);
        // user_model =  User_Model.fromJson(result);
        _groupDetailController.getPlanList(groupId);
        Fluttertoast.showToast(
            msg: "Plan Created",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            timeInSecForIosWeb: 1);
        Get.back();

      }else{
        ///error
      }
    }catch(e){
      // log('Error while getting data is $e');
      print('Error while getting data is $e');
    }finally{
      isDataLoading(false);
    }
  }


  void checkAddInstallmentPlan(String groupId) {
    final isValid = addInstallmentPlanFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    else{
      addInstallmentPlan(groupId);
    }

    addInstallmentPlanFormKey.currentState!.save();
  }

}
