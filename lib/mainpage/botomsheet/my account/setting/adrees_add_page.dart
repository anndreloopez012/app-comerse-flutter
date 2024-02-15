import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/add_adress_model.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/my%20account/setting/my_address.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../api/all_model/get_add_model.dart';
import '../../../../coman_widget/cman_widget_product.dart';

// ignore: must_be_immutable
class AdreesEditPage extends StatefulWidget {
  Data? data;

  @override
  State<AdreesEditPage> createState() => _AdreesEditPageState();

  // ignore: use_key_in_widget_constructors
  AdreesEditPage([this.data]);
}

class _AdreesEditPageState extends State<AdreesEditPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  add_address_api? addre;
  success_or_no_model? succe;

  TextEditingController name = TextEditingController();
  TextEditingController lastnname = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController pin = TextEditingController();
  TextEditingController ph = TextEditingController();
  TextEditingController email = TextEditingController();

  String fullname = "";
  String lastname = "";
  String streetno = "";
  String landm = "";
  String postcode = "";
  String phone = "";
  String emaiaddress = "";
  String method = "Insert";

  Future<success_or_no_model?> getaddaddres() async {
    Loader.showLoading();
    try {
      var map = {
        "user_id": box.read('user_id'),
        "first_name": fullname.toString(),
        "last_name": lastnname.toString(),
        "street_address": streetno.toString(),
        "landmark": landm.toString(),
        "pincode": postcode.toString(),
        "email": emaiaddress.toString(),
        "mobile": phone.toString(),
      };
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urladdaddres, data: map);
      
      Loader.hideLoading();
      var finallist = await response.data;
      succe = success_or_no_model.fromJson(finallist);
      if (succe!.status == 1) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return MyAdressPage();
          },
        ));
      } else {
        Loader.showErroDialog(description: "${succe!.message}");
      }
      return succe;
    } catch (e) {
      Loader.hideLoading();

      Loader.showErroDialog(description: "No Data Found");
     
    }
    return null;
  }

  Future<add_address_api?> geteditaddress() async {
    Loader.showLoading();
    try {
      var map = {
        "address_id": widget.data!.id,
        "first_name": fullname.toString(),
        "last_name": lastnname.toString(),
        "street_address": streetno.toString(),
        "landmark": landm.toString(),
        "pincode": postcode.toString(),
        "email": emaiaddress.toString(),
        "mobile": phone.toString(),
      };
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urleditaddres, data: map);
      
      Loader.hideLoading();
      var finallist = await response.data;
      addre = add_address_api.fromJson(finallist);
      setState(() {});
      if (addre!.status == 1) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return MyAdressPage();
          },
        ));
      } else {
        Loader.showErroDialog(description: "${addre!.message}");
      }
      return addre;
    } catch (e) {
      Loader.hideLoading();

      Loader.showErroDialog(description: "No Data Found");
    
    }
    return null;
  }

  @override
  void initState() {
    super.initState();

    if (widget.data != null) {
      name.text = widget.data!.firstName.toString();
      lastnname.text = widget.data!.lastName.toString();
      street.text = widget.data!.streetAddress.toString();
      landmark.text = widget.data!.landmark.toString();
      pin.text = widget.data!.pincode.toString();
      ph.text = widget.data!.mobile.toString();
      email.text = widget.data!.email.toString();
      method = "update";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "New_Adddress".tr,
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
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 1.5.h,
                  ),
                  TextField(
                    controller: name,
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
                        hintText: 'First_Name'.tr,
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
                    controller: lastnname,
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
                        hintText: 'Last_Name'.tr,
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
                    controller: street,
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
                        hintText: 'Stree_No'.tr,
                        hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: GlobalData.fontlistregular,
                            color: themeModel.isdark.value
                                ? GlobalData.darkgray
                                : GlobalData.whitecolor),
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
                    controller: landmark,
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
                        hintText: 'Landmark'.tr,
                        hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: GlobalData.fontlistregular,
                            color: themeModel.isdark.value
                                ? GlobalData.darkgray
                                : GlobalData.whitecolor),
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
                    controller: pin,
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
                        hintText: 'PostCode_Zip'.tr,
                        hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: GlobalData.fontlistregular,
                            color: themeModel.isdark.value
                                ? GlobalData.darkgray
                                : GlobalData.whitecolor),
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
                    controller: ph,
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
                        hintText: 'Phone'.tr,
                        hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: GlobalData.fontlistregular,
                            color: themeModel.isdark.value
                                ? GlobalData.darkgray
                                : GlobalData.whitecolor),
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
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white38),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: 'Email_Address'.tr,
                        hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: GlobalData.fontlistregular,
                            color: themeModel.isdark.value
                                ? GlobalData.darkgray
                                : GlobalData.whitecolor),
                        fillColor: themeModel.isdark.value
                            ? GlobalData.whitecolor
                            : GlobalData.fullblk,
                        filled: true,
                        focusColor: Colors.white),
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ),
          ),
          bottomSheet: SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0, backgroundColor: GlobalData.bluebtn,
                ),
                onPressed: () {
                  setState(() {
                    fullname = name.text;
                    lastname = lastnname.text;
                    streetno = street.text;
                    landm = landmark.text;
                    postcode = pin.text;
                    phone = ph.text;
                    emaiaddress = email.text;

                    if (fullname.isEmpty &&
                        lastname.isEmpty &&
                        streetno.isEmpty &&
                        landm.isEmpty &&
                        postcode.isEmpty &&
                        phone.isEmpty &&
                        emaiaddress.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "enteralldetails",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    } else if (fullname.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Enter_your_Fullname".tr,
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    } else if (lastname.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Enter_your_Lastname".tr,
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    } else if (streetno.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Enter_your_Street_no".tr,
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    } else if (landm.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Enter_your_Landmark".tr,
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    } else if (postcode.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Enter_your_Postcode_Zip".tr,
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    } else if (phone.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Enter_your_Phone_no".tr,
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    } else if (emaiaddress.isEmpty) {
                      Fluttertoast.showToast(
                        msg: "Enter_your_Email_address".tr,
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    } else {
                      if (method == "Insert".tr) {
                        getaddaddres();
                      } else {
                        geteditaddress();
                      }
                    }
                  });
                },
                child: Text(
                  "Save_Address".tr,
                  style: TextStyle(
                      fontSize: 16,
                      color: GlobalData.whitecolor,
                      fontFamily: GlobalData.fontlistsemibold),
                )),
          ),
        );
      },
    );
  }
}
