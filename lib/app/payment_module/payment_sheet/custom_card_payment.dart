import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../Networking/url_provider.dart';
import '../../modules/payment_due/controller/payment_due_controller.dart';
import '../config.dart';
import '../widgets/example_scaffold.dart';
import '../widgets/loading_button.dart';
import '../widgets/response_card.dart';


class NoWebhookPaymentCardFormScreen extends StatefulWidget {
  final String amount;//if you have multiple values add here
  final String planId;//if you have multiple values add here
  final String groupId;
  final int ind;//if you have multiple values add here
  final String monthName;//if you have multiple values add here
  final int paymentYear;//if you have multiple values add here
 //if you have multiple values add here
  final int startingYear;//if you have multiple values add here
  final int startingMonth;//if you have multiple values add here
  NoWebhookPaymentCardFormScreen(this.amount,this.planId,this.groupId,this.ind,this.monthName,this.paymentYear,this.startingYear,this.startingMonth, {Key? key}): super(key: key);

  @override
  _NoWebhookPaymentCardFormScreenState createState() =>
      _NoWebhookPaymentCardFormScreenState();
}

class _NoWebhookPaymentCardFormScreenState
    extends State<NoWebhookPaymentCardFormScreen> {
  final controller = CardFormEditController();
  PaymentDueController _paymentDueController = Get.put(PaymentDueController());
  int step = 0;
  late Dio _dio = Dio(BaseOptions(baseUrl:""));
  String pi="";
  String paymentForMonth="";
  int yr =DateTime.now().year;
  int month =DateTime.now().month;
  int dif=0;
  int paymentYear=0;
  double newAmount=0;

  getMonth(String mName) {
    if(mName=="Jan")
    {
      paymentForMonth="01";
    }
    if(mName=="Feb")
    {
      paymentForMonth="02";
    }
    if(mName=="March")
    {
      paymentForMonth="03";
    }
    if(mName=="April")
    {
      paymentForMonth="04";
    }
    if(mName=="May")
    {
      paymentForMonth="05";
    }
    if(mName=="June")
    {
      paymentForMonth="06";
    }
    if(mName=="July")
    {
      paymentForMonth="07";
    }
    if(mName=="Aug")
    {
      paymentForMonth="08";
    }
    if(mName=="Sep")
    {
      paymentForMonth="09";
    }
    if(mName=="Oct")
    {
      paymentForMonth="10";
    }
    if(mName=="Nov")
    {
      paymentForMonth="11";
    }
    if(mName=="Dec")
    {
      paymentForMonth="12";
    }
  }
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
  @override
  void initState() {
    controller.addListener(update);
    getMonth(widget.monthName.toString());
    super.initState();
  }

  void update() => setState(() {});
  @override
  void dispose() {
    controller.removeListener(update);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dif = yr-widget.startingYear;
    paymentYear = widget.paymentYear;
    // print(dif);
    // print(widget.paymentYear);
    // print("$paymentYear-$paymentForMonth-01");
    final paymentDate = DateTime(paymentYear,int.parse(paymentForMonth), 01);
    final date2 = DateTime.now();
    final difference = daysBetween(paymentDate, date2);
    print(difference);
    if(difference>4)
      {
        newAmount=double.parse(widget.amount)+(double.parse(widget.amount)*0.05) ;
      }
    else{
      newAmount=double.parse(widget.amount);
    }
    return ExampleScaffold(
      title: 'Continue with payment for \$$newAmount',
      // tags: [''],
      padding: EdgeInsets.symmetric(horizontal: 16),
      children: [
        CardFormField(
          controller: controller,
          countryCode: 'US',
          style: CardFormStyle(
            borderColor: Platform.isIOS?Colors.blue:Colors.grey.shade200,
            backgroundColor: Platform.isIOS?Colors.grey:Colors.grey.shade200,
            textColor: Platform.isIOS?Colors.blue:Colors.black,
            fontSize: 24,
            placeholderColor: Colors.blue,
          ),
        ),
        LoadingButton(
          onPressed:
          controller.details.complete == true ? _handlePayPress : null,
          text: 'Pay',
        ),
        Divider(),
        // Padding(
        //   padding: EdgeInsets.all(8),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       OutlinedButton(
        //         onPressed: () => controller.focus(),
        //         child: Text('Focus'),
        //       ),
        //       SizedBox(width: 12),
        //       OutlinedButton(
        //         onPressed: () => controller.blur(),
        //         child: Text('Blur'),
        //       ),
        //     ],
        //   ),
        // ),
        Divider(),
        SizedBox(height: 20),
        // ResponseCard(
        //   response: controller.details.toJson().toString(),
        // )
      ],
    );
  }
  Future<void> updatePayment() async {
    getMonth(widget.monthName.toString());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var map = new Map<String, dynamic>();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');
    var now = new DateTime.now();
    var year;

    if(widget.ind<=12)
    {
      year = now.year;
    }
    else{
      year = now.year+1;
    }
    map['transaction_id'] = pi.toString();
    map['payment_amount'] = newAmount.toString();
    map['plan_id'] = widget.planId.toString();
    map['email'] = email;
    map['group_id'] = widget.groupId.toString();
    map['payment_for_month'] = "$paymentYear-$paymentForMonth-01";

    final response = await http.post(
      Uri.parse(UrlProvider.makePaymentUrl()),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
      body: map,
    );

    print("$year-$paymentForMonth-01");
    var decodedJson = json.decode(response.body);
    if(response.statusCode == 200){
      ///data successfully
      // var result = jsonDecode(response.data.toString());
      // print(result);
      // user_model =  User_Model.fromJson(result);
      // Fluttertoast.showToast(
      //     msg: "Payment done successfully",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     backgroundColor: Colors.black54,
      //     textColor: Colors.white,
      //     timeInSecForIosWeb: 1);
      // print(response);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment succesfully completed'),
        ),
      );
      Navigator.pop(context);
      _paymentDueController.getPaymentDueList();
      _paymentDueController.update();
    }else{
      ///error
    }
  }
  Future<void> _handlePayPress() async {
    if (!controller.details.complete) {
      return;
    }

    try {
      // 1. Gather customer billing information (ex. email)

      final billingDetails = BillingDetails(
        email: 'email@stripe.com',
        phone: '+48888000888',
        address: Address(
          city: 'Houston',
          country: 'US',
          line1: '1459  Circle Drive',
          line2: '',
          state: 'Texas',
          postalCode: '77063',
        ),
      ); // mocked data for tests

      // 2. Create payment method
      final paymentMethod = await Stripe.instance.createPaymentMethod(
          params: PaymentMethodParams.card(
            paymentMethodData: PaymentMethodData(
              billingDetails: billingDetails,

            ),
          ));

      // 3. call API to create PaymentIntent
      final paymentIntentResult = await callNoWebhookPayEndpointMethodId(
        useStripeSdk: true,
        paymentMethodId: paymentMethod.id,
        currency: 'usd', // mocked data
        items: ['id-1'],
        damount: int.parse("300"),
      );

      if (paymentIntentResult['error'] != null) {
        // Error during creating or confirming Intent
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${paymentIntentResult['error']}')));
        return;
      }

      if (paymentIntentResult['clientSecret'] != null &&
          paymentIntentResult['requiresAction'] == null) {
        // Payment succedeed

        updatePayment();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
            Text('Success!: The payment was confirmed successfully!')));
        return;
      }

      if (paymentIntentResult['clientSecret'] != null &&
          paymentIntentResult['requiresAction'] == true) {
        // 4. if payment requires action calling handleNextAction
        final paymentIntent = await Stripe.instance
            .handleNextAction(paymentIntentResult['clientSecret']);

        // todo handle error
        /*if (cardActionError) {
        Alert.alert(
        `Error code: ${cardActionError.code}`,
        cardActionError.message
        );
      } else*/

        if (paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation) {
          // 5. Call API to confirm intent
          await confirmIntent(paymentIntent.id);
        } else {
          // Payment succedeed
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Error: ${paymentIntentResult['error']}')));
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
      rethrow;
    }
  }

  Future<void> confirmIntent(String paymentIntentId) async {
    final result = await callNoWebhookPayEndpointIntentId(
        paymentIntentId: paymentIntentId);
    if (result['error'] != null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${result['error']}')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Success!: The payment was confirmed successfully!')));
    }
  }

  Future<Map<String, dynamic>> callNoWebhookPayEndpointIntentId({required String paymentIntentId,}) async {
    final url = Uri.parse('$kApiUrl/charge-card-off-session');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'paymentIntentId': paymentIntentId}),
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> callNoWebhookPayEndpointMethodId({
    required bool useStripeSdk,
    required String paymentMethodId,
    required String currency,
    required int damount,
    List<String>? items,
  }) async {
    final url = Uri.parse('$kApiUrl/pay-without-webhooks');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'damount': "${newAmount}00",
        'useStripeSdk': useStripeSdk,
        'paymentMethodId': paymentMethodId,
        'currency': currency,
        'items': items
      }),
    );
    return json.decode(response.body);
  }
}