import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/all_string.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/coman_widget/widget_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../Config/thememodel.dart';
import '../../../main_page.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  GetStorage box = GetStorage();
  TextEditingController oldpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  bool isChecked = false;
  bool oldsecurepasword = true;
  bool newsecurepasword = true;
  bool confirmsecurepasword = true;
  String pas1 = "";
  String pas2 = "";
  String pas3 = "";
  String title = "mehul pandya";

  success_or_no_model? accept;

  Future getchangepassword() async {
    try {
      Loader.showLoading();
      Map map = {
        "user_id": box.read('user_id'),
        "old_password": pas1,
        "new_password": pas2,
        "confirm_new_password": pas3
      };
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlchangpassword, data: map);
     
      var finalist = await response.data;
      accept = success_or_no_model.fromJson(finalist);
      Loader.hideLoading();
      if (accept!.status == 1) {
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_SHORT, msg: accept!.message!);
        Get.offUntil(
            MaterialPageRoute(
              builder: (context) => MainPages(4),
            ),
            (route) => false);
      } else {
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_SHORT, msg: accept!.message!);
      }
      return accept;
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: "Something went Wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              GlobalString.abchnagepas,
            ),
            primary: true,
            leadingWidth: 40,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            margin: const EdgeInsets.only(right: 12, left: 12, top: 14),
            child: Column(
              children: [
                TextField(
                  obscureText: oldsecurepasword,
                  controller: oldpassword,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white38)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white38),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    hintText: 'Old_Password'.tr,
                    hintStyle: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: GlobalData.fontlistregular),
                    fillColor: themeModel.isdark.value
                        ? GlobalData.whitecolor
                        : GlobalData.fullblk,
                    filled: true,
                    suffixIcon: IconButton(
                        onPressed: () {
                          oldsecurepasword = !oldsecurepasword;
                          setState(() {});
                        },
                        icon: buildSvgimage(
                            drkclr: GlobalData.fullwhite,
                            imgnem: oldsecurepasword
                                ? icon_global.iceyeshow
                                : icon_global.iceyehide)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: newsecurepasword,
                  controller: newpassword,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white38)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white38),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    hintText: 'New_Password'.tr,
                    hintStyle: TextStyle(
                        fontSize: 15.sp,
                        fontFamily: GlobalData.fontlistregular),
                    fillColor: themeModel.isdark.value
                        ? GlobalData.whitecolor
                        : GlobalData.fullblk,
                    filled: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        newsecurepasword = !newsecurepasword;
                        setState(() {});
                      },
                      icon: buildSvgimage(
                          drkclr: GlobalData.fullwhite,
                          imgnem: newsecurepasword
                              ? icon_global.iceyeshow
                              : icon_global.iceyehide),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  obscureText: confirmsecurepasword,
                  controller: confirmpassword,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white38)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white38),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      hintText: 'Confirm_Password'.tr,
                      hintStyle: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: GlobalData.fontlistregular),
                      fillColor: themeModel.isdark.value
                          ? GlobalData.whitecolor
                          : GlobalData.fullblk,
                      filled: true,
                      suffixIcon: IconButton(
                        icon: buildSvgimage(
                            drkclr: GlobalData.fullwhite,
                            imgnem: confirmsecurepasword
                                ? icon_global.iceyeshow
                                : icon_global.iceyehide),
                        onPressed: () {
                          confirmsecurepasword = !confirmsecurepasword;
                          setState(() {});
                        },
                      )),
                ),
                const Spacer(),
                Container(
                  height: 50,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: GlobalData.bluebtn,
                      ),
                      onPressed: () {
                        setState(() {
                          pas1 = oldpassword.text;
                          pas2 = newpassword.text;
                          pas3 = confirmpassword.text;
                          if (pas1.isEmpty && pas2.isEmpty && pas3.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "enteralldetails".tr,
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          } else if (pas1.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Enter_old_password".tr,
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          } else if (pas2.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Enter_new_password".tr,
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          } else if (pas3.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Enter_confirm_password".tr,
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          } else if (pas2 != pas3) {
                            Fluttertoast.showToast(
                              msg:
                                  "New_password_and_confirm_password_must_be_same".tr,
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          } else {
                            getchangepassword();
                          }
                        });
                      },
                      child: Text(
                        GlobalString.btnchpas,
                        style: TextStyle(
                            fontSize: 16,
                            color: GlobalData.whitecolor,
                            fontFamily: GlobalData.fontlistsemibold),
                      )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
