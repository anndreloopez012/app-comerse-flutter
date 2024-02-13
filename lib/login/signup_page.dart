import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/register_model.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/login/otp.dart';
import 'package:customer_ecomerce/login/vendore_signup.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import '../../Config/global_data.dart';
import '../api/all_model/social_modle.dart';
import '../main.dart';
import 'login_page.dart';

// ignore: must_be_immutable
class SignUp extends StatefulWidget {
  String? type;
  String? gmails;
  String? gname;
  String? gid;

  // ignore: use_key_in_widget_constructors
  SignUp(this.type, [this.gmails, this.gname, this.gid]);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  registe_model? register;
  bool isChecked = false;
  bool securepasword = true;

  TextEditingController fname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController refr = TextEditingController();
  TextEditingController passoed = TextEditingController();
  String fullname = "";
  String mail = "";
  String mob = "";
  String referc = "";
  String pas = " ";

  Future registetapi() async {
    Loader.showLoading();
    var map = {
      "email": mail,
      "login_type": "email",
      "mobile": mob,
      "name": fullname,
      "password": pas,
      "referral_code": "",
      "register_type": "email",
      "token": MyApp.tokke
    };
    var response = await Dio()
        .post(default_API.baseUrl + post_api.urlregister, data: map);

    var finallist = await response.data;
    register = registe_model.fromJson(finallist);
    Loader.hideLoading();

    if (register!.status == 1) {
 
      Get.offAll(OtpPage(register!.data!.email!));
      Fluttertoast.showToast(msg: 'success'.tr);
    } else {
   
      Loader.showErroDialog(description: "${register!.message}");
    }
  }

  soscialloginapi() async {
    Loader.showLoading();
    var map = {
      "name": widget.gname,
      "email": widget.gmails,
      "mobile": mob,
      "token": MyApp.tokke!,
      "google_id": widget.gid,
      "login_type": "google",
      "register_type": "email",
      "facebook_id": ""
    };
    var response = await Dio()
        .post(default_API.baseUrl + post_api.urlregister, data: map);
   
    google_moldel data = google_moldel.fromJson(response.data);
    Loader.hideLoading();

    if (data.status == 1) {
      Fluttertoast.showToast(
        msg: data.message!,
        toastLength: Toast.LENGTH_SHORT,
      );
      Get.offAll(OtpPage(widget.gmails));
  
    } else if (data.status == 2) {
      Fluttertoast.showToast(
        msg: data.message!,
        toastLength: Toast.LENGTH_SHORT,
      );
      Get.offAll(OtpPage(widget.gmails));
   
    } else if (data.status == 3) {
      Fluttertoast.showToast(
        msg: data.message!,
        toastLength: Toast.LENGTH_SHORT,
      );
      Get.offAll(OtpPage(widget.gmails));
   
    } else {
      Loader.showErroDialog(description: data.message);
    }
  }

  void emailvalidation() {
    bool isValid = EmailValidator.validate(email.text.trim());
    if (isValid) {
      if (widget.type == "login") {
        registetapi();
      } else {
        soscialloginapi();
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Invalid_email'.tr,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.type == "google") {
      fname.text = widget.gname!.toString();
      email.text = widget.gmails!.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.purple;
      }
      return Colors.black;
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GetBuilder<ThemeModel>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10.h),
                    child: Text('SignUp'.tr,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: GlobalData.fontlistsemibold)),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Text('Create_account'.tr,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: GlobalData.fontlistsemibold)),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text('SignUp_to_get_started'.tr,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: GlobalData.fontlistregular)),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  TextFormField(
                    controller: fname,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        hintText: 'Full_name'.tr,
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: GlobalData.fontlistregular,
                          color: themeModel.isdark.value
                              ? GlobalData.darkgray
                              : GlobalData.whitecolor,
                        ),
                        fillColor: themeModel.isdark.value
                            ? GlobalData.whitecolor
                            : GlobalData.fullblk,
                        filled: true,
                        focusColor: Colors.white),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  TextFormField(
                    controller: email,
                    readOnly: widget.type == "google" ? true : false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        hintText: 'Email'.tr,
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: GlobalData.fontlistregular,
                          color: themeModel.isdark.value
                              ? GlobalData.darkgray
                              : GlobalData.whitecolor,
                        ),
                        fillColor: themeModel.isdark.value
                            ? GlobalData.whitecolor
                            : GlobalData.fullblk,
                        filled: true,
                        focusColor: Colors.white),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  IntlPhoneField(
                    keyboardType: TextInputType.phone,
                    controller: phone,
                    disableLengthCheck: true,
                    showCountryFlag: true,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        hintText: 'Mobile_no'.tr,
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: GlobalData.fontlistregular,
                          color: themeModel.isdark.value
                              ? GlobalData.darkgray
                              : GlobalData.whitecolor,
                        ),
                        fillColor: themeModel.isdark.value
                            ? GlobalData.whitecolor
                            : GlobalData.fullblk,
                        filled: true,
                        focusColor: Colors.white),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                    },
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  TextFormField(
                    controller: refr,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        hintText: 'Referral_Code'.tr,
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: GlobalData.fontlistregular,
                          color: themeModel.isdark.value
                              ? GlobalData.darkgray
                              : GlobalData.whitecolor,
                        ),
                        fillColor: themeModel.isdark.value
                            ? GlobalData.whitecolor
                            : GlobalData.fullblk,
                        filled: true,
                        focusColor: Colors.white),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  if (widget.type == "login") ...{
                    TextFormField(
                      obscureText: securepasword,
                      controller: passoed,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white38)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white38),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          hintText: 'Password'.tr,
                          hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: GlobalData.fontlistregular,
                            color: themeModel.isdark.value
                                ? GlobalData.darkgray
                                : GlobalData.whitecolor,
                          ),
                          fillColor: themeModel.isdark.value
                              ? GlobalData.whitecolor
                              : GlobalData.fullblk,
                          filled: true,
                          suffixIcon: GestureDetector(
                              onTap: () {
                                securepasword = !securepasword;
                                setState(() {});
                              },
                              child: Icon(securepasword
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    ),
                  },
                  Row(
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        margin: const EdgeInsets.only(top: 15),
                        child: Checkbox(
                            checkColor: Colors.white,
                            fillColor:
                                MaterialStateProperty.resolveWith(getColor),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            }),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 10),
                        child: Text(
                          'I_accept_the_terms_conditions'.tr,
                          style: TextStyle(
                              fontFamily: GlobalData.fontlistregular,
                              fontSize: 14),
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        fullname = fname.text;
                        mail = email.text;
                        mob = phone.text;
                        referc = refr.text;
                        pas = passoed.text;
                        if (fullname.isEmpty && mail.isEmpty) {
                          Fluttertoast.showToast(
                            msg: 'enteralldetails'.tr,
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        } else if (fullname.isEmpty) {
                          Fluttertoast.showToast(
                            msg: 'entername'.tr,
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        } else if (mob.isEmpty) {
                          Fluttertoast.showToast(
                            msg: 'entermobile'.tr,
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        } else if (mail.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'enteremail'.tr,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              fontSize: 16.0);
                        } else if (isChecked == false) {
                          Fluttertoast.showToast(
                            msg: 'entercondistion'.tr,
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        } else {
                          if (widget.type == "login") {
                            if (pas.isEmpty) {
                              Fluttertoast.showToast(
                                msg: 'enterpass'.tr,
                                toastLength: Toast.LENGTH_SHORT,
                              );
                            } else {
                              emailvalidation();
                            }
                          } else {
                            emailvalidation();
                          }
                        }
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 4.h),
                      decoration: BoxDecoration(
                          color: GlobalData.bluebtn,
                          borderRadius: const BorderRadius.all(Radius.circular(12))),
                      height: 6.5.h,
                      child: Center(
                        child: Text('SignUp'.tr,
                            style: TextStyle(
                                fontFamily: GlobalData.fontlistmedium,
                                fontSize: 17.sp,
                                color: GlobalData.fullwhite)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const VendoreSignUp());
                    },
                    child: Center(
                      widthFactor: double.infinity,
                      child: Text('Become_a_vendor'.tr,
                          style: TextStyle(
                              fontSize: 17.sp,
                              fontFamily: GlobalData.fontlistmedium)),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Center(
                    child: Text('Dont_have_an_account'.tr,
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontFamily: GlobalData.fontlistregular)),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  GestureDetector(
                      onTap: () => Get.to(const LoginPage()),
                      child: Center(
                        child: Text('Login'.tr,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: GlobalData.fontlistsemibold)),
                      )),
                  SizedBox(
                    height: 2.h,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
