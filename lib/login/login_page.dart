import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/all_string.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/login_model.dart';
import 'package:customer_ecomerce/api/all_model/register_model.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/login/otp.dart';
import 'package:customer_ecomerce/login/SignUp_page.dart';
import 'package:customer_ecomerce/main.dart';
import 'package:get/get.dart';
import 'package:customer_ecomerce/mainpage/main_page.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../Config/global_data.dart';
import '../api/all_model/aaaloginmodel.dart';
import 'forggot_pass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  GetStorage box = GetStorage();
  login_model? log;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool securepasword = true;
  String mail = "";
  String pas = "";
  String? fcmToken;

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) =>  AlertDialog(
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

  void emailvalidation() {
    bool isValid = EmailValidator.validate(email.text);
    if (isValid) {
      loginapi();
    } else {
      Fluttertoast.showToast(
        msg: 'Invalid_email'.tr,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  Future loginapi() async {
    try {
      Loader.showLoading();
      var map = {
        "email": mail.toString(),
        "password": pas,
        "token": MyApp.tokke!
      };
      var response =
          await Dio().post(default_API.baseUrl + post_api.urllogin, data: map);
      

      var finallist = await response.data;
      log = login_model.fromJson(finallist);
      if (log!.status == 1) {
        box.write("user_id", log!.data!.id!);
        Get.offAll(MainPages(0));
        Fluttertoast.showToast(msg: 'success'.tr);
      }
      if (log!.status == 2) {
        Get.offAll(OtpPage(log!.data!.email!));
        Fluttertoast.showToast(msg: 'success'.tr);
      } else {
        Loader.hideLoading();
        Fluttertoast.showToast(msg: log!.message!);
      }

      return log;
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);
    }
  }

  bool right = false;

  googlelogin() async {
    Loader.showLoading();
    await googlesignin.signIn().then((value) async {
      Loader.hideLoading();
      googlesignin.signOut();
      registerAPI(value!);
      
    }).catchError((e) {
      Loader.showErroDialog(description: e);
    });
  }

  registe_model? register;
  String? loginType;

  registerAPI(GoogleSignInAccount value) async {
    Loader.showLoading();
    var map = {
      "name": value.displayName,
      "email": value.email,
      "mobile": "",
      "token": MyApp.tokke!,
      "google_id": value.id,
      "login_type": "google",
      "facebook_id": ""
    };
    var response = await Dio()
        .post(default_API.baseUrl + post_api.urlregister, data: map);
    SignUpmodel data = SignUpmodel.fromJson(response.data);
    Loader.hideLoading();
    if (data.status == 1) {
      Get.offAll(OtpPage(value.email));
    }
    if (data.status == 2) {
      Get.offAll(SignUp("google", value.email, value.displayName!, value.id));
      
    }
    if (data.status == 3) {
      Get.offAll(OtpPage(value.email));
    } else {
      Loader.showErroDialog(description: data.message);
    }
  }

  registerwithfb(email, name, id) async {
    Loader.showLoading();
    var map = {
      "name": name,
      "email": email,
      "mobile": "",
      "token": MyApp.tokke!,
      "google_id": "",
      "login_type": "facebook",
      "facebook_id": id
    };
    var response = await Dio()
        .post(default_API.baseUrl + post_api.urlregister, data: map);
   
    SignUpmodel data = SignUpmodel.fromJson(response.data);
    Loader.hideLoading();
    if (data.status == 1) {
      Get.offAll(OtpPage(email));
    
    }
    if (data.status == 2) {
      Get.offAll(SignUp("google", email, name!, id));

    
    }
    if (data.status == 3) {
      Get.offAll(OtpPage(email));
     
    } else {
      Loader.showErroDialog(description: data.message);
    }
  }
  
  //fblogin() async {
  //  final LoginResult result = await FacebookAuth.instance
  //      .login(permissions: ['email', 'public_profile']);
//
  //  if (result.status == LoginStatus.success) {
  //    Map userdata = await FacebookAuth.instance.getUserData();
//
  //    fblogout();
  //    registerwithfb(userdata["email"], userdata["name"], userdata["id"]);
  //  } else {}
  //}

  //fblogout() async {
  //  await FacebookAuth.instance.logOut();
  //}

  String user = "";

  GoogleSignIn googlesignin = GoogleSignIn();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: GetBuilder<ThemeModel>(builder: (controller) {
          return SingleChildScrollView(
            child: Container(
              height: 98.h,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10.h),
                    child: Text('Login'.tr,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontFamily: GlobalData.fontlistsemibold)),
                  ),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Text('Welcome'.tr,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontFamily: GlobalData.fontlistsemibold)),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text('Please_login_to_your_account'.tr,
                      style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: GlobalData.fontlistregular)),
                  SizedBox(height: 1.5.h),
                  TextField(
                    controller: email,
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
                  SizedBox(height: 1.5.h),
                  TextField(
                    obscureText: securepasword,
                    controller: password,
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
                  GestureDetector(
                    onTap: () => Get.to(() => const ForgotPassword()),
                    child: Container(
                      alignment: Alignment.topRight,
                      margin: const EdgeInsets.only(top: 8),
                      child: Text('Forgot_Passoword'.tr,
                          style: TextStyle(
                              fontSize: 16.sp,
                              fontFamily: GlobalData.fontlistsemibold)),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      mail = email.text;
                      pas = password.text;
                      setState(() {
                        mail = email.text;
                        pas = password.text;
                        if (mail.isEmpty && pas.isEmpty) {
                          Fluttertoast.showToast(
                            msg: GlobalString.enteralldetails,
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        } else if (mail.isEmpty) {
                          Fluttertoast.showToast(
                            msg: GlobalString.enteremail,
                            toastLength: Toast.LENGTH_SHORT,
                          );
                        } else if (pas.isEmpty) {
                          Fluttertoast.showToast(
                            msg: GlobalString.enterpass,
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
                          borderRadius: const BorderRadius.all(Radius.circular(10))),
                      height: 6.5.h,
                      child: Center(
                        child: Text('Login'.tr,
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontFamily: GlobalData.fontlistmedium,
                                color: GlobalData.fullwhite)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.5.h,
                  ),
                  Center(
                    child: Text('OR'.tr,
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontFamily: GlobalData.fontlistmedium)),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            googlelogin();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: GlobalData.whitecolor,
                                borderRadius: GlobalRadious.radious_),
                            height: 7.h,
                            width: 93.w,
                            child: const Center(
                                child: Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Image(
                                        image: AssetImage(
                                            icon_global.icgoogle)))),
                          ),
                        ),
                        //GestureDetector(
                        //  onTap: () {
                        //    fblogin();
                        //  },
                        //  child: Container(
                        //    decoration: BoxDecoration(
                        //        color: GlobalData.whitecolor,
                        //        borderRadius: GlobalRadious.radious_),
                        //    height: 7.h,
                        //    width: 45.w,
                        //    child: const Center(
                        //        child: Padding(
                        //            padding: EdgeInsets.all(8),
                        //            child: Image(
                        //                image: AssetImage(
                        //                    icon_global.icfacebooklogo)))),
                        //  ),
                        //),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 6.h),
                      alignment: Alignment.center,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: GlobalData.fullwhite, elevation: 0,
                        ),
                        onPressed: () {
                          Get.to(() => MainPages(0));
                        },
                        child: Text(
                          'Skip_Countinue'.tr,
                          style: TextStyle(
                              fontSize: 16,
                              color: themeModel.isdark.value
                                  ? GlobalData.fullblk
                                  : GlobalData.fullwhite,
                              fontFamily: GlobalData.fontlistsemibold),
                        ),
                      )),
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
                      onTap: () => Get.to(() => SignUp("login")),
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
          );
        }),
      ),
    );
  }
}
