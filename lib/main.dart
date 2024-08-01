import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:taskitly/core/services/local-service/user.service.dart';
import 'package:taskitly/routes/router.dart';
import 'package:taskitly/styles/app_style.dart';

import 'constants/reuseables.dart';
import 'core/localization/app_localization.dart';
import 'core/services/local-service/navigation_services.dart';
import 'core/services/web-services/location.service.dart';
import 'core/services/web-services/notification-service.dart';
import 'firebase_options.dart';
import 'locator.dart';
import 'routes/routes.dart';

Map<Permission, PermissionStatus>? resultPermission;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initial firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Make app always in portrait
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );

  // Change status bar theme based on theme of app
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  // get environment data
  await dotenv.load(fileName: ".env");

  await GetStorage.init();

  // set up locator services
  await setupLocator();

  resultPermission = await [
    Permission.storage,
    Permission.notification,
  ].request();

  // try {
  //   if (Platform.isIOS || Platform.isAndroid ) {
  //     final RemoteMessage? remoteMessage =
  //     await FirebaseMessaging.instance.getInitialMessage();
  //     await NotificationHelper.initialize(flutterLocalNotificationsPlugin);
  //     FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  //   }
  // } catch (_) {}

  await Noti.initialize();
  // await Noti.initializeLocal();

  // Initialize and check login Status
  await locator<UserService>().initializer();
  await locator<LocationViewModel>().getCurrentPosition();

  runApp(const MyApp());
  (dynamic error, dynamic stack) {
    if (kDebugMode) {
      print(error);
      print(stack);
    }
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: ScreenUtilInit(
      //setup to fit into bigger screens
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(),
          navigatorKey: locator<NavigationService>().navigatorKey,
          scaffoldMessengerKey: locator<NavigationService>().snackBarKey,
          title: AppStrings.appName,
          // theme: Styles.themeData(context),
          onGenerateRoute: Routers.generateRoute,
          localizationsDelegates: const [
            AppLocalizationDelegate(),
            // GlobalMaterialLocalizations.delegate,
            // GlobalWidgetsLocalizations.delegate,
            // GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale(
              'en',
              '',
            ),
          ],
          navigatorObservers: [FlutterSmartDialog.observer],
          builder: FlutterSmartDialog.init(),
          initialRoute: splashscreenRoute,
        );
      },
    ));
  }
}
