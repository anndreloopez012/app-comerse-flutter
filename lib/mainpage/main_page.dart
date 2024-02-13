import 'dart:convert';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/My%20order%20list/my_orddr_list.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/My%20order%20list/order_details.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/my%20account/my_account.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/my_cart/my_cart.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/watchlist/watch_list.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Config/all_icon.dart';

import '../Config/global_data.dart';
import '../Config/thememodel.dart';
import '../login/login_page.dart';
import '../main.dart';
import 'botomsheet/home_page/home_page.dart';

// ignore: must_be_immutable
class MainPages extends StatefulWidget {
  int? ind;

  MainPages(this.ind, {super.key});

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  GetStorage box = GetStorage();

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are_you_sure'.tr),
            content: Text('Do_you_want_to_exit_an_App'.tr),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child:
                    Text('No'.tr, style: TextStyle(color: GlobalData.fullblk)),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child:
                    Text('Yes'.tr, style: TextStyle(color: GlobalData.fullblk)),
              ),
            ],
          ),
        )) ??
        false;
  }

  PageController pageController = PageController();

  Future<void> opTapped(int index) async {
    widget.ind = index;
    if (box.read("user_id") != null || index == 0 || index == 4) {
      setState(() {
        widget.ind = index;
      });
    } else if (index == 1 && box.read("user_id") == null ||
        index == 2 && box.read("user_id") == null ||
        index == 3 && box.read("user_id") == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
          (route) => false);
    }
  }

  List pages = const [
    HomePage(),
    WatchListPage(),
    MyCartPage(),
    MyOrderList(),
    MyAccountPage(),
  ];

  Future<dynamic> onSelectNotification(payload) async {
    if (mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MainPages(3),
        ),
      );
    }
  }

  notificationss() async {
    FirebaseMessaging.instance;
    var initializationsettingsAndroid =
        const AndroidInitializationSettings('@drawable/icnotification');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationsettingsAndroid);
    FlutterLocalNotificationsPlugin().initialize(
      initializationSettings,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onSelectNotification);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        String action = jsonEncode(message.data);
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
                icon: '@drawable/e_com',
                channel.id,
                channel.name,
              ),
              iOS: const DarwinNotificationDetails()),
          payload: action,
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;
        if (notification != null && android != null) {
          Get.to(() => OrderDetailsPage("171"));
          Loader.showErroDialog(description: "sfggfgdfdsd");
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: Text(notification.title!),
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification.body!),
                      ],
                    ),
                  ));
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: GetBuilder<ThemeModel>(builder: (context) {
        return SafeArea(
          child: Scaffold(
              body: pages[widget.ind!],
              bottomNavigationBar: GetBuilder<ThemeModel>(
                builder: (controller) {
                  return BottomNavigationBar(
                    elevation: 0,
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          icon_global.ichome,
                          color: themeModel.isdark.value
                              ? GlobalData.darkgray
                              : GlobalData.fullwhite,
                        ),
                        label: '',
                        activeIcon: SvgPicture.asset(
                          icon_global.ichome,
                          color: themeModel.isdark.value
                              ? GlobalData.fullblk
                              : GlobalData.fullwhite,
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          icon_global.icheartmenu,
                          color: themeModel.isdark.value
                              ? GlobalData.darkgray
                              : GlobalData.fullwhite,
                        ),
                        label: '',
                        activeIcon: SvgPicture.asset(
                          icon_global.icheartmenu,
                          color: themeModel.isdark.value
                              ? GlobalData.fullblk
                              : GlobalData.fullwhite,
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          icon_global.iccart,
                          color: themeModel.isdark.value
                              ? GlobalData.darkgray
                              : GlobalData.fullwhite,
                        ),
                        label: '',
                        activeIcon: SvgPicture.asset(
                          icon_global.iccart,
                          color: themeModel.isdark.value
                              ? GlobalData.fullblk
                              : GlobalData.fullwhite,
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          icon_global.icfile,
                          color: themeModel.isdark.value
                              ? GlobalData.darkgray
                              : GlobalData.fullwhite,
                        ),
                        label: '',
                        activeIcon: SvgPicture.asset(
                          icon_global.icfile,
                          color: themeModel.isdark.value
                              ? GlobalData.fullblk
                              : GlobalData.fullwhite,
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          icon_global.icman,
                          color: themeModel.isdark.value
                              ? GlobalData.darkgray
                              : GlobalData.fullwhite,
                        ),
                        label: '',
                        activeIcon: SvgPicture.asset(
                          icon_global.icman,
                          color: themeModel.isdark.value
                              ? GlobalData.fullblk
                              : GlobalData.fullwhite,
                        ),
                      ),
                    ],
                    currentIndex: widget.ind!,
                    type: BottomNavigationBarType.fixed,
                    unselectedIconTheme: const IconThemeData(
                      size: 25,
                    ),
                    selectedIconTheme: const IconThemeData(
                      size: 25,
                    ),
                    onTap: opTapped,
                    showUnselectedLabels: false,
                    selectedFontSize: 0,
                    unselectedFontSize: 0,
                  );
                },
              )),
        );
      }),
    );
  }
}
