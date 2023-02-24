import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:savepy/app/UiElements/widget.dart';
import 'package:savepy/app/modules/add_member/controller/add_member_controller.dart';
import 'package:savepy/app/modules/auth/views/login_view.dart';
import 'package:savepy/app/modules/group_detail/controller/group_detail_controller.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/UiElements/widget.dart';


class AddMemberView extends GetView<AddMemberController> {
  AddMemberController _addMemberController = Get.put(AddMemberController());

  @override
  Widget build(BuildContext context) {

    return Obx(() => Scaffold(
      backgroundColor: HexColor(light_grey),
      body: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: HexColor(blue_color),
                  ),
                  onPressed: () {
                    {
                      Navigator.pop(context);
                    }
                  }),
              ),

              Container(
                margin: const EdgeInsets.only(top: 60, left: 16, right: 16),
                width: context.width,
                height: context.height,
                child: SingleChildScrollView(
                  child: Form(
                    key: _addMemberController.addMemberFormKey,
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
                          "Add Member",
                          style: heading(),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _addMemberController.firstNameController,
                          keyboardType: TextInputType.text,
                          decoration: textFieldInputDecoration(
                              "First Name", Icon(Icons.perm_identity_rounded)),
                          validator: (value) {
                            return _addMemberController.validateFirstName(value!);
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _addMemberController.lastNameController,
                          keyboardType: TextInputType.text,
                          decoration: textFieldInputDecoration(
                              "Last Name", Icon(Icons.perm_identity_rounded)),
                          validator: (value) {
                            return _addMemberController.validateLastName(value!);
                          },
                        ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // IntlPhoneField(
                        //   controller: _addMemberController.mobileController,
                        //   decoration: InputDecoration(
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(5),
                        //       borderSide: const BorderSide(
                        //         width: 0,
                        //         style: BorderStyle.none,
                        //       ),
                        //     ),
                        //     // labelText: 'Mobile Number'.tr,
                        //     filled: true,
                        //     contentPadding: EdgeInsets.all(16),
                        //     fillColor: Colors.white,
                        //     // border: OutlineInputBorder(
                        //     //   borderSide: BorderSide(),
                        //     // ),
                        //   ),
                        //   onChanged: (phone) {
                        //     print(phone.completeNumber);
                        //     _addMemberController.phone = phone.completeNumber;
                        //   },
                        //   onCountryChanged: (country) {
                        //     print('Country changed to: ' + country.name);
                        //   },
                        // ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          obscureText: true,
                          controller: _addMemberController.passwordController,
                          keyboardType: TextInputType.text,
                          decoration: textFieldInputDecoration(
                              "Password", Icon(Icons.key)),
                          validator: (value) {
                            return _addMemberController.validatePassword(value!);
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _addMemberController.emailController,
                          keyboardType: TextInputType.text,
                          decoration: textFieldInputDecoration(
                              "Email Address", Icon(Icons.email_outlined)),
                          validator: (value) {
                            return _addMemberController.validateEmail(value!);
                          },
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        // Column(
                        //   children: [
                        //     CSCPicker(
                        //       ///Enable disable state dropdown [OPTIONAL PARAMETER]
                        //       showStates: true,
                        //
                        //       /// Enable disable city drop down [OPTIONAL PARAMETER]
                        //       showCities: true,
                        //
                        //       ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                        //       flagState: CountryFlag.DISABLE,
                        //
                        //       ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                        //       dropdownDecoration: BoxDecoration(
                        //           borderRadius:
                        //           BorderRadius.all(Radius.circular(10)),
                        //           color: Colors.white,
                        //           border: Border.all(
                        //               color: Colors.grey.shade300, width: 1)),
                        //
                        //       ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                        //       disabledDropdownDecoration: BoxDecoration(
                        //           borderRadius:
                        //           BorderRadius.all(Radius.circular(10)),
                        //           color: Colors.grey.shade300,
                        //           border: Border.all(
                        //               color: Colors.grey.shade300, width: 1)),
                        //
                        //       ///placeholders for dropdown search field
                        //       countrySearchPlaceholder: "Country",
                        //       stateSearchPlaceholder: "State",
                        //       citySearchPlaceholder: "City",
                        //
                        //       ///labels for dropdown
                        //       countryDropdownLabel: "Country",
                        //       stateDropdownLabel: "State",
                        //       cityDropdownLabel: "City",
                        //
                        //       ///Default Country
                        //       //defaultCountry: DefaultCountry.India,
                        //
                        //       ///Disable country dropdown (Note: use it with default country)
                        //       //disableCountry: true,
                        //
                        //       ///selected item style [OPTIONAL PARAMETER]
                        //       selectedItemStyle: const TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 14,
                        //       ),
                        //
                        //       ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                        //       dropdownHeadingStyle: const TextStyle(
                        //           color: Colors.black,
                        //           fontSize: 17,
                        //           fontWeight: FontWeight.bold),
                        //
                        //       ///DropdownDialog Item style [OPTIONAL PARAMETER]
                        //       dropdownItemStyle: const TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 14,
                        //       ),
                        //
                        //       ///Dialog box radius [OPTIONAL PARAMETER]
                        //       dropdownDialogRadius: 10.0,
                        //
                        //       ///Search bar radius [OPTIONAL PARAMETER]
                        //       searchBarRadius: 10.0,
                        //
                        //       ///triggers once country selected in dropdown
                        //       onCountryChanged: (value) {
                        //         _addMemberController.countryValue.value = value.toString();
                        //       },
                        //
                        //       ///triggers once state selected in dropdown
                        //       onStateChanged: (value) {
                        //         _addMemberController.stateValue.value = value.toString();
                        //       },
                        //
                        //       ///triggers once city selected in dropdown
                        //       onCityChanged: (value) {
                        //         _addMemberController.cityValue.value = value.toString();
                        //       },
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // TextFormField(
                        //   controller: _addMemberController.addressController,
                        //   keyboardType: TextInputType.text,
                        //   decoration: textFieldInputDecoration(
                        //       "Address", Icon(Icons.location_on_outlined)),
                        //   validator: (value) {
                        //     return _addMemberController.validateAddress(value!);
                        //   },
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // TextFormField(
                        //   controller: _addMemberController.accountNumberController,
                        //   keyboardType: TextInputType.text,
                        //   decoration: textFieldInputDecoration(
                        //       "Bank Account No", Icon(Icons.confirmation_num)),
                        //   validator: (value) {
                        //     return _addMemberController.validateAccountNumber(value!);
                        //   },
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // TextFormField(
                        //   controller: _addMemberController.bankNameController,
                        //   keyboardType: TextInputType.text,
                        //   decoration: textFieldInputDecoration(
                        //       "Bank Name", Icon(Icons.maps_home_work_outlined)),
                        //   validator: (value) {
                        //     return _addMemberController.validateBankName(value!);
                        //   },
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // TextFormField(
                        //   controller: _addMemberController.ifscCodeController,
                        //   keyboardType: TextInputType.text,
                        //   decoration: textFieldInputDecoration(
                        //       "Bank IFSC Code", Icon(Icons.code)),
                        //   validator: (value) {
                        //     return _addMemberController.validateIfscCode(value!);
                        //   },
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // TextFormField(
                        //   controller: _addMemberController.accountHolderNameController,
                        //   keyboardType: TextInputType.text,
                        //   decoration: textFieldInputDecoration(
                        //       "Account Holder Name", Icon(Icons.person)),
                        //   validator: (value) {
                        //     return _addMemberController.validateAccountHolderName(value!);
                        //   },
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // TextFormField(
                        //   controller: _addMemberController.bankAddressController,
                        //   keyboardType: TextInputType.text,
                        //   decoration: textFieldInputDecoration(
                        //       "Bank Address", Icon(Icons.add_location_outlined)),
                        //   validator: (value) {
                        //     return _addMemberController.validateBankAddress(value!);
                        //   },
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // TextFormField(
                        //   controller: _addMemberController.ssnController,
                        //   keyboardType: TextInputType.text,
                        //   decoration: textFieldInputDecoration(
                        //       "Bank SSN", Icon(Icons.numbers)),
                        //   validator: (value) {
                        //     return _addMemberController.validateSSN(value!);
                        //   },
                        // ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // Container(
                        //   color: Colors.white,
                        //   child: Row(
                        //     children: [
                        //       SizedBox(
                        //         width: MediaQuery.of(context).size.width / 1.5,
                        //         child: TextFormField(
                        //           controller: _addMemberController.docController,
                        //           minLines: 1,
                        //           enabled: false,
                        //           style: TextStyle(fontSize: 14),
                        //           decoration: textFieldInputDecoration(
                        //               "ID Proof", Icon(Icons.file_copy_outlined)),
                        //         ),
                        //       ),
                        //       Spacer(),
                        //       GestureDetector(
                        //         onTap: () async {
                        //           _addMemberController.selectImage();
                        //         },
                        //         child: Container(
                        //             height: 50,
                        //             width: 50,
                        //             color: HexColor(blue_color),
                        //             child: Icon(
                        //               Icons.cloud_upload_outlined,
                        //               color: Colors.white,
                        //             )),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        //
                        //
                        // // Row(
                        // //   children: [
                        // //     Obx(
                        // //           () => Material(
                        // //         child: Checkbox(
                        // //           value: _addMemberController.isTermCondition.value,
                        // //           onChanged: (value) {
                        // //             _addMemberController.isTermCondition.value = value!;
                        // //           },
                        // //         ),
                        // //       ),
                        // //     ),
                        // //     Container(
                        // //       width: 250,
                        // //       child: Text(
                        // //         style: TextStyle(fontSize: 12),
                        // //         'I have read and accept terms and conditions',
                        // //         overflow: TextOverflow.ellipsis,
                        // //       ),
                        // //     )
                        // //   ],
                        // // ),
                        // // Row(
                        // //   children: [
                        // //     Obx(
                        // //           () => Material(
                        // //         child: Checkbox(
                        // //           value: _addMemberController.isEighteenYear.value,
                        // //           onChanged: (value) {
                        // //             _addMemberController.isEighteenYear.value = value!;
                        // //           },
                        // //         ),
                        // //       ),
                        // //     ),
                        // //     Container(
                        // //       width: 250,
                        // //       child: Text(
                        // //         style: TextStyle(fontSize: 12),
                        // //         'Above 18 year',
                        // //         overflow: TextOverflow.ellipsis,
                        // //       ),
                        // //     )
                        // //   ],
                        // // ),
                        // // const SizedBox(
                        // //   height: 15,
                        // // ),
                        // // Row(
                        // //   children: [
                        // //     Container(
                        // //       height: 40,
                        // //       width: 140,
                        // //       child: GestureDetector(
                        // //         onTap: () {
                        // //           _addMemberController.userType.value = "1";
                        // //           _addMemberController.colorbtnInd.value = blue_color;
                        // //           _addMemberController.colorbtngroup.value = grey;
                        // //         },
                        // //         child: Obx(() => Container(
                        // //           padding: EdgeInsets.symmetric(vertical: 10),
                        // //           decoration: BoxDecoration(
                        // //               borderRadius: BorderRadius.circular(30),
                        // //               gradient: LinearGradient(
                        // //                 colors: [
                        // //                   HexColor(
                        // //                       _addMemberController.colorbtnInd.value),
                        // //                   HexColor(
                        // //                       _addMemberController.colorbtnInd.value),
                        // //                 ],
                        // //               )),
                        // //           width: MediaQuery.of(context).size.width,
                        // //           child: Text(
                        // //             "Individual",
                        // //             style: buttonTextStyle(),
                        // //             textAlign: TextAlign.center,
                        // //           ),
                        // //         )),
                        // //       ),
                        // //     ),
                        // //     Spacer(),
                        // //     Container(
                        // //       height: 40,
                        // //       width: 140,
                        // //       child: Obx(() => GestureDetector(
                        // //         onTap: () {
                        // //           _addMemberController.userType.value = "2";
                        // //           _addMemberController.colorbtngroup.value = blue_color;
                        // //           _addMemberController.colorbtnInd.value = grey;
                        // //         },
                        // //         child: Container(
                        // //           padding: EdgeInsets.symmetric(vertical: 10),
                        // //           decoration: BoxDecoration(
                        // //               borderRadius: BorderRadius.circular(30),
                        // //               gradient: LinearGradient(
                        // //                 colors: [
                        // //                   HexColor(
                        // //                       _addMemberController.colorbtngroup.value),
                        // //                   HexColor(
                        // //                       _addMemberController.colorbtngroup.value),
                        // //                 ],
                        // //               )),
                        // //           width: MediaQuery.of(context).size.width,
                        // //           child: Text(
                        // //             "Group",
                        // //             style: buttonTextStyle(),
                        // //             textAlign: TextAlign.center,
                        // //           ),
                        // //         ),
                        // //       )),
                        // //     ),
                        // //   ],
                        // // ),


                        const SizedBox(
                          height: 17,
                        ),
                        GestureDetector(
                          onTap: () {
                            _addMemberController.checkAddMember();
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
                                )
                            ),
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Add Member",
                              style: biggerTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text(
                        //       "You have an account? ",
                        //       style: TextStyle(
                        //         color: Colors.black,
                        //         fontSize: 17,
                        //       ),
                        //     ),
                        //     GestureDetector(
                        //       onTap: () {
                        //         Navigator.push( context,MaterialPageRoute(builder: (context) => LoginView()),
                        //         );
                        //         // Get.off(LoginView());
                        //       },
                        //       child: Text(
                        //         "Login",
                        //         style: TextStyle(
                        //           color: HexColor(blue_color),
                        //           fontSize: 17,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
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
                    visible: _addMemberController.isDataLoading.value,
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
