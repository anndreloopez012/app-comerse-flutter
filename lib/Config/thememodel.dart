import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



class ThemeModel extends  GetxController {
  RxBool isdark = true.obs;


  Future<void> toggleDarkMode() async {

   isdark.value = MyApp.sharedPreferences!.getBool("isdark") ?? true;
    isdark.value = !isdark.value;
   await MyApp.sharedPreferences!.setBool("isdark", isdark.value);

    if (isdark.value) {
      Get.changeTheme(themeDataLight);
    } else {
      Get.changeTheme(themeDataDark);
    }
    update();
  }

  Future<void> toggleDarkMode1() async {

    isdark.value = MyApp.sharedPreferences!.getBool("isdark") ?? true;
    if (isdark.value) {
      Get.changeTheme(themeDataLight);
    } else {
      Get.changeTheme(themeDataDark);
    }
    update();
  }
  static  ThemeData themeDataLight = ThemeData(

      timePickerTheme: TimePickerThemeData(
        hourMinuteTextColor: GlobalData.fullblk,
        dayPeriodTextColor: GlobalData.fullblk,
        dialTextColor: GlobalData.fullwhite,
        entryModeIconColor: GlobalData.fullblk,
        backgroundColor: GlobalData.fullwhite,
      ),
      primaryColor: Colors.black,
      appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: GlobalData.bluebtn,
          ),
          centerTitle: true,
          elevation: 0,

          // 2
          iconTheme: IconThemeData(
            size: 18,
            color: GlobalData.fullblk,
          ),
          backgroundColor: GlobalData.fullwhite,
          titleTextStyle: TextStyle(
              color: Colors.black,fontSize: 18.sp, fontFamily: GlobalData.fontlistsemibold)),
      // primaryColor: Colors.blue,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.black, unselectedItemColor: Colors.black12),
      scaffoldBackgroundColor: GlobalData.fullwhite, colorScheme: ColorScheme.light(
        primary: GlobalData.fullblk,
        onPrimary: GlobalData.fullwhite,
      ).copyWith(background: GlobalData.fullwhite),

      // primarySwatch: Colors.grey,
      );

  static  ThemeData themeDataDark = ThemeData(
    timePickerTheme: TimePickerThemeData(
      hourMinuteTextColor: GlobalData.fullwhite,
      dayPeriodTextColor: GlobalData.fullwhite,
      dialTextColor: GlobalData.fullblk,
      entryModeIconColor: GlobalData.whitecolor,
      backgroundColor: GlobalData.fullblk,
    ),
    iconTheme: const IconThemeData(size: 20, color: Colors.white),
    appBarTheme: AppBarTheme(

        centerTitle: true,
        elevation: 0,
        actionsIconTheme: const IconThemeData(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        // backgroundColor: GlobalData.fullwhite,
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: GlobalData.fontlistsemibold,
            fontSize: 18.sp)),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: GlobalData.fullblk,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      surface: Colors.transparent,
      onSurface: Colors.black,
      primary: Colors.white,
      onPrimary: Colors.grey,
      secondary: Colors.grey,
      onSecondary: Colors.grey,
      background: Colors.transparent,
      onBackground: Colors.grey,
      error: Colors.grey,
      onError: Colors.grey,
    ),
    // primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
  );


}




