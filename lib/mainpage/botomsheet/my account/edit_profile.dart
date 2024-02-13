import 'dart:io';

import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/all_string.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/coman_widget/widget_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../Config/thememodel.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../Config/global_data.dart';
import '../../../api/all_model/edit_profile_model.dart';
import '../../main_page.dart';

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
  String? profilename;
  String? pfilimg;
  String? pfofilecontact;
  int? pfofileid;
  String? pfofilemail;

  EditProfile(this.profilename, this.pfilimg, this.pfofilecontact,
      this.pfofileid, this.pfofilemail, {super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  ThemeModel themeModel = getx.Get.find<ThemeModel>();
  GetStorage box = GetStorage();

  edt_profile_model? profiles;

  final ImagePicker _picker = ImagePicker();
  String imagepath = "";
  String imagename = "";
  TextEditingController pname = TextEditingController();
  TextEditingController pmail = TextEditingController();
  TextEditingController pmobile = TextEditingController();
  String pnames = "";
  String pmails = "";
  String pnmobies = "";

  imagePickerOption() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            Column(
              children: [
                SizedBox(
                  width: 100.w,
                  height: 20.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final XFile? photo = await _picker.pickImage(
                              source: ImageSource.camera);
                          imagepath = photo!.path;
                          setState(() {});
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          height: 120,
                          width: 125,
                          child: Column(
                            children: [
                              const SizedBox(
                                width: 80,
                                height: 80,
                                child: Icon(Icons.camera_alt, size: 60),
                              ),
                              Text(
                                "Camara".tr,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: GlobalData.fontlistregular),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final XFile? photo = await _picker.pickImage(
                              source: ImageSource.gallery);
                          imagepath = photo!.path;

                          setState(() {});

                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        },
                        child: SizedBox(
                          height: 120,
                          width: 125,
                          child: Column(
                            children: [
                              const SizedBox(
                                width: 80,
                                height: 80,
                                child: Icon(Icons.photo, size: 60),
                              ),
                              Text(
                                "Photos".tr,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: GlobalData.fontlistregular),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      style: TextButton.styleFrom(foregroundColor: GlobalData.fullblk),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel".tr)),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future geteditprofile() async {
    Loader.showLoading();
    try {
      var formData = FormData.fromMap({
        "user_id": box.read('user_id'),
        "name": pnames.toString(),
        'image': imagepath.isNotEmpty
            ? await MultipartFile.fromFile(imagepath,
                filename: imagepath.split("/").last)
            : widget.pfilimg,
      });
      
      var response = await Dio().post(
          default_API.baseUrl + post_api.urleditprofile,
          data: formData);
    
      Loader.hideLoading();
      var finallistss = await response.data;
      profiles = edt_profile_model.fromJson(finallistss);
      if (profiles!.status == 1) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPages(4),
            ),
            (route) => false);
      } else {
        Fluttertoast.showToast(
          msg: profiles!.message!,
          toastLength: Toast.LENGTH_SHORT,
        );
      }
   
      return profiles;
    } catch (e) {
      Loader.hideLoading();
    }
  }

  @override
  void initState() {
    super.initState();
    pname.text = widget.profilename.toString();
    pmail.text = widget.pfofilemail.toString();
    pmobile.text = widget.pfofilecontact.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(
      builder: (controller) {
        return SafeArea(
            child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "EditProfile".tr,
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
            margin: const EdgeInsets.only(top: 12),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            imagepath.isNotEmpty
                                ? SizedBox(
                                    height: 130,
                                    width: 130,
                                    child: SizedBox(
                                      height: 20.h,
                                      width: 50.w,
                                      child: ClipOval(
                                        child: Image.file(
                                          fit: BoxFit.fill,
                                          File(imagepath),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 15.h,
                                    width: 30.w,
                                    decoration: const BoxDecoration(
                                        // border: Border.all(width: 2),
                                        shape: BoxShape.circle),
                                    child: widget.pfilimg == null
                                        ? ClipOval(
                                            child: FadeInImage(
                                              placeholder: const AssetImage(
                                                  icon_global.icprofile),
                                              image:
                                                  NetworkImage(widget.pfilimg!),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    icon_global.icprofile,
                                                    height: 15.h,
                                                    width: 15.h,
                                                    fit: BoxFit.fill);
                                              },
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : ClipOval(
                                            child: FadeInImage(
                                              placeholder: const AssetImage(
                                                  icon_global.icprofile),
                                              image:
                                                  NetworkImage(widget.pfilimg!),
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                    icon_global.icprofile,
                                                    height: 15.h,
                                                    width: 15.h,
                                                    fit: BoxFit.fill);
                                              },
                                              height: 15.h,
                                              width: 15.h,
                                              fit: BoxFit.fill,
                                            ),
                                          )),
                            Positioned(
                              right: 0.2.w,
                              top: 10.h,
                              child: CircleAvatar(
                                radius: 5.w,
                                backgroundColor: GlobalData.fullwhite,
                                child: GestureDetector(
                                    onTap: imagePickerOption,
                                    child: buildSvgimage(
                                        widt: 26,
                                        lightclr: GlobalData.fullblk,
                                        imgnem: icon_global.iccemera)),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextField(
                        controller: pname,
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
                            hintText: 'Full_name'.tr,
                            hintStyle: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: GlobalData.fontlistregular),
                            fillColor: themeModel.isdark.value
                                ? GlobalData.whitecolor
                                : GlobalData.fullblk,
                            filled: true,
                            focusColor: GlobalData.whitecolor),
                      ),
                      SizedBox(height: 1.5.h),
                      TextField(
                        readOnly: true,
                        controller: pmail,
                        keyboardType: TextInputType.emailAddress,
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
                            hintText: 'Email'.tr,
                            hintStyle: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: GlobalData.fontlistregular),
                            fillColor: themeModel.isdark.value
                                ? GlobalData.whitecolor
                                : GlobalData.fullblk,
                            filled: true,
                            focusColor: GlobalData.whitecolor),
                      ),
                      SizedBox(height: 1.5.h),
                      TextField(
                        controller: pmobile,
                        readOnly: true,
                        keyboardType: TextInputType.phone,
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
                            hintText: 'Mobile_no'.tr,
                            hintStyle: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: GlobalData.fontlistregular),
                            fillColor: themeModel.isdark.value
                                ? GlobalData.whitecolor
                                : GlobalData.fullblk,
                            filled: true,
                            focusColor: GlobalData.whitecolor),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      pnames = pname.text;
                      pmails = pmail.text;
                      pnmobies = pmobile.text;
                      if (pnames.isEmpty) {
                        Fluttertoast.showToast(
                          msg: "entername".tr,
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      } else {
                        geteditprofile();
                      }
                    });
                  },
                  child: Container(
                    height: 6.5.h,
                    width: double.infinity,
                    color: GlobalData.bluebtn,
                    child: Center(
                      child: Text(
                        GlobalString.btnedtiprofile,
                        style: TextStyle(
                            fontSize: 18.sp,
                            color: GlobalData.whitecolor,
                            fontFamily: GlobalData.fontlistsemibold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
      },
    );
  }
}
