import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/UiElements/size_config.dart';
import 'package:savepy/app/UiElements/widget.dart';
import 'package:savepy/app/modules/add_installment_plan/view/add_installment_plan_view.dart';
import 'package:savepy/app/modules/add_member/view/add_member_view.dart';
import 'package:savepy/app/modules/group_detail/view/group_detail_view.dart';
import 'package:savepy/app/modules/group_list/controller/group_list_controller.dart';
import 'package:savepy/app/modules/payment_due/controller/payment_due_controller.dart';
import 'package:savepy/app/modules/payment_history/controller/payment_history_controller.dart';
import 'dart:math' as math;
import 'package:shimmer/shimmer.dart';
import '../../../payment_module/payment_sheet/custom_card_payment.dart';
import '../../../payment_module/payment_sheet/payment_sheet_screen.dart';
import '../../../payment_module/payment_sheet/payment_sheet_screen_custom_flow.dart';

class MonthList{
  String name;
  bool color;
  int ind;
  int year;
  MonthList({required this.name, required this.color, required this.ind, required this.year});
}

class PaymentDueView extends GetView<PaymentDueController>  {
  PaymentDueController _paymentDueController = Get.put(PaymentDueController());
  int difference=0;
  int yr=0;
  int mon=0;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Obx(() => Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff004C88),elevation: 0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              {
                Scaffold.of(context).openDrawer();
              }
            }),
        title: const Text("Payment Due"),
      ),
      body: RefreshIndicator(
        onRefresh: _paymentDueController.pullRefresh,
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 30, left: 10, right: 10),
            width: context.width,
            height: context.height,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
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
                      visible: _paymentDueController.isPullRefresh.value,
                      child: RefreshProgressIndicator()
                  ),
                  if(_paymentDueController.isPaymentListLoading.value == 0)
                    Center(
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
                  if(_paymentDueController.isPaymentListLoading.value == 2)
                    Container(
                      padding:EdgeInsets.all(20),
                      height: height/3,
                      // decoration: const BoxDecoration(
                      //     color: Colors.white,
                      //     borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Spacer(),
                          SvgPicture.asset(
                            width: 40,
                            height: 40,
                            'assets/images/no_payment.svg',
                            color: Color(0xff125AAB),
                          ),
                          Center(
                            child: textWidget(
                                "You don't have any payments due",
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
                  if(_paymentDueController.isPaymentListLoading.value == 1)
                    Container(
                      child: _paymentDueController.paymentDueList.value.isNotEmpty?
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          itemCount: _paymentDueController.paymentDueList.value.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            int diff=0;
                            double perc=0.0;
                            List<MonthList> monthList = [
                              // BubbleData(sender: 'Not Me', text: 'Hey Mi', isMe: false),
                              // BubbleData(sender: 'Not Me', text: 'What\'s new?', isMe: false)
                            ];

                            if(_paymentDueController.paymentDueList[index].planData!.isNotEmpty)
                            {
                              DateTime dt = DateTime.parse(_paymentDueController.paymentDueList[index].planData![0].fldStartDate.toString());
                              int a =dt.month;
                              yr =dt.year;
                              // print("yr");
                              // print(yr);
                              int b =DateTime.now().month;
                              int thisYear =DateTime.now().year;
                              difference = b-a+1;
                              diff = int.parse(_paymentDueController.paymentDueList[index].planData![0].fldDuration.toString())-_paymentDueController.paymentDueList[index].paymentData!.length;
                              perc= double.parse(_paymentDueController.paymentDueList[index].paymentData!.length.toString())/double.parse(_paymentDueController.paymentDueList[index].planData![0].fldDuration.toString());


                              int i=a;
                              int d=_paymentDueController.paymentDueList[index].paymentData!.length;
                              // print(a);
                              // print(int.parse(_paymentDueController.paymentDueList[index].planData![0].fldDuration.toString()));
                              for(int j=1;j<=int.parse(_paymentDueController.paymentDueList[index].planData![0].fldDuration.toString());j++){

                                String mName="";
                                if(i==1||(i%13)==0)
                                {
                                  mName="Jan";
                                }
                                if(i==2||(i%14)==0)
                                {
                                  mName="Feb";
                                }
                                if(i==3||(i%15)==0)
                                {
                                  mName="March";
                                }
                                if(i==4||(i%16)==0)
                                {
                                  mName="April";
                                }
                                if(i==5||(i%17)==0)
                                {
                                  mName="May";
                                }
                                if(i==6||(i%18)==0)
                                {
                                  mName="June";
                                }
                                if(i==7||(i%19)==0)
                                {
                                  mName="July";
                                }
                                if(i==8||(i%20)==0)
                                {
                                  mName="Aug";
                                }
                                if(i==9||(i%21)==0)
                                {
                                  mName="Sep";
                                }
                                if(i==10||(i%22)==0)
                                {
                                  mName="Oct";
                                }
                                if(i==11||(i%23)==0)
                                {
                                  mName="Nov";
                                }
                                if(i==12||(i%24)==0)
                                {
                                  mName="Dec";
                                }
                                bool clr=false;
                                if(d>0)
                                {
                                  clr=true;
                                }
                                else{
                                  clr=false;
                                }

                                if(i<12)
                                  {
                                    monthList.add(MonthList(name: mName, color: clr,ind: i,year: yr));
                                  }
                                else if(i<24)
                                  {
                                    monthList.add(MonthList(name: mName, color: clr,ind: i,year: yr+1));
                                  }
                                else if(i<36)
                                  {
                                    monthList.add(MonthList(name: mName, color: clr,ind: i,year: yr+2));
                                  }
                                else if(i<48)
                                  {
                                    monthList.add(MonthList(name: mName, color: clr,ind: i,year: yr+3));
                                  }
                                else if(i<60)
                                  {
                                    monthList.add(MonthList(name: mName, color: clr,ind: i,year: yr+4));
                                  }




                                i++;
                                d--;
                              }
                            }
                            return diff>0?
                            // _groupDetailController.getPaymentHistoryList("${_groupDetailController.planList.value[index].fldGroupId}");
                            Padding(
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

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                              flex:7,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  textWidget("${_paymentDueController.paymentDueList.value[index].fldGroupName}".toTitleCase(), 20, FontWeight.bold, 'Lato',
                                                      0xff000000, '', false),
                                                  const SizedBox(height: 10,),
                                                  textWidget(_paymentDueController.paymentDueList.value[index].planData![0].fldPlanName.toString().toTitleCase(), 15, FontWeight.w500, 'Lato',
                                                      0xff000000, '', false),
                                                ],
                                              )
                                          ),

                                          // Expanded(
                                          //   flex:3,
                                          //     child: CircularPercentIndicator(
                                          //       radius: 40.0,
                                          //       lineWidth: 10.0,
                                          //       animation: true,
                                          //       percent: perc,
                                          //       center: Text(
                                          //         "${_paymentDueController.paymentDueList[index].paymentData!.length}/${_paymentDueController.paymentDueList[index].planData![0].fldDuration}",
                                          //         style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13.0),
                                          //       ),
                                          //       // footer: new Text(
                                          //       //   "Sales this week",
                                          //       //   style:
                                          //       //   new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
                                          //       // ),
                                          //       circularStrokeCap: CircularStrokeCap.round,
                                          //       progressColor: Colors.red.shade400,
                                          //     ),
                                          // ),
                                          Expanded(
                                            flex:3,
                                            child: CircularPercentIndicator(
                                              radius: 40.0,
                                              animation: true,
                                              animationDuration: 1200,
                                              lineWidth: 10.0,
                                              percent: perc,
                                              center: Text(
                                                "${_paymentDueController.paymentDueList[index].paymentData!.length}/${_paymentDueController.paymentDueList[index].planData![0].fldDuration}",
                                                style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13.0),
                                              ),
                                              circularStrokeCap: CircularStrokeCap.butt,
                                              backgroundColor: Colors.redAccent.shade200,
                                              progressColor: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
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
                                            textWidget("${_paymentDueController.paymentDueList.value[index].planData![0].fldDueAmount}", 12, FontWeight.bold, 'Lato',
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
                                      _paymentDueController.paymentDueList.value[index].paymentData!.length==0?
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                        child: Row(
                                          children: [
                                            textWidget("No previous payment received.", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                          ],
                                        ),
                                      ):
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                        child: Row(

                                          children: [
                                            textWidget("Last Payment on:", 12, FontWeight.bold, 'Lato', 0xff000000, '', false),
                                            const Spacer(),
                                            textWidget(_paymentDueController.paymentDueList.value[index].paymentData!.last.fldPaymentDate.toString(), 12, FontWeight.bold, 'Lato',
                                                0xffC0C0C0, '', false),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Icon(Icons.calendar_today_rounded,color: HexColor(blue_color),size: 18,),
                                            )
                                          ],
                                        ),
                                      ),
                                      Wrap(
                                        spacing: 10,
                                        children: <Widget>[
                                          for(var item in monthList)
                                            ChoiceChip(
                                              label: Text(item.name),
                                              selected: true,
                                              selectedColor: item.color?Colors.green.shade300:Colors.redAccent.shade200,
                                              onSelected: (bool selected) {
                                                DateTime dt = DateTime.parse(_paymentDueController.paymentDueList[index].planData![0].fldStartDate.toString());
                                                // int a =dt.month;
                                                yr =dt.year;
                                                mon =dt.month;
                                                // print("yr");
                                                // print(yr);
                                                if(!item.color)
                                                {
                                                  // Navigator.of(
                                                  //     context)
                                                  //     .push(
                                                  //   MaterialPageRoute(
                                                  //     builder: (BuildContext context) =>
                                                  //         PaymentSheetScreen(),
                                                  //   ),
                                                  // );
                                                  // print(_paymentDueController.paymentDueList.value[index].planData![0].fldPlanId.toString());
                                                  // print(_paymentDueController.paymentDueList.value[index].fldGroupId.toString());
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) =>
                                                          NoWebhookPaymentCardFormScreen(
                                                              _paymentDueController.paymentDueList.value[index].planData![0].fldDueAmount.toString(),
                                                              _paymentDueController.paymentDueList.value[index].planData![0].fldPlanId.toString(),
                                                              _paymentDueController.paymentDueList.value[index].fldGroupId.toString(),item.ind,item.name,item.year,yr,mon),
                                                    ),
                                                  );
                                                }
                                              },
                                              backgroundColor: Colors.green,
                                              labelStyle: TextStyle(color: Colors.white),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ):Container();
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
                  // _buildChoiceChips(),

                  // Wrap(
                  //   spacing: 6.0,
                  //   runSpacing: 6.0,
                  //   children: <Widget>[
                  //     _buildChoiceChips(),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
  Widget _buildChoiceChips() {
    return Container(
      height: 50,
      child: ListView.builder(
        itemCount: _paymentDueController.choices.length,
        itemBuilder: (BuildContext context, int index) {
          return ChoiceChip(
            label: Text(_paymentDueController.choices[index]),
            selected: true,
            selectedColor: Colors.red,
            onSelected: (bool selected) {
            },
            backgroundColor: Colors.green,
            labelStyle: TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }
  paymentHistoryListItem(int index) {
    return GestureDetector(
      onTap: (){
        // Get.off(ProductDetailView("${_paymentDueController.productList.value[index].productId}","${_paymentDueController.productList.value[index].esin}"));
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
                  "${_paymentDueController.paymentDueList.value[index].fldGroupName}",
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
