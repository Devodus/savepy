import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/UiElements/widget.dart';
import 'package:savepy/app/modules/add_installment_plan/controller/add_installment_plan_controller.dart';

class AddInstallmentPlanView extends GetView<AddInstallmentPlanController> {
  final String? lastPage;
  final String? groupId;
  AddInstallmentPlanView(this.lastPage,this.groupId);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    AddInstallmentPlanController _addInstallmentPlanController = Get.put(AddInstallmentPlanController(groupId));
    return Obx(() => Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              {
                Navigator.pop(context);
              }
            }),
        backgroundColor: HexColor(blue_color),
        centerTitle: true,
        title: textWidget('Create Installment Plan', 18, FontWeight.bold, 'Lato',
            0xffffffff, '', false),
        // actions: [
        //   IconButton(
        //       icon: SvgPicture.asset(
        //         'assets/images/search.svg',
        //         fit: BoxFit.fitHeight,
        //         color: Colors.black,
        //       ),
        //       onPressed: () {
        //
        //       }),
        //   IconButton(
        //       icon: SvgPicture.asset(
        //         'assets/images/bell.svg',
        //         fit: BoxFit.fitHeight,
        //         color: Colors.black,
        //       ),
        //       onPressed: () {
        //         // Get.to(NotificationView());
        //       }),
        // ],
      ),
      // appBar: appBarMain(
      //     context, "Create Installment Plan", true, Icon(Icons.add_box), false,""),
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
                    key: _addInstallmentPlanController.addInstallmentPlanFormKey,
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
                          "Add Installment Plan",
                          style: heading(),
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _addInstallmentPlanController.planNameController,
                          keyboardType: TextInputType.text,
                          decoration: textFieldInputDecoration(
                              "Plan Name", Icon(Icons.abc_outlined)),
                          validator: (value) {
                            return _addInstallmentPlanController.validatePlanName(value!);
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: _addInstallmentPlanController.amountController,
                          keyboardType: TextInputType.number,
                          decoration: textFieldInputDecoration(
                              "Amount", Icon(Icons.attach_money)),
                          validator: (value) {
                            return _addInstallmentPlanController.validateAmount(value!);
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Obx(() => InkWell(
                            onTap: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  onChanged: (date) {
                                    // print('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
                                    _addInstallmentPlanController.setDate(date.toString());
                                    // _addInstallmentPlanController.today.value = date.toString();
                                  }, onConfirm: (date) {
                                    // print('confirm $date');
                                    _addInstallmentPlanController.setDate(date.toString());
                                    // _addInstallmentPlanController.today.value =
                                    //     date.toString();
                                  },
                                  currentTime: DateTime.now(),
                                  // maxTime: DateTime.now(),
                                  minTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius:
                                const BorderRadius.all(
                                    Radius.circular(5)),

                              ),
                              width: width,
                              padding: const EdgeInsets.all(16),

                              child: Text(
                                _addInstallmentPlanController.selectedDate.value,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.0),
                              ),
                              // margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 5.0),
                            ),
                          )),
                        ),
                        // TextFormField(
                        //   // obscureText: true,
                        //   controller: _addInstallmentPlanController.durationController,
                        //   keyboardType: TextInputType.number,
                        //   decoration: textFieldInputDecoration(
                        //       "Start Date", Icon(Icons.calendar_today_rounded)),
                        //   validator: (value) {
                        //     return _addInstallmentPlanController.validateDuration(value!);
                        //   },
                        // ),
                        const SizedBox(
                          height: 50,
                        ),
                        GestureDetector(
                          onTap: () {
                            if(_addInstallmentPlanController.selectedDate.value=="Date")
                              {
                                Fluttertoast.showToast(
                                    msg: "Please select starting date.",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: Colors.black54,
                                    textColor: Colors.white,
                                    timeInSecForIosWeb: 1);
                              }
                            else
                              {
                                Get.defaultDialog(
                                  title: "Create new plan",
                                  textCancel: "Cancel",
                                  textConfirm: "Confirm",
                                  onCancel: (){
                                    // navigator.pop();
                                  },
                                  content: Column(
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipOval(
                                        child:Image.asset("assets/images/logo.png",
                                          height: 80,
                                          width: 80,
                                          fit:BoxFit.fitWidth,),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                        'Note: Once you create a plan you will not be able to add any members',
                                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  buttonColor: Color(0xff004C88),
                                  confirmTextColor: Colors.white,
                                  cancelTextColor: Color(0xff004C88),
                                  onConfirm: (){

                                    _addInstallmentPlanController.checkAddInstallmentPlan(groupId!);
                                    Get.back();
                                    // _addInstallmentPlanController.amountController.clear();
                                    // _addInstallmentPlanController.planNameController.clear();
                                    // _addInstallmentPlanController.selectedDate.value="Date";
                                  },
                                  // middleText: "Are you sure you want to logout?"

                                );
                              }
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
                              "Create",
                              style: biggerTextStyle(),
                              textAlign: TextAlign.center,
                            ),
                          ),
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
                    visible: _addInstallmentPlanController.isDataLoading.value,
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
