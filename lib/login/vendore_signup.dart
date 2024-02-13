import 'package:customer_ecomerce/Config/all_string.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:get/get.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../Config/global_data.dart';

// ignore: camel_case_types
class VendoreSignUp extends StatefulWidget {
  const VendoreSignUp({Key? key}) : super(key: key);

  @override
  State<VendoreSignUp> createState() => _VendoreSignUpState();
}

// ignore: camel_case_types
class _VendoreSignUpState extends State<VendoreSignUp> {
  ThemeModel themeModel = Get.find<ThemeModel>();
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

  void emailvalidation() {
    bool isValid = EmailValidator.validate(email.text.trim());
    if (isValid) {
      const Center();
    } else {
      Fluttertoast.showToast(
        msg: 'Invalid_email'.tr,
        toastLength: Toast.LENGTH_SHORT,
      );
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          GlobalString.absignupvendor,
        ),
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
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  TextField(
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
                  TextField(
                    controller: email,
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
                  TextField(
                    obscureText: securepasword,
                    controller: passoed,
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

                        if (fullname.isEmpty &&
                            mail.isEmpty &&
                            mob.isEmpty &&
                            pas.isEmpty) {
                          Fluttertoast.showToast(
                            msg: 'enteralldetails'.tr,
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        } else if (fullname.isEmpty) {
                          Fluttertoast.showToast(
                            msg: 'entername'.tr,
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        } else if (mail.isEmpty) {
                          Fluttertoast.showToast(
                              msg: 'enteremail'.tr,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 1,
                              fontSize: 16.0);
                        } else if (mob.isEmpty) {
                          Fluttertoast.showToast(
                            msg: 'entermobile'.tr,
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        } else if (pas.isEmpty) {
                          Fluttertoast.showToast(
                            msg: 'enterpass'.tr,
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        } else if (isChecked == false) {
                          Fluttertoast.showToast(
                            msg: 'entercondistion'.tr,
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        } else {
                          emailvalidation();
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
