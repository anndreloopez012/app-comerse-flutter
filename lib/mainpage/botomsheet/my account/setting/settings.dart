import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/main.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/my%20account/setting/chnaage_password.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/my%20account/setting/my_address.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/my%20account/setting/offers.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/my%20account/setting/refer.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/my%20account/setting/wallet.dart';
import 'package:customer_ecomerce/mainpage/main_page.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../coman_widget/cman_widget_product.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  success_or_no_model? success;

  Future getchangenotification() async {
    Loader.showLoading();
    try {
      Map map = {
        "user_id": box.read('user_id'),
        "notification_status": MyApp.notifi == "0" ? "0" : "1"
      };
      var response = await Dio().post(
          default_API.baseUrl + post_api.urlchangenotificationstatus,
          data: map);
     

      var finalist = await response.data;

      success = success_or_no_model.fromJson(finalist);
      Loader.hideLoading();
      return success;
    } catch (e) {
      Loader.showErroDialog(description: "Something went Wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios_new)),
          primary: true,
          title: Text('Settings'.tr),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Get.to(const ChangePassword());
                          },
                          child: buildlisttilecell(
                              image: icon_global.icchangepass,
                              name: 'ChangePassword'.tr)),
                      GestureDetector(
                          onTap: () {
                            Get.to(const WalletPage());
                          },
                          child: buildlisttilecell(
                              image: icon_global.icwallet,
                              name: 'My_Wallet'.tr)),
                      GestureDetector(
                          onTap: () {
                            Get.to(const OfferPage());
                          },
                          child: buildlisttilecell(
                              image: icon_global.icoffer, name: 'Offers'.tr)),
                      GestureDetector(
                          onTap: () {
                            Get.to(MyAdressPage());
                          },
                          child: buildlisttilecell(
                              image: icon_global.icaadre,
                              name: 'My_Address'.tr)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: buildlisttilecell(
                          image: icon_global.icnoti,
                          name: 'Get_Notification'.tr,
                          leadwidg: CupertinoSwitch(
                            activeColor: GlobalData.bluebtn,
                            value: MyApp.notifi == "1" ? true : false,
                            onChanged: (val) {
                              if (MyApp.notifi == "1") {
                                setState(() {
                                  MyApp.notifi = "0";
                                });
                                getchangenotification();
                              } else {
                                setState(() {
                                  MyApp.notifi = "1";
                                });
                                getchangenotification();
                              }
                            },
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Get.to(const ReferEarn());
                          },
                          child: buildlisttilecell(
                              image: icon_global.icrefer,
                              name: 'ReferEarn'.tr)),
                      GestureDetector(
                          onTap: () {
                            _showbottomsheet();
                          },
                          child: buildlisttilecell(
                              image: icon_global.icchangelayout,
                              name: 'Change_Layout'.tr)),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: buildlisttilecell(
                          image: icon_global.icfillter,
                          name: controller.isdark.value
                              ? "Change Dark mode"
                              : "Change Light mode",
                          leadwidg: CupertinoSwitch(
                            activeColor: GlobalData.bluebtn,
                            value: controller.isdark.value ? false : true,
                            onChanged: (val) {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return MainPages(0);
                                },
                              ), (route) => false);
                              controller.toggleDarkMode();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  _showbottomsheet() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              height: 30.h,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: 2.h,
                      bottom: 2.h,
                    ),
                    child: Text('Select_Application_Layout'.tr,
                        style: TextStyle(
                          fontFamily: GlobalData.fontlistsemibold,
                          color: GlobalData.mediumgray,
                          fontSize: 17.sp,
                        )),
                  ),
                  Container(
                    height: 2.sp,
                    width: MediaQuery.of(context).size.width,
                    color: GlobalData.gray,
                  ),
                  SizedBox(
                    height: 7.h,
                    child: InkWell(
                      onTap: () async {
                        await Get.updateLocale(const Locale('en', 'US'));
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('LTR'.tr,
                              style: TextStyle(
                                fontFamily: GlobalData.fontlistsemibold,
                                color: GlobalData.bluebtn,
                                fontSize: 20.sp,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 2.sp,
                    width: MediaQuery.of(context).size.width,
                    color: GlobalData.gray,
                  ),
                  SizedBox(
                    height: 7.h,
                    child: InkWell(
                      onTap: () async {
                        await Get.updateLocale(const Locale('ar', 'ab'));
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('RTL'.tr,
                              style: TextStyle(
                                fontFamily: GlobalData.fontlistsemibold,
                                color: GlobalData.bluebtn,
                                fontSize: 20.sp,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 2.sp,
                    width: MediaQuery.of(context).size.width,
                    color: GlobalData.gray,
                  ),
                  SizedBox(
                    height: 7.h,
                    child: InkWell(
                      onTap: () async {
                        Navigator.of(context).pop();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Cancel'.tr,
                              style: TextStyle(
                                fontFamily: GlobalData.fontlistsemibold,
                                color: GlobalData.bluebtn,
                                fontSize: 20.sp,
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }
}
