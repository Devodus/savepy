import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:savepy/app/Networking/url_provider.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/modules/group_detail/controller/group_detail_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import '../../home/controllers/home_controller.dart';
import '../../landing_page/view/landing_view.dart';
import '../../member_list/controller/member_list_controller.dart';
import '../../my_profile/controller/myprofile_controller.dart';

class CompleteProfileController extends GetxController {
  CompleteProfileController(this.firstNameP,this.lastNameP,this.emailP,this.mobileP);
  var firstNameP;
  var lastNameP;
  var emailP;
  var mobileP;

  final GlobalKey<FormState> addMemberFormKey = GlobalKey<FormState>();
  var countryValue = "".obs;
  var stateValue = "".obs;
  var cityValue = "".obs;
  var isDataLoading = false.obs;
  XFile? image;
  var imagePicker;
  bool flagIndicator=false;
  var userType="1".obs;
  var colorbtnInd= blue_color.obs;
  var colorbtngroup= grey.obs;
  var userImage;
  var isEighteenYear = false.obs;
  var isTermCondition =false.obs;
  late TextEditingController firstNameController, lastNameController, emailController,addressController,
      passwordController, userTypeController, mobileController, countryController,
      accountNumberController, bankNameController, ifscCodeController, accountHolderNameController,
      bankAddressController, ssnController, docController;
  var firstName = '';
  var lastName = '';
  var email = '';
  var password = '';
  var mobile = '';
  var country = '';
  var state = '';
  var city = '';
  var address = '';
  var accountNumber = '';
  var bankName = '';
  var ifscCode = '';
  var accountHolderName = '';
  var bankAddress = '';
  var doc = '';
  var ssn = '';
  var phone = '';


  @override
  void onInit() {
    super.onInit();
    // _myProfileController.getMyProfile().whenComplete(() => (null));
    // print('${_myProfileController.user.value?.userProfileData?.firstName}');
    // print('${_myProfileController.user}');
    imagePicker = new ImagePicker();
    firstNameController = TextEditingController(text: '$firstNameP');
    addressController = TextEditingController();
    lastNameController = TextEditingController(text: '$lastNameP');
    emailController = TextEditingController(text: '$emailP');
    userTypeController = TextEditingController();
    mobileController = TextEditingController(text: '$mobileP');
    accountNumberController = TextEditingController();
    bankNameController = TextEditingController();
    bankAddressController = TextEditingController();
    ssnController = TextEditingController();
    docController = TextEditingController();
    ifscCodeController = TextEditingController();
    accountHolderNameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    addressController.dispose();
    lastNameController.dispose();
    userTypeController.dispose();
    mobileController.dispose();
    accountNumberController.dispose();
    bankNameController.dispose();
    bankAddressController.dispose();
    ssnController.dispose();
    docController.dispose();
    ifscCodeController.dispose();
    accountHolderNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  String? validateEmail(String value) {

    if(value=="")
    {
      return "Please Enter Email Id";
    }
    else if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }
  String? validatePassword(String value) {
    if(value=="")
    {
      return "Please Enter password";
    }
    else if (value.length < 6) {
      return "Password must be of 6 characters";
    }
    return null;
  }
  String? validateFirstName(String value) {
    if(value=="")
    {
      return "Please Enter First Name";
    }
    return null;
  }
  String? validateLastName(String value) {
    if(value=="")
    {
      return "Please Enter Last Name";
    }
    return null;
  }
  String? validateAddress(String value) {
    if(value=="")
    {
      return "Please Enter Address";
    }
    else if (value.length < 10) {
      return "Address too short";
    }
    return null;
  }
  String? validateBankAddress(String value) {
    if(value=="")
    {
      return "Please Enter Address";
    }
    else if (value.length < 10) {
      return "Address too short";
    }
    return null;
  }
  String? validateAccountNumber(String value) {
    if(value=="")
    {
      return "Please Enter Account Number";
    }
    else if (value.length < 16) {
      return "Account Number is too short";
    }
    return null;
  }
  String? validateBankName(String value) {
    if(value=="")
    {
      return "Please Enter Bank Name";
    }
    return null;
  }
  String? validateSSN(String value) {

    if(value=="")
    {
      return "Please Enter SSN";
    }
    else if (!GetUtils.isSSN(value)) {
      return "Provide valid SSN";
    }
    return null;
  }
  String? validateIfscCode(String value) {
    if(value=="")
    {
      return "Please Enter IFSC Code";
    }
    return null;
  }
  String? validateAccountHolderName(String value) {
    if(value=="")
    {
      return "Please Enter Account Holder Name";
    }
    return null;
  }

  Future addMember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? userEmail = prefs.getString('email');

    try{
      isDataLoading(true);
      var request = http.MultipartRequest('POST', Uri.parse(UrlProvider.updateProfileUrl()));
      Map<String, String> headers = {
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'Authorization': 'Bearer $token'};
      request.headers.addAll(headers);
      request.fields.addAll({
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        // 'usr_type': userType.value,
        'mobile': mobileController.text,
        'country':countryValue.value,
        'state': stateValue.value,
        'city': cityValue.value,
        'address': addressController.text,
        'account_number': accountNumberController.text,
        'bank_name': bankNameController.text,
        'bank_ifsc_code': ifscCodeController.text,
        'account_holder_name': accountHolderNameController.text,
        'bank_address': bankAddressController.text,
        'fld_ssn':ssnController.text,
        'leader_email': "${userEmail}",
      });
      request.files.add(await http.MultipartFile.fromPath('doc',userImage));
      http.StreamedResponse streamedResponse  = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final body = json.decode(response.body);
      print(await body["message"]);
      if (response.statusCode == 200) {


        Fluttertoast.showToast(
            msg: body["message"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: HexColor(blue_color),
            textColor: Colors.white,
            fontSize: 14.0
        );
        prefs.setBool("isLogin", true);
        Get.off(LandingPage());
      }
      else{
        Fluttertoast.showToast(
            msg: body["message"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: HexColor(blue_color),
            textColor: Colors.white,
            fontSize: 14.0
        );
      }
    }catch(e){
      // log('Error while getting data is $e');
      print('Error while getting data is $e');
    }finally{
      isDataLoading(false);
    }
  }

  void checkAddMember() {
    final isValid = addMemberFormKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    if(countryValue=="")
    {
      Fluttertoast.showToast(
          msg: 'Please Select Country',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: HexColor(blue_color),
          textColor: Colors.white,
          fontSize: 14.0
      );
    }else  if(stateValue=="")
    {
      Fluttertoast.showToast(
          msg: 'Please Select State',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: HexColor(blue_color),
          textColor: Colors.white,
          fontSize: 14.0
      );
    }
    else  if(cityValue=="")
    {
      Fluttertoast.showToast(
          msg: 'Please Select City',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: HexColor(blue_color),
          textColor: Colors.white,
          fontSize: 14.0
      );
    }
    else if(userImage==""||userImage==null)
    {
      Fluttertoast.showToast(
          msg: 'Please Upload Document',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: HexColor(blue_color),
          textColor: Colors.white,
          fontSize: 14.0
      );
    }

    else {
      // print(isEighteenYear.value);
      // print(isTermCondition.value);
      // // registation();
      // print(userType);
      // print(countryValue);
      // print(stateValue);
      // print(cityValue);

      addMember();

    }
    addMemberFormKey.currentState!.save();
  }

  selectImage() async {
    var source = ImageSource.gallery;
    image = await imagePicker.pickImage(
        source: source, imageQuality: 50);
    userImage=image?.path;
    docController.text=userImage;
  }
}
