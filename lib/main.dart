import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:savepy/app/UiElements/size_config.dart';
import 'package:savepy/app/modules/auth/bindings/registration_binding.dart';
import 'package:savepy/app/payment_module/.env.dart';
import 'package:savepy/splash_screen.dart';
import 'app/routes/app_pages.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}
Future<void> main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = '';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  // runApp(
  // DevicePreview(
  //   enabled: !kReleaseMode,
  //   builder: (context) => MyApp(), // Wrap your app
  // ),
  // );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  // await Firebase.initializeApp();
  // await GetStorage.init();
  //SharedPreferences.setMockInitialValues({});
  // Application.storageService = await LocalStorageService.getInstance();
  // Application.restApiService = await RestApiService.getInstance();
  runApp(MyApp());
}
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  // 'This channel is used for important notifications.', // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var initializationSettingsAndroid =
    new AndroidInitializationSettings('ic_launcher');
    var initialzationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
    InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                color: Colors.blue,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: "@mipmap/ic_launcher",
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return OverlaySupport(
              child: GetMaterialApp(
                // translations: LocaleString(),
                // locale: lang=="de"?Locale('de','DE'):lang=="fr"?Locale('fr','FR'):Locale('en','EN'),
                // fallbackLocale: Locale('en','US'),
                debugShowCheckedModeBanner: false,
                title: 'SavePy',
                defaultTransition: Transition.zoom,
                initialBinding: RegistrationBinding(),
                initialRoute: AppPages.INITIAL,
                getPages: AppPages.routes,
                theme: ThemeData(fontFamily: "Lato"),
                // theme: Themes.light,
                // darkTheme: Themes.dark,
                // themeMode: ThemeService().theme,
                home: SplashView(), //TestingPage//NewListingView//CheckInOutView//SplashView
              ),
            );
          },
        );
      },
    );
  }
}
// void main() {
//   runApp(
//     GetMaterialApp(
//       title: "Savepy",
//       initialRoute: AppPages.INITIAL,
//       getPages: AppPages.routes,
//       debugShowCheckedModeBanner: false,
//     ),
//   );
// }

