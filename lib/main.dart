import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/translations/translation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Config/coman_function.dart';
import 'login/login_page.dart';
import 'mainpage/main_page.dart';
import 'onbording_screen.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    //'This channel is used for important notifications.', // description
    importance: Importance.max,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        // Aquí debes agregar tus configuraciones de Firebase
        apiKey: "AIzaSyAFQGw7GsW6Fz_OcsEjZIDOgcbaCMKB41o",
        authDomain: "com.digicolmadotest.user",
        projectId: "digicolmado",
        storageBucket: "digicolmado.appspot.com",
        messagingSenderId: "959338980973",
        appId: "1:959338980973:android:1283c82d7e8ad0e7798164",
    ),
  );
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

  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static SharedPreferences? sharedPreferences;
  static int? providerid;
  static String? notifi;
  static String? tokke;
  static int? bord;

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeModel themeModel = Get.put(ThemeModel());
  GetStorage box = GetStorage();

  @override
  void initState() {
    super.initState();
    fire();
    showNotification();
    SharedPreferences.getInstance().then((value) {
      MyApp.bord = box.read("bord") ?? 1;
      MyApp.providerid = box.read('user_id');
      MyApp.notifi = box.read('u_status') ?? "0";
   
      MyApp.sharedPreferences = value;
      themeModel.toggleDarkMode1().then((value) {
        setState(() {
         
        });
      });
    });
  }

  fire() async {
    MyApp.tokke = 'AIzaSyAFQGw7GsW6Fz_OcsEjZIDOgcbaCMKB41o';
    //MyApp.tokke = await FirebaseMessaging.instance.getToken();

  }

  @override
  Widget build(BuildContext context) {
    Connections().conect();
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return Obx(() => GetMaterialApp(
            theme: themeModel.isdark.value
                ? ThemeModel.themeDataLight
                : ThemeModel.themeDataDark,
            debugShowCheckedModeBanner: false,
            locale: const Locale('es', 'RP'),
            translations: LocaleString(),
            fallbackLocale: const Locale('en', 'US'),
            scrollBehavior: MyBehavior(),
            home: MyApp.bord == 1 ? const OnBoarding() : const SplashScreen()));
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  final Key? key;

  const SplashScreen({this.key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loaddata();
  }

  loaddata() async {
    await Future.delayed(const Duration(seconds: 2));
    if (MyApp.providerid == null) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return const LoginPage();
        },
      ));
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) {
          return MainPages(0);
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        const Center(
            heightFactor: double.infinity,
            widthFactor: double.infinity,
            child: Image(image: AssetImage(icon_global.icspalash))),
        SizedBox(
          height: 12.h,
          width: 24.w,
          child: const Image(image: AssetImage(icon_global.icapplogo)),
        )
      ],
    ));
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

void showNotification() {
  flutterLocalNotificationsPlugin.show(
    0,
    "E-commerce",
    "e commerce?",
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id, channel.name,
        importance: Importance.high,
        // color: Colors.blue,
        playSound: true,
        icon: '@drawable/e_com',
        fullScreenIntent: true,
      ),
    ),
    payload: {
      "category_name": "1",
      "category_id": "2",
      "sub_type": "3",
      "item_id": "4",
      "type": "order",
      "order_id": "252"
    }.toString(),
  );
}
