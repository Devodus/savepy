import 'package:flutter/foundation.dart';

// If you are using a real device to test the integration replace this url
// with the endpoint of your test server (it usually should be the IP of your computer)
final kApiUrl = defaultTargetPlatform == TargetPlatform.android
    ? 'http://122.160.48.132:4242'
    : 'http://122.160.48.132:4242';
// final kApiUrl = defaultTargetPlatform == TargetPlatform.android
//     ? 'http://10.0.2.2:4242'
//     : 'http://localhost:4242';