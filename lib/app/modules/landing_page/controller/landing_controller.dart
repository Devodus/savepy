import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:savepy/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPageController extends GetxController {
  var tabIndex = 0.obs;
  var isLoggedIn =false.obs;
  Rx<ConnectivityResult> connectionStatus = ConnectivityResult.none.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
  Future<void> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = prefs.getBool('isLogin') ?? false;
    isLoggedIn.value=prefs.getBool('isLogin') ?? false;
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      // developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) {
    //   return Future.value(null);
    // }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
      connectionStatus.value = result;
  }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Connectivity example app'),
//       ),
//       body: Center(
//           child: Text('Connection Status: ${_connectionStatus.toString()}')),
//     );
//   }
// }

  @override
  void onInit() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.onInit();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
  @override
  void onClose() {


  }
}