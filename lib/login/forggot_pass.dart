import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/login/SignUp_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Config/global_data.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  bool isChecked = false;
  bool securepasword = true;

  TextEditingController email = TextEditingController();

  String mail = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        primary: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
          ),
        ),
      ),
      body: GetBuilder<ThemeModel>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Container(
              height: 85.h,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Padding(
                padding: EdgeInsets.only(top: 25.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('forgot_passoword'.tr,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: GlobalData.fontlistsemibold)),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text('Forgot_pass_describe'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: GlobalData.fontlistregular)),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      height: 6.h,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
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
                            hintText: 'Email'.tr,
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
                      margin: EdgeInsets.only(top: 2.h),
                      decoration: BoxDecoration(
                          color: GlobalData.bluebtn,
                          borderRadius: const BorderRadius.all(Radius.circular(8))),
                      height: 6.5.h,
                      child: Center(
                        child: Text('Submit'.tr,
                            style: TextStyle(
                                fontFamily: GlobalData.fontlistmedium,
                                color: GlobalData.fullwhite)),
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: Text('Dont_have_an_account'.tr,
                          style: TextStyle(
                              fontSize: 17.sp,
                              fontFamily: GlobalData.fontlistregular)),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    GestureDetector(
                        onTap: () => Get.to(SignUp("login")),
                        child: Center(
                          child: Text('SignUp'.tr,
                              style: TextStyle(
                                  fontSize: 17.sp,
                                  fontFamily: GlobalData.fontlistmedium)),
                        )),
                    SizedBox(
                      height: 3.h,
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
