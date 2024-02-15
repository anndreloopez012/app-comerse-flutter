import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/all_string.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/get_profile_model_api.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_utils/get_utils.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../coman_widget/cman_widget_product.dart';
import '../../main_page.dart';

// ignore: must_be_immutable
class HelpContactPage extends StatefulWidget {
  Contactinfo? contact;

  HelpContactPage(this.contact, {super.key});

  @override
  State<HelpContactPage> createState() => _HelpContactPageState();
}

class _HelpContactPageState extends State<HelpContactPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController mob = TextEditingController();
  TextEditingController emailadd = TextEditingController();
  TextEditingController sub = TextEditingController();
  TextEditingController message = TextEditingController();

  String fname = "";
  String lname = "";
  String mobile = "";
  String email = "";
  String subject = "";
  String mess = "";
  success_or_no_model? success;

  Future gethelpcontactapi() async {
    Loader.showLoading();
    try {
      Map map = {
        "user_id": box.read('user_id'),
        "first_name": fname,
        "last_name": lname,
        "mobile": mobile,
        "email": email,
        "subject": subject,
        "message": mess,
      };
      var response =
          await Dio().post(default_API.baseUrl + post_api.urlhelp, data: map);

      var finalist = await response.data;

      success = success_or_no_model.fromJson(finalist);
      Loader.hideLoading();
      if (success!.status == 1) {
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_LONG, msg: success!.message!);
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPages(4),
            ),
            (route) => false);
      } else {
        Fluttertoast.showToast(
            toastLength: Toast.LENGTH_LONG, msg: success!.message!);
      }

      return success;
    } catch (e) {
      Loader.showErroDialog(description: "Something went Wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            primary: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
            title: Text("Help_ContactUs".tr),
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              height: 93.h,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      minLeadingWidth: 0,
                      horizontalTitleGap: 4.w,
                      leading: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          themeModel.isdark.value
                              ? GlobalData.fullblk
                              : GlobalData.whitecolor,
                          BlendMode.srcIn,
                        ),
                        child: SvgPicture.asset(
                          icon_global.iccall,
                          width: 24,
                        ),
                      ),
                      title: Text(widget.contact!.contact!,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: GlobalData.fontlistmedium,
                              color: themeModel.isdark.value
                                  ? GlobalData.fullblk
                                  : GlobalData.whitecolor)),
                    ),
                    ListTile(
                      minLeadingWidth: 0,
                      horizontalTitleGap: 4.w,
                      leading: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          themeModel.isdark.value
                              ? GlobalData.fullblk
                              : GlobalData.whitecolor,
                          BlendMode.srcIn,
                        ),
                        child: SvgPicture.asset(
                          icon_global.icaadre,
                          width: 24,
                        ),
                      ),
                      title: Text(widget.contact!.address!,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: GlobalData.fontlistmedium,
                              color: themeModel.isdark.value
                                  ? GlobalData.fullblk
                                  : GlobalData.whitecolor)),
                    ),
                   ListTile(
                      minLeadingWidth: 0,
                      horizontalTitleGap: 4.w,
                      leading: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          themeModel.isdark.value
                              ? GlobalData.fullblk
                              : GlobalData.whitecolor,
                          BlendMode.srcIn,
                        ),
                        child: SvgPicture.asset(
                          icon_global.icmail,
                          width: 24,
                        ),
                      ),
                      title: Text(widget.contact!.email!,
                          style: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: GlobalData.fontlistmedium,
                              color: themeModel.isdark.value
                                  ? GlobalData.fullblk
                                  : GlobalData.whitecolor)),
                    ),

                    SizedBox(height: 1.h),
                    Text("Quick_Contact_Us".tr,
                        style: TextStyle(
                            fontSize: 18.sp,
                            fontFamily: GlobalData.fontlistsemibold)),
                    SizedBox(height: 2.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: firstname,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white38),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white38)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white38),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                hintText: "First_Name".tr,
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
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: lastname,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(10),
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white38),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                enabledBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white38)),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white38),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                hintText: "Last_Name".tr,
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
                      ],
                    ),
                    SizedBox(height: 1.5.h),
                    TextField(
                      controller: mob,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
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
                          hintText: "Mobile".tr,
                          hintStyle: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: GlobalData.fontlistregular),
                          fillColor: themeModel.isdark.value
                              ? GlobalData.whitecolor
                              : GlobalData.fullblk,
                          filled: true,
                          focusColor: Colors.white),
                    ),
                    SizedBox(height: 1.5.h),
                    TextField(
                      controller: emailadd,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
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
                          hintText: "Email".tr,
                          hintStyle: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: GlobalData.fontlistregular),
                          fillColor: themeModel.isdark.value
                              ? GlobalData.whitecolor
                              : GlobalData.fullblk,
                          filled: true,
                          focusColor: Colors.white),
                    ),
                    SizedBox(height: 1.5.h),
                    TextField(
                      controller: sub,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
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
                          hintText: "Subject".tr,
                          hintStyle: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: GlobalData.fontlistregular),
                          fillColor: themeModel.isdark.value
                              ? GlobalData.whitecolor
                              : GlobalData.fullblk,
                          filled: true,
                          focusColor: Colors.white),
                    ),
                    SizedBox(height: 1.5.h),
                    TextField(
                      controller: message,
                      maxLines: 5,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
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
                          hintText: "Message".tr,
                          hintStyle: TextStyle(
                              fontSize: 15.sp,
                              fontFamily: GlobalData.fontlistregular),
                          fillColor: themeModel.isdark.value
                              ? GlobalData.whitecolor
                              : GlobalData.fullblk,
                          filled: true,
                          focusColor: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomSheet: GestureDetector(
            onTap: () {
              fname = firstname.text;
              lname = lastname.text;
              mobile = mob.text;
              email = emailadd.text;
              subject = sub.text;
              mess = message.text;
              setState(() {
                if (fname.isEmpty &&
                    lname.isEmpty &&
                    mobile.isEmpty &&
                    email.isEmpty &&
                    mess.isEmpty &&
                    subject.isEmpty) {
                  Fluttertoast.showToast(
                      toastLength: Toast.LENGTH_LONG,
                      msg: GlobalString.enteralldetails);
                } else if (fname.isEmpty) {
                  Fluttertoast.showToast(
                      toastLength: Toast.LENGTH_LONG,
                      msg: GlobalString.entername);
                } else if (lname.isEmpty) {
                  Fluttertoast.showToast(
                      toastLength: Toast.LENGTH_LONG,
                      msg: GlobalString.entername);
                } else if (mobile.isEmpty) {
                  Fluttertoast.showToast(
                      toastLength: Toast.LENGTH_LONG,
                      msg: GlobalString.entermobile);
                } else if (email.isEmpty) {
                  Fluttertoast.showToast(
                      toastLength: Toast.LENGTH_LONG,
                      msg: GlobalString.enteremail);
                } else if (mess.isEmpty) {
                  Fluttertoast.showToast(
                      toastLength: Toast.LENGTH_LONG,
                      msg: GlobalString.enteralldetails);
                } else if (subject.isEmpty) {
                  Fluttertoast.showToast(
                      toastLength: Toast.LENGTH_LONG,
                      msg: GlobalString.enteralldetails);
                } else {
                  gethelpcontactapi();
                }
              });
            },
            child: Container(
              decoration: BoxDecoration(color: GlobalData.bluebtn),
              height: 6.5.h,
              child: Center(
                child: Text("Send".tr,
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontFamily: GlobalData.fontlistmedium,
                        color: GlobalData.fullwhite)),
              ),
            ),
          ),
        );
      },
    );
  }
}
