import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:savepy/app/payment_module/config.dart';
import 'package:savepy/app/payment_module/widgets/example_scaffold.dart';
import 'package:savepy/app/payment_module/widgets/loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Networking/url_provider.dart';
import '../../modules/payment_due/controller/payment_due_controller.dart';

class PaymentSheetScreenWithCustomFlow extends StatefulWidget {
  final String amount;//if you have multiple values add here
  final String planId;//if you have multiple values add here
  final String groupId;//if you have multiple values add here
  final String monthName;//if you have multiple values add here
  final int ind;//if you have multiple values add here
  PaymentSheetScreenWithCustomFlow(this.amount,this.planId,this.groupId,this.ind,this.monthName, {Key? key}): super(key: key);
  @override
  _PaymentSheetScreenState createState() => _PaymentSheetScreenState();
}

class _PaymentSheetScreenState extends State<PaymentSheetScreenWithCustomFlow> {
  PaymentDueController _paymentDueController = Get.put(PaymentDueController());
  int step = 0;
  late Dio _dio = Dio(BaseOptions(baseUrl:""));
  String pi="";
  String paymentForMonth="";
  getMonth(String mName)
  {
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
  @override
  Widget build(BuildContext context) {
    return ExampleScaffold(
      title: 'Make your payment here.',
      // tags: ['Custom Flow'],
      children: [
        Stepper(

          controlsBuilder: emptyControlBuilder,
          currentStep: step,
          steps: [
            Step(
              title: Text("Continue with payment for \$${widget.amount}"),
              content: LoadingButton(
                onPressed: initPaymentSheet,
                text: "Payment for \$${widget.amount}",
              ),
            ),
            Step(
              title: Text('Select payment method'),
              content: LoadingButton(
                onPressed: presentPaymentSheet,
                text: 'Select payment method',
              ),
            ),
            Step(
              title: Text('Confirm payment'),
              content: LoadingButton(
                onPressed: confirmPayment,
                text: 'Pay now',
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Future<void> makePayment() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token');
  //   String? email = prefs.getString('email');
  //   String? userId = prefs.getString('userId');
  //
  //   try{
  //     Map<String, String> mainheader = {
  //       // "Content-type": "application/x-www-form-urlencoded; charset=UTF-8",
  //       "Authorization": 'Bearer $token'
  //     };
  //     Options options = Options(
  //       headers: <String, String>{
  //         // 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
  //         'Authorization': 'Bearer $token'
  //       },
  //     );
  //     var now = new DateTime.now();
  //     var year;
  //
  //     if(widget.ind<=12)
  //       {
  //         year = now.year;
  //       }
  //     else{
  //       year = now.year+1;
  //     }
  //     Map data = {
  //       "transaction_id": pi.toString(),
  //       "email": email,
  //       "payment_amount": widget.amount.toString(),
  //       "plan_id": widget.planId.toString(),
  //       "group_id": widget.groupId.toString(),
  //       "payment_for_month": "$year-$paymentForMonth-01",
  //       // "deviceId": "",
  //       // "deviceType": Platform.isIOS ? '1' : '2'
  //     };
  //     var url = Uri.parse(UrlProvider.makePaymentUrl());
  //     http.Response response = await http.post(
  //         url,
  //         body: data,headers: mainheader
  //     );
  //     print(response);
  //     // Map data = {
  //     //   "transaction_id": pi.toString(),
  //     //   "email": email,
  //     //   "payment_amount": widget.amount.toString(),
  //     //   "plan_id": widget.planId.toString(),
  //     //   "group_id": widget.groupId.toString(),
  //     //   "payment_for_month": "2022-07-01",
  //     // };
  //     // var response = await _dio.post(UrlProvider.makePaymentUrl(),options: options,data: data);
  //     if(response.statusCode == 200){
  //       ///data successfully
  //       // var result = jsonDecode(response.data.toString());
  //       // print(result);
  //       // user_model =  User_Model.fromJson(result);
  //       // Fluttertoast.showToast(
  //       //     msg: "Payment done successfully",
  //       //     toastLength: Toast.LENGTH_SHORT,
  //       //     gravity: ToastGravity.CENTER,
  //       //     backgroundColor: Colors.black54,
  //       //     textColor: Colors.white,
  //       //     timeInSecForIosWeb: 1);
  //       // print(response);
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Payment succesfully completed'),
  //         ),
  //       );
  //       Navigator.pop(context);
  //     }else{
  //       ///error
  //     }
  //   }catch(e){
  //     // log('Error while getting data is $e');
  //     print('Error while getting data is $e');
  //   }finally{
  //
  //   }
  // }

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
    map['payment_amount'] = widget.amount.toString();
    map['plan_id'] = widget.planId.toString();
    map['email'] = email;
    map['group_id'] = widget.groupId.toString();
    map['payment_for_month'] = "$year-$paymentForMonth-01";

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

  Future<void> initPaymentSheet() async {
    try {
      // updatePayment();
      // 1. create payment intent on the server
      final data = await createTestPaymentSheet();
      pi=data['paymentIntent'];

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Enable custom flow
          billingDetails: BillingDetails(
            email: 'email@flutterstripe.com',
            phone: '+48888000888',
            address: Address(
              city: 'DElhi',
              country: 'US',
              line1: '1459  Circle Drive',
              line2: '',
              state: 'Texas',
              postalCode: '77063',

            ),

          ),
          customFlow: true,
          // Main params
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: data['paymentIntent'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['customer'],
          // Extra options
          applePay: PaymentSheetApplePay(
            merchantCountryCode: 'DE',
          ),
          googlePay: PaymentSheetGooglePay(merchantCountryCode: 'DE'),
          style: ThemeMode.dark,
        ),

      );
      setState(() {
        step = 1;
        print(data);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  Future<void> presentPaymentSheet() async {
    try {
      // 3. display the payment sheet.
      await Stripe.instance.presentPaymentSheet();

      setState(() {
        step = 2;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment option selected'),
        ),
      );
    } on Exception catch (e) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error from Stripe: ${e.error.localizedMessage}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unforeseen error: ${e}'),
          ),
        );
      }
    }
  }

  Future<void> confirmPayment() async {
    try {
      // 4. Confirm the payment sheet.

      await Stripe.instance.confirmPaymentSheetPayment();
      setState(() {
        step = 0;
        updatePayment();
        // makePayment();
      });


    } on Exception catch (e) {
      if (e is StripeException) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error from Stripe: ${e.error.localizedMessage}'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Unforeseen error: ${e}'),
          ),
        );
      }
    }
  }

  Future<Map<String, dynamic>> createTestPaymentSheet() async {
    final url = Uri.parse('$kApiUrl/payment-sheet');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'currency': 'usd',
        'amount': "${widget.amount}00",
        'payment_method_types': ['card'],
        'request_three_d_secure': 'any',
        "name": 'Ankit',
        "state": 'Delhi',
        "city": 'Delhi',
        "line1": '194  R.P.Bagh',
        "postal_code": '110007',
        "country": 'IN',
      }),
    );
    final body = json.decode(response.body);

    if (body['error'] != null) {
      throw Exception('Error code: ${body['error']}');
    }
    print("Ankit");
    print(body);
    return body;
  }
}

final ControlsWidgetBuilder emptyControlBuilder = (_, __) => Container();
