import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/otp_model.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:get/get.dart';
import 'package:customer_ecomerce/main.dart';
import 'package:customer_ecomerce/mainpage/main_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class OtpPage extends StatefulWidget {
  String? email;

  OtpPage(this.email, {super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  GetStorage box = GetStorage();
  TextEditingController otp = TextEditingController();
  String otpp = "";
  otp_model? otpdata;

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

  Future otpverification() async {
    try {
      Loader.showLoading();
      var map = {"email": widget.email, "otp": otpp, "token": MyApp.tokke};
      var response =
          await Dio().post(default_API.baseUrl + post_api.urlotp, data: map);

      var finallist = await response.data;
      otpdata = otp_model.fromJson(finallist);
      if (otpdata!.status == 1) {
        box.write("user_id", otpdata!.data!.id!);

        Get.offAll(MainPages(0));
        Fluttertoast.showToast(msg: "success");
      } else {
        Loader.hideLoading();
        Fluttertoast.showToast(msg: otpdata!.message!);
      }

      return otpdata!;
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: "No Data Found");

    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: GetBuilder<ThemeModel>(
          builder: (controller) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 35),
                        child: Text(
                          "otpverification".tr,
                          style: TextStyle(
                              fontFamily: GlobalData.fontlistbold,
                              fontSize: 16),
                        )),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: Text(
                          "Check_your_email_for_otp_Enter_OTP_below_and_proceed_further".tr,
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: GlobalData.fontlistmedium,
                          ),
                          textAlign: TextAlign.center),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                      alignment: Alignment.center,
                      child: TextField(
                        controller: otp,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white38),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white38)),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white38),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            hintText: 'Enter_OTP'.tr,
                            hintStyle: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: GlobalData.fontlistregular),
                            fillColor: themeModel.isdark.value
                                ? GlobalData.whitecolor
                                : GlobalData.fullblk,
                            filled: true,
                            focusColor: Colors.white),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 30,
                      ),
                      height: 7.h,
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: GlobalData.bluebtn),
                          onPressed: () {
                            otpp = otp.text;
                            if (otpp.isEmpty) {
                              Fluttertoast.showToast(
                                msg: "Enter_your_OTP".tr,
                                toastLength: Toast.LENGTH_SHORT,
                              );
                            } else {
                              otpverification();
                            }
                          },
                          child: Text(
                            "Verify_proceed".tr,
                            style: TextStyle(
                                fontFamily: GlobalData.fontlistsemibold),
                          )),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
