// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert' as JSON;
// import 'package:nb_utils/nb_utils.dart' as nb;
// import '../../../Constants/Constants.dart';
//
// class EditProfile extends StatefulWidget {
//   @override
//   _EditProfileState createState() => _EditProfileState();
// }
//
// class _EditProfileState extends State<EditProfile> {
//   String? firstName, lastName, email, profilePic, phoneNumber,
//       pro_password,countryName,stateName,cityName,zipCode,countryCode,
//       country,state,city;
//   bool visible=false;
//
//   String? countryDropdownValue,stateDropdownValue,cityDropdownValue;
//   List countryData = [];
//   List stateData = [];
//   List cityData = [];
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
//
//     setState(() {
//       countryData = resBody['response'];
//     });
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
//
//     setState(() {
//       stateData = resBody['response'];
//     });
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
//     setState(() {
//       cityData = resBody['response'];
//     });
//
//     print(resBody);
//
//     return "Sucess";
//   }
//
//   getApi() async {
//
//     try{
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//
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
//         print("profile data>>");
//         print(result);
//
//
//         firstName=result["response"]["firstName"];
//         lastName=result["response"]["lastName"];
//         email=result["response"]["emailId"];
//         countryName=result["response"]["countryName"];
//         country=result["response"]["country"];
//         stateName=result["response"]["stateName"];
//         state=result["response"]["state"];
//         cityName=result["response"]["cityName"];
//         city=result["response"]["city"];
//         email=result["response"]["zipCode"];
//         profilePic=result["response"]["profilePic"];
//         phoneNumber=result["response"]["phone"]["e164Number"];
//         countryCode=result["response"]["phone"]["countryCode"];
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
//
//     }
//   }
//
//
//   Future userLogin() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     // Showing CircularProgressIndicator.
//     String? token = prefs.getString('token');
//     setState(() {
//       visible = true;
//     });
//
//
//     var url = 'user/updateProfile';
//
//
//
//     Map data =       {
//       "firstName": !["", null, false, 0].contains(fname.text.toString()) ? fname.text.toString() : firstName,
//       "LastName": !["", null, false, 0].contains(lname.text.toString()) ? lname.text.toString() : lastName,
//       "email":!["", null, false, 0].contains(emailid.text.toString()) ? emailid.text.toString() : email,
//       "country": !["", null, false, 0].contains(countryDropdownValue.toString()) ? countryDropdownValue.toString() : country,
//       "state": !["", null, false, 0].contains(stateDropdownValue.toString()) ? stateDropdownValue.toString() : state,
//       "city": !["", null, false, 0].contains(cityDropdownValue.toString()) ? cityDropdownValue.toString() : city,
//       "zipcode": !["", null, false, 0].contains(zipcodeController.toString()) ? zipcodeController.toString() : zipCode,
//       "image": "",
//       "phone": {
//         "number": "",
//         "internationalNumber": "",
//         "nationalNumber": "",
//         "e164Number": !["", null, false, 0].contains(mobile.toString()) ? mobile.toString() : phoneNumber,
//         "countryCode": "",
//         "dialCode": ""
//       },
//       "lang":"en"
//     };
//
//     var bod = json.encode(data);
//
//     var uri = Uri.parse(url);
//     var request = new http.MultipartRequest("PUT", uri);
//
//     request.fields['firstName'] = 'Ankit';
//     request.fields['LastName'] = 'kumar';
//
//     request.send().then((res) {
//       print(res.statusCode);
//       if (res.statusCode == 200) print("Uploaded!");
//     });
// //     // Starting Web API Call.
// //     var response = await http.put(url, headers: {"Content-Type": "application/json", 'Authorization': 'Bearer $token',},body: bod);
// //
// //     // Getting Server response into variable.
// //
// //     var body = await json.decode(response.body);
// //     var message = jsonDecode(response.body);
// //     print("Done");
// //
// // //    print("ffff" + message.toString());
// //
// //     try {
// //       if (body['status'] == true) {
// //
// //         Fluttertoast.showToast(
// //             msg: 'Profile updated Successfully',
// //             toastLength: Toast.LENGTH_SHORT,
// //             gravity: ToastGravity.CENTER,
// //             backgroundColor: Colors.black54,
// //             textColor: Colors.white,
// //             timeInSecForIosWeb: 1);
// //
// //         Navigator.pushReplacement(
// //             context,
// //             CupertinoPageRoute(
// //                 builder: (context) => FrontPage()));
// //       } else if (body['status'] == false) {
// // //
// //         setState(() {
// //           visible = false;
// //         });
// //         Fluttertoast.showToast(
// //             msg: body['message'],
// //             toastLength: Toast.LENGTH_SHORT,
// //             gravity: ToastGravity.CENTER,
// //             backgroundColor: Colors.black54,
// //             textColor: Colors.white,
// //             timeInSecForIosWeb: 1);
// //       } else if (body['status_code'] == 401) {
// //         setState(() {
// //           visible = false;
// //         });
// //
// //         Fluttertoast.showToast(
// //           msg: 'emailPassIncrrect',
// //           toastLength: Toast.LENGTH_SHORT,
// //           gravity: ToastGravity.CENTER,
// //           backgroundColor: Colors.black54,
// //           textColor: Colors.white,
// //           timeInSecForIosWeb: 1,
// //         );
// //       }
// //     } catch (e) {
// //       Fluttertoast.showToast(
// //         msg: e.toString(),
// //         toastLength: Toast.LENGTH_SHORT,
// //         gravity: ToastGravity.CENTER,
// //         backgroundColor: Colors.black54,
// //         textColor: Colors.white,
// //         timeInSecForIosWeb: 1,
// //       );
// //       throw Exception(e);
// //     }
//     // If the Response Message is Matched.
//   }
//
//   TextEditingController fname = TextEditingController();
//
//   TextEditingController lname = TextEditingController();
//
//   TextEditingController emailid = TextEditingController();
//
//   TextEditingController mobile = TextEditingController();
//
//   TextEditingController address = TextEditingController();
//
//   // TextEditingController city = TextEditingController();
//
//   TextEditingController zipcodeController = TextEditingController();
//
//   // TextEditingController country = TextEditingController();
//
//   // TextEditingController state = TextEditingController();
//
//   TextEditingController addressbill = TextEditingController();
//
//   TextEditingController citybill = TextEditingController();
//
//   TextEditingController zipcodebill = TextEditingController();
//
//   TextEditingController countrybill = TextEditingController();
//
//   TextEditingController statebill = TextEditingController();
//   TextEditingController password = TextEditingController();
//
//   FocusNode fnamefocus = FocusNode();
//
//   FocusNode lnamefocus = FocusNode();
//
//   FocusNode emailidfocus = FocusNode();
//
//   FocusNode mobilefocus = FocusNode();
//
//   FocusNode addressfocus = FocusNode();
//
//   FocusNode cityfocus = FocusNode();
//
//   FocusNode zipfocus = FocusNode();
//
//   FocusNode countryfocus = FocusNode();
//
//   FocusNode zipbillfocus = FocusNode();
//
//   FocusNode countrybillfocus = FocusNode();
//
//   FocusNode statefocus = FocusNode();
//
//   FocusNode addressbillfocus = FocusNode();
//
//   FocusNode citybillfocus = FocusNode();
//
//   FocusNode statebillfocus = FocusNode();
//   FocusNode passwordfocus = FocusNode();
//   bool iscollect = false;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getApi();
//     getCountryList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(
//                       left: 24.0, top: height * 0.03, bottom: height * 0.03),
//                   child: Container(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       // crossAxisAlignment: CrossAxisAlignment.end,
//                       children: [
//                         Row(
//                           children: [
//                             Icon(Icons.arrow_back_ios),
//                             textWidget('EDIT PROFILE'.tr, 24, FontWeight.bold,
//                                 'Lato', 0xff000000, '', false),
//                           ],
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.only(right: 24.0),
//                           child: Row(
//                             children: [
//                               SvgPicture.asset(
//                                 'assets/images/editicon.svg',
//                                 height: 16,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 CircleAvatar(
//                   radius: 55,
//                   backgroundImage: NetworkImage("${profilePic}"),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 textWidget('Change Profile Picture'.tr, 12, FontWeight.normal,
//                     'Lato', 0xff707070, '', true),
//                 Form(
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 21,
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: 24, right: 24, bottom: height * 0.0001),
//                             child: AppTextField(
//                               controller: fname,
//                               focus: fnamefocus,
//                               textFieldType: TextFieldType.EMAIL,
//                               decoration: inputDecoration(context,
//                                   hint: !["", null, false, 0].contains(firstName)
//                                       ? firstName
//                                       : 'First Name'.tr),
//                               errorThisFieldRequired: 'First Name'.tr,
//                               nextFocus: lnamefocus,
//                             ).paddingBottom(16),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: 24, right: 24, bottom: height * 0.0001),
//                             child: AppTextField(
//                                 controller: lname,
//                                 focus: lnamefocus,
//                                 textFieldType: TextFieldType.EMAIL,
//                                 decoration: inputDecoration(context,
//                                     hint: !["", null, false, 0]
//                                         .contains(lastName)
//                                         ? lastName
//                                         : 'Last Name'.tr),
//                                 errorThisFieldRequired: 'Last Name'.tr,
//                                 nextFocus: emailidfocus)
//                                 .paddingBottom(16),
//                           ),
//
//                           // Padding(
//                           //   padding: EdgeInsets.only(
//                           //       left: 24, right: 24, bottom: height * 0.0001),
//                           //   child: AppTextField(
//                           //           controller: emailid,
//                           //           focus: emailidfocus,
//                           //           textFieldType: TextFieldType.EMAIL,
//                           //           decoration: inputDecoration(context,
//                           //               hint: 'Address Line 1'),
//                           //           errorThisFieldRequired: 'field_Required',
//                           //           nextFocus: mobilefocus)
//                           //       .paddingBottom(16),
//                           // ),
//                           // Padding(
//                           //   padding: EdgeInsets.only(
//                           //       left: 24, right: 24, bottom: height * 0.0001),
//                           //   child: AppTextField(
//                           //           controller: address,
//                           //           focus: addressfocus,
//                           //           textFieldType: TextFieldType.EMAIL,
//                           //           decoration: inputDecoration(context,
//                           //               hint: 'Address Line 2'),
//                           //           errorThisFieldRequired: 'field_Required',
//                           //           nextFocus: cityfocus)
//                           //       .paddingBottom(16),
//                           // ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: 24, right: 24, bottom: height * 0.0001),
//                             child: Row(
//                               // mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Expanded(
//                                   child: Container(
//
//                                     // height: 62,
//
//                                     // decoration: BoxDecoration(
//                                     //     color: Colors.white,
//                                     //     borderRadius: BorderRadius.all(
//                                     //         Radius.circular(18.0))),
//                                     // color: Colors.transparent,
//                                     child: DropdownButton<String>(
//                                       hint: Padding(
//                                         padding: const EdgeInsets.all(0),
//                                         child: Text(
//                                           !["", null, false, 0].contains(countryName)
//                                               ? countryName!
//                                               : 'Select Country',
//                                           style: TextStyle(
//                                             color: Colors.grey,
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                       ),
//                                       isExpanded: true,
//                                       items: countryData.map((item) {
//                                         return new DropdownMenuItem(
//                                           child: Padding(
//                                             padding:
//                                             const EdgeInsets.all(0),
//                                             child:
//                                             new Text(item['name'].toString()),
//                                           ),
//                                           value: item['id'].toString(),
//                                         );
//                                       }).toList(),
//                                       onChanged: (newValue) {
//                                         setState(() {
//                                           countryDropdownValue = newValue;
//
//                                           stateData.clear();
//                                           cityData.clear();
//                                           stateDropdownValue=null;
//                                           cityDropdownValue=null;
//                                           getStateList(countryDropdownValue!);
//
//                                           // print(countryDropdownValue);
//                                         });
//                                       },
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 18,
//                                       ),
//                                       value: countryDropdownValue,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 21,
//                                 ),
//                                 Expanded(
//                                   child: Container(
//
//                                     // height: 62,
//
//                                     // decoration: BoxDecoration(
//                                     //     color: Colors.white,
//                                     //     borderRadius: BorderRadius.all(
//                                     //         Radius.circular(18.0))),
//                                     // color: Colors.transparent,
//                                     child: DropdownButton<String>(
//                                       hint: Padding(
//                                         padding: const EdgeInsets.all(0),
//                                         child: Text(
//                                           !["", null, false, 0].contains(stateName)
//                                               ? stateName!
//                                               : 'Select State',
//                                           style: TextStyle(
//                                             color: Colors.grey,
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                       ),
//                                       isExpanded: true,
//                                       items: stateData.map((item) {
//                                         return new DropdownMenuItem(
//                                           child: Padding(
//                                             padding:
//                                             const EdgeInsets.all(0),
//                                             child:
//                                             new Text(item['name'].toString()),
//                                           ),
//                                           value: item['id'].toString(),
//                                         );
//                                       }).toList(),
//                                       onChanged: (newValue) {
//                                         setState(() {
//                                           stateDropdownValue = newValue;
//
//                                           // stateData.clear();
//                                           cityData.clear();
//                                           cityDropdownValue=null;
//
//                                           getCityList(stateDropdownValue!);
//
//                                           // print(countryDropdownValue);
//                                         });
//                                       },
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 18,
//                                       ),
//                                       value: stateDropdownValue,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 left: 24, right: 24, bottom: height * 0.0001),
//                             child: Row(
//                               // mainAxisSize: MainAxisSize.min,
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 Expanded(
//                                   child: Container(
//
//                                     // height: 62,
//
//                                     // decoration: BoxDecoration(
//                                     //     color: Colors.white,
//                                     //     borderRadius: BorderRadius.all(
//                                     //         Radius.circular(18.0))),
//                                     // color: Colors.transparent,
//                                     child: DropdownButton<String>(
//                                       hint: Padding(
//                                         padding: const EdgeInsets.all(0),
//                                         child: Text(
//                                           !["", null, false, 0].contains(cityName)
//                                               ? cityName!
//                                               : 'Select City',
//                                           style: TextStyle(
//                                             color: Colors.grey,
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                       ),
//                                       isExpanded: true,
//                                       items: cityData.map((item) {
//                                         return new DropdownMenuItem(
//                                           child: Padding(
//                                             padding:
//                                             const EdgeInsets.all(0),
//                                             child:
//                                             new Text(item['name'].toString()),
//                                           ),
//                                           value: item['id'].toString(),
//                                         );
//                                       }).toList(),
//                                       onChanged: (newValue) {
//                                         setState(() {
//                                           cityDropdownValue = newValue;
//
//                                           // cityData.clear();
//                                           // getCityList(stateDropdownValue);
//
//                                           // print(countryDropdownValue);
//                                         });
//                                       },
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 18,
//                                       ),
//                                       value: cityDropdownValue,
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 21,
//                                 ),
//                                 Expanded(
//                                   child: Container(
//                                     // width: width * 0.4,
//                                     child: AppTextField(
//                                         controller: zipcodeController,
//                                         focus: zipfocus,
//                                         textFieldType: TextFieldType.EMAIL,
//                                         decoration: inputDecoration(context,
//                                             hint: !["", null, false, 0].contains(zipCode)
//                                                 ? zipCode!
//                                                 : 'Zipcode'),
//                                         errorThisFieldRequired:
//                                         'field_Required',
//                                         nextFocus: statefocus)
//                                         .paddingBottom(16),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//
//
//                         ],
//                       ),
//                     )),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       left: 24, right: 24, bottom: height * 0.0001),
//                   child: AppTextField(
//                       enabled: false,
//                       controller: mobile,
//                       focus: mobilefocus,
//                       textFieldType: TextFieldType.PHONE,
//                       decoration:
//                       inputDecoration(context, hint: !["", null, false, 0].contains(phoneNumber)
//                           ? phoneNumber
//                           : 'Mobile Number'.tr),
//                       errorThisFieldRequired: 'Mobile Number'.tr,
//                       nextFocus: addressfocus)
//                       .paddingBottom(16),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: 24.0, bottom: height * 0.04,right: 24.0,),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: IntlPhoneField(
//                       controller: mobile,
//                       initialCountryCode: !["", null, false, 0].contains(countryCode)
//                           ? countryCode!
//                           : 'IN',
//                       // initialValue: "9999999999",
//                       decoration: InputDecoration(
//                         labelText: 'Mobile Number'.tr,
//                         border: OutlineInputBorder(
//                           borderSide: BorderSide(),
//                         ),
//                       ),
//                       onChanged: (phone) {
//                         print(phone.completeNumber);
//                         phoneNumber=phone.completeNumber;
//                       },
//                       onCountryChanged: (country) {
//                         print('Country changed to: ' + country.name);
//                       },
//                     ),
//                   ),
//                 ),
//                 // Padding(
//                 //   padding: EdgeInsets.only(
//                 //       left: 24, right: 24, bottom: height * 0.0001),
//                 //   child: Stack(
//                 //     children: [
//                 //       Align(
//                 //         alignment: Alignment.centerRight,
//                 //         child: GestureDetector(
//                 //           onTap: (){
//                 //
//                 //           },
//                 //           child: textWidget(
//                 //               'Change Password',
//                 //               12,
//                 //               FontWeight.bold,
//                 //               'Lato',
//                 //               0xff0864B1,
//                 //               '',
//                 //               true),
//                 //         ),
//                 //       ),
//                 //       AppTextField(
//                 //         enabled: false,
//                 //         controller: password,
//                 //         focus: passwordfocus,
//                 //         textFieldType: TextFieldType.PASSWORD,
//                 //         isPassword: true,
//                 //
//                 //         onTap: (){
//                 //           // Navigator.push(
//                 //           //     context,
//                 //           //     CupertinoPageRoute(
//                 //           //         builder: (context) => Changepassword()));
//                 //         },
//                 //
//                 //         decoration:
//                 //         inputDecoration(context, hint: 'Password'),
//                 //         errorThisFieldRequired: 'Password is required',
//                 //         // initialValue: "Password",
//                 //
//                 //         nextFocus: lnamefocus,
//                 //       ).paddingBottom(16),
//                 //     ],
//                 //   ),
//                 // ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       left: 24, right: 24, bottom: height * 0.02),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: textWidget('Delete My Account'.tr, 16,
//                         FontWeight.bold, 'Lato', 0xff000000, '', false),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                       left: 24, right: 24, bottom: height * 0.02),
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: textWidget(
//                         'You can login to your account within 30 days to be an active member.After 30 days your account will be deleted if you dont login to your account'.tr,
//                         12,
//                         FontWeight.bold,
//                         'Lato',
//                         0xffC3C3C3,
//                         '',
//                         false),
//                   ),
//                 ),
//
//                 Container(
//                   alignment: Alignment.center,
//                   width: width * 0.4,
//                   height: 42,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Material(
//                         child: InkWell(
//                           borderRadius:
//                           BorderRadius.circular(10),
//                           splashColor: Colors.grey,
//                           onTap: () {
//                             FocusScope.of(context).requestFocus(FocusNode());
//                             // formKey.currentState.save();
//                             userLogin();
//                             print("here");
//                           },
//                           child: Container(
//                             width: width * 0.4,
//                             alignment: Alignment.center,
//                             height: 50,
//                             decoration: BoxDecoration(
//                                 color: Color(0xff0B58A0),
//                                 borderRadius:
//                                 BorderRadius.circular(25),
//                                 border: Border.all(
//                                     color: Colors.black)),
//                             child: textWidget(
//                                 'SAVE'.tr,
//                                 16,
//                                 FontWeight.bold,
//                                 'Lato',
//                                 0xffFFFFFF,
//                                 '',
//                                 false),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 10,)
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
