import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:savepy/app/modules/auth/views/waiting_for_approval.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';

class RegistrationController extends GetxController {
  final GlobalKey<FormState> registrationFormKey = GlobalKey<FormState>();
  var countryValue = "".obs;
  var stateValue = "".obs;
  var cityValue = "".obs;
  var isDataLoading = false.obs;
  File? image;
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
    imagePicker = new ImagePicker();
    firstNameController = TextEditingController();
    addressController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    userTypeController = TextEditingController();
    mobileController = TextEditingController();
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
    else if (value.length < 15) {
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
      return "Please Enter SSN Number";
    }
    return null;
  }
  String? validateIfscCode(String value) {
    if(value=="")
    {
      return "Please Enter IFSC Code";
    }
    else if (value.length!=9) {
      return "Invalid routing number";
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

  Future registration() async {

    try{
      isDataLoading(true);
      var request = http.MultipartRequest('POST', Uri.parse('https://savepy.com/savepy-api/savepy_app_api.php?check_registraion=1'));
      request.fields.addAll({
        'first_name': firstNameController.text,
        'last_name': lastNameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'usr_type': userType.value,
        'mobile': mobileController.text,
        'country':countryValue.value,
        'state': stateValue.value,
        'city': cityValue.value,
        // 'address': addressController.text,
        'account_number': accountNumberController.text,
        // 'bank_name': bankNameController.text,
        'bank_ifsc_code': ifscCodeController.text,
        // 'account_holder_name': accountHolderNameController.text,
        // 'bank_address': bankAddressController.text,
        // 'fld_ssn':ssnController.text,
        'fld_term_eighteen_year': "1",
        'fld_term_condition': "1",
      });
      request.files.add(await http.MultipartFile.fromPath('doc',userImage));
      http.StreamedResponse streamedResponse  = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      final body = json.decode(response.body);
      print(await body["message"]);
      if (response.statusCode == 200) {

        Get.off(WaitingForApproval());
        Fluttertoast.showToast(
            msg: body["message"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: HexColor(blue_color),
            textColor: Colors.white,
            fontSize: 14.0
        );
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

  void checkRegistration() {
    final isValid = registrationFormKey.currentState!.validate();
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

    else if(isTermCondition==false)
    {
      Fluttertoast.showToast(
          msg: 'Please Accept Terms and Conditions',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: HexColor(blue_color),
          textColor: Colors.white,
          fontSize: 14.0
      );
    }
    else if(isEighteenYear==false)
    {
      Fluttertoast.showToast(
          msg: 'You Must Be 18 Years Old To Access This App',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: HexColor(blue_color),
          textColor: Colors.white,
          fontSize: 14.0
      );
    }else {
      // print(isEighteenYear.value);
      // print(isTermCondition.value);
      // // registation();
      // print(userType);
      // print(countryValue);
      // print(stateValue);
      // print(cityValue);

      registration();

    }
    registrationFormKey.currentState!.save();
  }

  // selectImage() async {
  // var source = ImageSource.gallery;
  // try{
  //   image = await imagePicker.pickImage(
  //       source: source, imageQuality: 50);
  //   userImage=image?.path;
  //   docController.text=userImage;
  // }
  // catch(error) {
  //   Fluttertoast.showToast(
  //       msg: '$error',
  //       toastLength: Toast.LENGTH_LONG,
  //       gravity: ToastGravity.CENTER,
  //       backgroundColor: HexColor(blue_color),
  //       textColor: Colors.white,
  //       fontSize: 14.0
  //   );
  //   print("error: $error");
  // }
  //
  // }
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
      this.image = imageTemp;
      userImage=image?.path;
      docController.text=userImage;
    } on PlatformException catch(e) {
        Fluttertoast.showToast(
            msg: '$e',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: HexColor(blue_color),
            textColor: Colors.white,
            fontSize: 14.0
        );
      print('Failed to pick image: $e');
    }
  }
}
