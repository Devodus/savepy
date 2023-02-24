// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class EditProfileController extends GetxController {
//   final GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
//
//   late TextEditingController emailController, passwordController,confirmPasswordController,mobileController,firstNameController,lastNameController ,zipcodeController;
//
//   late String otp,userId;
//   var email = '';
//   var password = '';
//   var phone = '';
//   FocusNode emailidfocus = FocusNode();
//
//   FocusNode passwordfocus = FocusNode();
//
//   FocusNode fnamefocus = FocusNode();
//   FocusNode lnamefocus = FocusNode();
//
//   FocusNode passwordconffocus = FocusNode();
//
//   FocusNode agefocus = FocusNode();
//
//   FocusNode emailfocus = FocusNode();
//
//   FocusNode linkedinfocus = FocusNode();
//
//   FocusNode facebookfocus = FocusNode();
//
//   FocusNode offerfocus = FocusNode();
//   // User_Model? user_model;
//   var isDataLoading = false.obs;
//
//   String? countryDropdownValue;
//   String? stateDropdownValue;
//   String? cityDropdownValue;
//   List countryData = [].obs;
//   List stateData = [].obs;
//   List cityData = [].obs;
//   Future<String> getCountryList() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // Showing CircularProgressIndicator.
//     bool visible = false;
//
//     var url = 'user/countryList';
//     String? token = prefs.getString('token');
// // state_key - Delhi
//
//     var response = await http.get(Uri.parse(url));
//     // var res = await http.get(Uri.encodeFull(url));
//     var resBody = json.decode(response.body);
//
//     // var resBody1 = resBody['Response'];
//     countryData = resBody['response'];
//
//
//     print(resBody);
//
//     return "Sucess";
//   }
//   Future<String> getStateList(String id) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // Showing CircularProgressIndicator.
//     bool visible = false;
//
//     var url = 'user/stateList/$id';
//     String? token = prefs.getString('token');
// // state_key - Delhi
//
//     var response = await http.get(Uri.parse(url));
//     // var res = await http.get(Uri.encodeFull(url));
//     var resBody = json.decode(response.body);
//
//     // var resBody1 = resBody['Response'];
//       stateData = resBody['response'];
//
//
//     print(resBody);
//
//     return "Sucess";
//   }
//   Future<String> getCityList(String id) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // Showing CircularProgressIndicator.
//     bool visible = false;
//
//     var url = 'user/cityList/$id';
//     String? token = prefs.getString('token');
// // state_key - Delhi
//
//     var response = await http.get(Uri.parse(url));
//     // var res = await http.get(Uri.encodeFull(url));
//     var resBody = json.decode(response.body);
//
//     // var resBody1 = resBody['Response'];
//
//       cityData = resBody['response'];
//
//
//     print(resBody);
//
//     return "Sucess";
//   }
//
//   getApi() async {
//     try{
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       isDataLoading(true);
//       Map data ={
//         "firstName": firstNameController.text.toString(),
//         "middleName": "",
//         "LastName": lastNameController.text.toString(),
//         "email":emailController.text.toString(),
//         "phone": {
//           "number": "",
//           "internationalNumber": "",
//           "nationalNumber": "",
//           "e164Number": phone.toString(),
//           "countryCode": "",
//           "dialCode": ""
//         },
//         "password": passwordController.text.toString()
//       };
//
//       var bod = json.encode(data);
//       var url = Uri.parse('Auth/mobilesignUp');
//       http.Response response = await http.post(url, headers: {"Content-Type": "application/json"},body: bod);
//       if(response.statusCode == 200){
//         ///data successfully
//
//         var result = jsonDecode(response.body);
//         // otp = result["otp"];
//         userId = result["id"];
//         prefs.setString('id', result['id'].toString());
//         print(result);
//         Fluttertoast.showToast(
//             msg: 'OTP sent on your email id',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             backgroundColor: Colors.black54,
//             textColor: Colors.white,
//             timeInSecForIosWeb: 1);
//         // Get.to(() => VerifyOTP(
//         //     emailController.text.toString(),
//         //     passwordController.text.toString(),
//         //     userId,
//         //     "${firstNameController.text.toString()} ${lastNameController.text.toString()}"));
//
//       }else{
//         ///error
//       }
//     }catch(e){
//       // log('Error while getting data is $e');
//       print('Error while getting data is $e');
//     }finally{
//       isDataLoading(false);
//     }
//   }
//
//   getProfile() async {
//
//     try{
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       isDataLoading(true);
//       String? token = prefs.getString("token");
//       // String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InByYWthc2hAaXZvbHdlLmNvbSIsImlkIjoiNjI0ODIyMmM0NzlkZDQ2YTE5ZTM5ODE2IiwiaWF0IjoxNjU3NjA5NjM4LCJleHAiOjE2NTc2OTYwMzh9.2-FiO_TLdafOFLwW_9ud6rNRLZMhLjDsOxZ3SX18TdQ";
//       var url = Uri.parse('user/myProfile');
//       http.Response response = await http.get(url, headers: {"Content-Type": "application/json","Authorization": "Bearer $token"});
//
//       if(response.statusCode == 200){
//         ///data successfully
//         var result = jsonDecode(response.body);
//         // ProfileModel reheatingListModel = ProfileModel.fromJson(result);
//         // reheatingList.assignAll(reheatingListModel.result);
//         print(result);
//
//
//         // Navigator.pushReplacement(
//         //     context,
//         //     CupertinoPageRoute(
//         //         builder: (context) => VerifyOTP(
//         //             emailid.text.toString(),
//         //             password.text.toString(),
//         //             userId,
//         //             fname.text.toString()+" "+lname.text.toString())));
//         // user_model =  User_Model.fromJson(result);
//       }else{
//         ///error
//       }
//     }catch(e){
//       // log('Error while getting data is $e');
//       print('Error while getting data is $e');
//     }finally{
//       isDataLoading(false);
//     }
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     getCountryList();
//     getProfile();
//     emailController = TextEditingController();
//     passwordController = TextEditingController();
//     confirmPasswordController = TextEditingController();
//     mobileController = TextEditingController();
//     firstNameController = TextEditingController();
//     lastNameController = TextEditingController();
//     zipcodeController = TextEditingController();
//   }
//
//   @override
//   void onReady() {
//     super.onReady();
//   }
//
//   @override
//   void onClose() {
//     emailController.dispose();
//     passwordController.dispose();
//     confirmPasswordController.dispose();
//     mobileController.dispose();
//     firstNameController.dispose();
//     lastNameController.dispose();
//     zipcodeController.dispose();
//   }
//
//   late String phoneNumber;
//   late String phoneIsoCode;
//   late String interPhoneNumber;
//   bool visible = false;
//   String confirmedNumber = '';
//   String? validateEmail(String value) {
//     if (value.length == 0) {
//       return "Please enter emaid address";
//     } else if (value.length == 0 ||
//         !value.contains('@') ||
//         !value.contains('.')) {
//       return "Invalid email address";
//     } else {
//       return null;
//     }
//   }
//
//   String? validatePassword(String value) {
//     if (value.length < 6) {
//       return "Password is required";
//     } else {
//       return null;
//     }
//   }
//
//   String? validateFirstName(String value) {
//     if (value.length == 0) {
//       return "Firstname is required";
//     } else {
//       return null;
//     }
//   }
//   String? validateLastName(String value) {
//     if (value.length == 0) {
//       return "Lastname is required";
//     } else {
//       return null;
//     }
//   }
//
//
//   void onPhoneNumberChange(
//       String number, String internationalizedPhoneNumber, String isoCode) {
//     print(number);
//     phoneNumber = number;
//     phoneIsoCode = isoCode;
//     interPhoneNumber = internationalizedPhoneNumber;
//     // print(phoneNumber);
//     // print(phoneIsoCode);
//     // print(internationalizedPhoneNumber);
//   }
//
//   onValidPhoneNumber(
//       String number, String internationalizedPhoneNumber, String isoCode) {
//     visible = true;
//     confirmedNumber = internationalizedPhoneNumber;
//   }
//
//   void checkSignup() {
//     final isValid = signupFormKey.currentState!.validate();
//     if (!isValid) {
//       return;
//     }
//     else
//     {
//       signupFormKey.currentState!.save();
//       print(mobileController.text.toString());
//       print(phone);
//       if(passwordController.text.toString()==confirmPasswordController.text.toString()) {
//         getApi();
//       }
//       else{
//         Fluttertoast.showToast(
//             msg: 'Password mismatch',
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.CENTER,
//             backgroundColor: Colors.black54,
//             textColor: Colors.white,
//             timeInSecForIosWeb: 1);
//       }
//     }
//   }
// }
