import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:savepy/app/modules/auth/controllers/registration_controller.dart';
import 'package:savepy/app/modules/auth/views/login_view.dart';

import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/UiElements/widget.dart';
import '../controllers/login_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: HexColor(light_grey),
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60, left: 16, right: 16),
                  width: context.width,
                  height: context.height,
                  child: SingleChildScrollView(
                    child: Form(
                      key: controller.registrationFormKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          // const SizedBox(height: 50,),
                          Image.asset(
                            "assets/images/logo.png",
                            height: 100,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Create Account",
                            style: heading(),
                          ),

                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: controller.firstNameController,
                            keyboardType: TextInputType.text,
                            decoration: textFieldInputDecoration(
                                "First Name", Icon(Icons.perm_identity_rounded)),
                            validator: (value) {
                              return controller.validateFirstName(value!);
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: controller.lastNameController,
                            keyboardType: TextInputType.text,
                            decoration: textFieldInputDecoration(
                                "Last Name", Icon(Icons.perm_identity_rounded)),
                            validator: (value) {
                              return controller.validateLastName(value!);
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          IntlPhoneField(
                            controller: controller.mobileController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              // labelText: 'Mobile Number'.tr,
                              filled: true,
                              contentPadding: EdgeInsets.all(16),
                              fillColor: Colors.white,
                              // border: OutlineInputBorder(
                              //   borderSide: BorderSide(),
                              // ),
                            ),
                            onChanged: (phone) {
                              print(phone.completeNumber);
                              controller.phone = phone.completeNumber;
                            },
                            onCountryChanged: (country) {
                              print('Country changed to: ' + country.name);
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            obscureText: true,
                            controller: controller.passwordController,
                            keyboardType: TextInputType.text,
                            decoration: textFieldInputDecoration(
                                "Password", Icon(Icons.key)),
                            validator: (value) {
                              return controller.validatePassword(value!);
                            },
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.text,
                            decoration: textFieldInputDecoration(
                                "Email Address", Icon(Icons.email_outlined)),
                            validator: (value) {
                              return controller.validateEmail(value!);
                            },
                          ),

                          const SizedBox(
                            height: 15,
                          ),

                          Column(
                            children: [
                              CSCPicker(
                                ///Enable disable state dropdown [OPTIONAL PARAMETER]
                                showStates: true,

                                /// Enable disable city drop down [OPTIONAL PARAMETER]
                                showCities: true,

                                ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                                flagState: CountryFlag.DISABLE,

                                ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                                dropdownDecoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: 1)),

                                ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                                disabledDropdownDecoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                    color: Colors.grey.shade300,
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: 1)),

                                ///placeholders for dropdown search field
                                countrySearchPlaceholder: "Country",
                                stateSearchPlaceholder: "State",
                                citySearchPlaceholder: "City",

                                ///labels for dropdown
                                countryDropdownLabel: "Country",
                                stateDropdownLabel: "State",
                                cityDropdownLabel: "City",

                                ///Default Country
                                //defaultCountry: DefaultCountry.India,

                                ///Disable country dropdown (Note: use it with default country)
                                //disableCountry: true,

                                ///selected item style [OPTIONAL PARAMETER]
                                selectedItemStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),

                                ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                                dropdownHeadingStyle: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),

                                ///DropdownDialog Item style [OPTIONAL PARAMETER]
                                dropdownItemStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),

                                ///Dialog box radius [OPTIONAL PARAMETER]
                                dropdownDialogRadius: 10.0,

                                ///Search bar radius [OPTIONAL PARAMETER]
                                searchBarRadius: 10.0,

                                ///triggers once country selected in dropdown
                                onCountryChanged: (value) {
                                  controller.countryValue.value = value.toString();
                                },

                                ///triggers once state selected in dropdown
                                onStateChanged: (value) {
                                  controller.stateValue.value = value.toString();
                                },

                                ///triggers once city selected in dropdown
                                onCityChanged: (value) {
                                  controller.cityValue.value = value.toString();
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          // TextFormField(
                          //   controller: controller.addressController,
                          //   keyboardType: TextInputType.text,
                          //   decoration: textFieldInputDecoration(
                          //       "Address", Icon(Icons.location_on_outlined)),
                          //   validator: (value) {
                          //     return controller.validateAddress(value!);
                          //   },
                          // ),
                          // const SizedBox(
                          //   height: 15,
                          // ),
                          TextFormField(
                            controller: controller.accountNumberController,
                            keyboardType: TextInputType.text,
                            decoration: textFieldInputDecoration(
                                "Bank Account No", Icon(Icons.confirmation_num)),
                            validator: (value) {
                              return controller.validateAccountNumber(value!);
                            },
                          ),
                          // const SizedBox(
                          //   height: 15,
                          // ),
                          // TextFormField(
                          //   controller: controller.bankNameController,
                          //   keyboardType: TextInputType.text,
                          //   decoration: textFieldInputDecoration(
                          //       "Bank Name", Icon(Icons.maps_home_work_outlined)),
                          //   validator: (value) {
                          //     return controller.validateBankName(value!);
                          //   },
                          // ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: controller.ifscCodeController,
                            keyboardType: TextInputType.number,
                            decoration: textFieldInputDecoration(
                                "Routing Number", Icon(Icons.code)),
                            validator: (value) {
                              return controller.validateIfscCode(value!);
                            },
                          ),
                          // const SizedBox(
                          //   height: 15,
                          // ),
                          // TextFormField(
                          //   controller: controller.accountHolderNameController,
                          //   keyboardType: TextInputType.text,
                          //   decoration: textFieldInputDecoration(
                          //       "Account Holder Name", Icon(Icons.person)),
                          //   validator: (value) {
                          //     return controller.validateAccountHolderName(value!);
                          //   },
                          // ),
                          // const SizedBox(
                          //   height: 15,
                          // ),
                          // TextFormField(
                          //   controller: controller.bankAddressController,
                          //   keyboardType: TextInputType.text,
                          //   decoration: textFieldInputDecoration(
                          //       "Bank Address", Icon(Icons.add_location_outlined)),
                          //   validator: (value) {
                          //     return controller.validateBankAddress(value!);
                          //   },
                          // ),
                          // const SizedBox(
                          //   height: 15,
                          // ),
                          // TextFormField(
                          //   controller: controller.ssnController,
                          //   keyboardType: TextInputType.text,
                          //   decoration: textFieldInputDecoration(
                          //       "Bank SSN", Icon(Icons.numbers)),
                          //   validator: (value) {
                          //     return controller.validateSSN(value!);
                          //   },
                          // ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            color: Colors.white,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  child: TextFormField(
                                    controller: controller.docController,
                                    minLines: 1,
                                    enabled: false,
                                    style: TextStyle(fontSize: 14),
                                    decoration: textFieldInputDecoration(
                                        "ID Proof", Icon(Icons.file_copy_outlined)),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () async {
                                    controller.pickImage();
                                  },
                                  child: Container(
                                      height: 50,
                                      width: 50,
                                      color: HexColor(blue_color),
                                      child: Icon(
                                        Icons.cloud_upload_outlined,
                                        color: Colors.white,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Obx(
                                    () => Material(
                                  child: Checkbox(
                                    value: controller.isTermCondition.value,
                                    onChanged: (value) {
                                      controller.isTermCondition.value = value!;
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                width: 250,
                                child: Text(
                                  style: TextStyle(fontSize: 12),
                                  'I have read and accept terms and conditions',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Obx(
                                    () => Material(
                                  child: Checkbox(
                                    value: controller.isEighteenYear.value,
                                    onChanged: (value) {
                                      controller.isEighteenYear.value = value!;
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                width: 250,
                                child: Text(
                                  style: TextStyle(fontSize: 12),
                                  'Above 18 year',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 140,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.userType.value = "1";
                                    controller.colorbtnInd.value = blue_color;
                                    controller.colorbtngroup.value = grey;
                                  },
                                  child: Obx(() => Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: LinearGradient(
                                          colors: [
                                            HexColor(
                                                controller.colorbtnInd.value),
                                            HexColor(
                                                controller.colorbtnInd.value),
                                          ],
                                        )),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "Individual",
                                      style: buttonTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: 40,
                                width: 140,
                                child: Obx(() => GestureDetector(
                                  onTap: () {
                                    controller.userType.value = "2";
                                    controller.colorbtngroup.value = blue_color;
                                    controller.colorbtnInd.value = grey;
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        gradient: LinearGradient(
                                          colors: [
                                            HexColor(
                                                controller.colorbtngroup.value),
                                            HexColor(
                                                controller.colorbtngroup.value),
                                          ],
                                        )),
                                    width: MediaQuery.of(context).size.width,
                                    child: Text(
                                      "Group",
                                      style: buttonTextStyle(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.checkRegistration();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 13),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      HexColor(blue_color),
                                      HexColor(blue_color),
                                    ],
                                  )),
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "Register",
                                style: biggerTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 17,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "You have an account? ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push( context,MaterialPageRoute(builder: (context) => LoginView()),
                                  );
                                  // Get.off(LoginView());
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color: HexColor(blue_color),
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                AbsorbPointer(
                  child: Visibility(
                    visible: controller.isDataLoading.value,
                      child: Center(
                        child: CircularProgressIndicator(),
                  )
                  ),
                )
              ],
            )
          ),
        ));
  }
}
