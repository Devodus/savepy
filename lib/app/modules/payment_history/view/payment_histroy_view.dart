import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/UiElements/size_config.dart';
import 'package:savepy/app/UiElements/widget.dart';
import 'package:savepy/app/modules/add_installment_plan/view/add_installment_plan_view.dart';
import 'package:savepy/app/modules/add_member/view/add_member_view.dart';
import 'package:savepy/app/modules/group_detail/view/group_detail_view.dart';
import 'package:savepy/app/modules/group_list/controller/group_list_controller.dart';
import 'package:savepy/app/modules/payment_history/controller/payment_history_controller.dart';
import 'dart:math' as math;
import 'package:shimmer/shimmer.dart';

class PaymentHistoryView extends GetView<PaymentHistoryController>  {
  PaymentHistoryController _paymentHistoryController = Get.put(PaymentHistoryController());
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() => Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff004C88),elevation: 0,
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              {
                Scaffold.of(context).openDrawer();
              }
            }),
        title: const Text("Payment History"),
      ),
      body: RefreshIndicator(
        onRefresh: _paymentHistoryController.pullRefresh,
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
            width: context.width,
            height: context.height,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  // Padding(
                  //   padding: EdgeInsets.only(left: 24.0, right: 24, bottom: height * 0.01),
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.end,
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       textWidget('My Transactions', 15, FontWeight.bold, 'Lato',
                  //           0xff000000, '', false),
                  //
                  //     ],
                  //   ),
                  // ),
                  Visibility(
                    visible: _paymentHistoryController.isPullRefresh.value,
                      child: const RefreshProgressIndicator()
                  ),
                  if(_paymentHistoryController.isPaymentListLoading.value == 0)
                    Center(
                      child: Container(
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                            itemCount: 5,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Center(
                                child: Opacity(
                                  opacity: 0.8,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade50,
                                    loop: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                      child: Card(
                                        elevation: 1,
                                        child: ListTile(
                                          contentPadding: const EdgeInsets.fromLTRB(10,0,10,0),
                                          leading: CircleAvatar(
                                            radius: 15,
                                            backgroundColor:  Color((math.Random().nextDouble() * 0x004C88).toInt()).withOpacity(1.0),
                                            child: Center(
                                              child: textWidget(
                                                  '',
                                                  18,
                                                  FontWeight.bold,
                                                  'Lato',
                                                  0xffffffff,
                                                  '',
                                                  false),
                                            ),
                                            // AssetImage("assets/images/demoimage.png"),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  if(_paymentHistoryController.isPaymentListLoading.value == 2)
                    Container(
                      padding:const EdgeInsets.all(20),
                      height: height/3,
                      // decoration: const BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          const Spacer(),
                          SvgPicture.asset(
                            width: 40,
                            height: 40,
                            'assets/images/no_payment.svg',
                            color: const Color(0xff125AAB),
                          ),
                          Center(
                            child: textWidget(
                                "You didn't make any payments yet",
                                13,
                                FontWeight.w400,
                                'Lato',
                                0xff125AAB,
                                '',
                                false),
                          ),
                          // Center(
                          //   child: textWidget(
                          //       "Tap to add new member",
                          //       13,
                          //       FontWeight.w400,
                          //       'Lato',
                          //       0xff125AAB,
                          //       '',
                          //       false),
                          // ),
                        ],
                      ),
                    ),
                  if(_paymentHistoryController.isPaymentListLoading.value == 1)
                    Container(
                      child: _paymentHistoryController.paymentHistoryList.value.isNotEmpty?
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          itemCount: _paymentHistoryController.paymentHistoryList.value.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            // _groupDetailController.getPaymentHistoryList("${_groupDetailController.planList.value[index].fldGroupId}");
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(0,0,0,0),
                              // child: Row(
                              //   mainAxisAlignment:
                              //   MainAxisAlignment.spaceEvenly,
                              //   // crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     CircleAvatar(
                              //       radius: 30,
                              //       backgroundColor:  Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0),
                              //       child: textWidget(
                              //           '${_groupDetailController.planList.value[index].fldGroupName.toString()[0].toUpperCase()}',
                              //           24,
                              //           FontWeight.bold,
                              //           'Lato',
                              //           0xffffffff,
                              //           '',
                              //           false),
                              //       // AssetImage("assets/images/demoimage.png"),
                              //     ),
                              //
                              //     Container(
                              //       // height: height * 0.17,
                              //       // width: width * 0.3,
                              //       child: textWidget(
                              //           '${_groupDetailController.planList.value[index].fldGroupName}',
                              //           16,
                              //           FontWeight.normal,
                              //           'Lato',
                              //           0xffA8A8A8,
                              //           'c',
                              //           false),
                              //     ),
                              //
                              //   ],
                              // ),
                              child: Card(
                                elevation: 1,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(20,20,20,20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      !["", null, "null"].contains("${_paymentHistoryController.paymentHistoryList.value[index].groupName}")?

                                      textWidget("${_paymentHistoryController.paymentHistoryList.value[index].groupName}", 16, FontWeight.bold, 'Lato',
                                          0xff000000, '', false):
                                  Text(
                                    "This group doesn't exist anymore.\n Deleted by leader/admin.",
                                    style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0,fontFamily: "Lato",color: Colors.redAccent.shade400),
                                    // maxLines: 1,
                                    // overflow: TextOverflow.ellipsis,
                                  )
                                      ,
                                      SizedBox(
                                        height: height * 0.00,
                                      ),

                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                        child: Row(

                                          children: [
                                            textWidget("Amount:", 12, FontWeight.bold, 'Lato',
                                                0xff000000, '', false),
                                            const Spacer(),
                                            textWidget("${_paymentHistoryController.paymentHistoryList.value[index].fldAmount}", 12, FontWeight.bold, 'Lato',
                                                0xffC0C0C0, '', false),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Icon(Icons.monetization_on,color: HexColor(blue_color),size: 18,),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                        child: Row(

                                          children: [
                                            textWidget("Paid on:", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                            const Spacer(),
                                            textWidget("${_paymentHistoryController.paymentHistoryList.value[index].fldPaymentDate}", 12, FontWeight.bold, 'Lato',
                                                0xffC0C0C0, '', false),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                                            )
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            );
                          })
                          :
                      Container(
                        child: Center(
                            child: Column(
                              children: [
                                // SizedBox(
                                //   height: height * 0.1,
                                // ),
                                // SvgPicture.asset(
                                //   'assets/images/HeartOutLarge.svg',
                                // ),
                                // SizedBox(
                                //   height: 15,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 24.0, right: 24),
                                  child: Align(
                                    child: textWidget(
                                        'You didn\'t any payments yet',
                                        16,
                                        FontWeight.normal,
                                        'Lato',
                                        0xffA8A8A8,
                                        'c',
                                        false),
                                  ),
                                ),
                              ],
                            )
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }

  paymentHistoryListItem(int index) {
    return GestureDetector(
      onTap: (){
        // Get.off(ProductDetailView("${_paymentHistoryController.productList.value[index].productId}","${_paymentHistoryController.productList.value[index].esin}"));
      },
      child: Padding(
        padding: EdgeInsets.only(left: 14.0, right: 0, bottom: SizeConfig.screenHeight * 0.012),
        child: Container(
          // height: 317,
          color: Colors.white,
          width: SizeConfig.screenWidth * 0.45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              // textWidget(l[index + 1], 16, FontWeight.bold,
              //     'Lato', 0xff000000, '', false),
              const SizedBox(
                height: 5,
              ),

              ClipOval(
                child:Image.asset("assets/images/profile_pic.png",
                  height: 100,
                  width: 100,
                  fit:BoxFit.fitWidth,),
              ),
              Expanded(child: textWidget(
                  "${_paymentHistoryController.paymentHistoryList.value[index].groupName}",
                  18,
                  FontWeight.bold,
                  'Lato',
                  0xff929292,
                  '',
                  false),),

              const SizedBox(
                height: 5,
              ),

            ],
          ),
        ),
      ),
    );

  }
}
