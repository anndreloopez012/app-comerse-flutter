import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/coman_widget/cman_widget_product.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/my%20account/help_contact.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/my%20account/privacy.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/my%20account/setting/settings.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../api/all_model/get_profile_model_api.dart';
import '../../../login/login_page.dart';
import 'aboutus.dart';
import 'edit_profile.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();

  get_profile_model? profile;

  Future getmyprofile() async {
    try {
      Map map = {"user_id": box.read('user_id')};
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlgetprofile, data: map);

      var finalist = await response.data;

      profile = get_profile_model.fromJson(finalist);

      box.write("u_name", profile!.data!.name!);
      box.write("u_mobile", profile!.data!.mobile!);
      box.write("u_mail", profile!.data!.email!);
      box.write("u_rcode", profile!.data!.referralCode!);
      box.write("u_status", profile!.data!.notificationStatus!);

      return profile;
    } catch (e) {
      Loader.showErroDialog(description: "Something went Wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            primary: true,
            title: Text('My_Account'.tr),
            actions: [
              GestureDetector(
                onTap: () {
                  box.read("user_id") == null
                      ? Get.offAll(const LoginPage())
                      : Get.to(EditProfile(
                          profile!.data!.name!.toString(),
                          profile!.data!.profilePic,
                          profile!.data!.mobile!,
                          profile!.data!.id!.toInt(),
                          profile!.data!.email.toString()));
                },
                child: Container(
                  margin: const EdgeInsets.all(6),
                  height: 30,
                  width: 30,
                  child: SvgPicture.asset(
                    icon_global.icedit,
                    width: 24,
                    color: themeModel.isdark.value
                        ? GlobalData.fullblk
                        : GlobalData.whitecolor,
                  ),
                ),
              )
            ],
          ),
          body: box.read("user_id") != null
              ? FutureBuilder(
                  future: getmyprofile(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(
                                  children: [
                                    ClipOval(
                                      child: FadeInImage(
                                        placeholder:
                                            const AssetImage(icon_global.icprofile),
                                        image: NetworkImage(
                                            profile!.data!.profilePic!),
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              icon_global.icprofile,
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.cover);
                                        },
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(horizontal: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              profile!.data!.profilePic != null
                                                  ? profile!.data!.name!
                                                  : 'User'.tr,
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontFamily: GlobalData
                                                      .fontlistsemibold)),
                                          Text(
                                              profile!.data!.email != null
                                                  ? profile!.data!.email!
                                                  : 'User_mail'.tr,
                                              style: TextStyle(
                                                  fontSize: 17.sp,
                                                  fontFamily: GlobalData
                                                      .fontlistregular)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 1.5.h,
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          Get.to(const SettingsPage());
                                        },
                                        child: buildlisttilecell(
                                            image: icon_global.icsetting,
                                            name: 'Settings'.tr)),
                                    GestureDetector(
                                        onTap: () {
                                          Get.to(const PrivacyPolicy());
                                        },
                                        child: buildlisttilecell(
                                            image: icon_global.icprivacy,
                                            name: 'PrivacyPolicy'.tr)),
                                    GestureDetector(
                                        onTap: () {
                                          Get.to(const AboutUs());
                                        },
                                        child: buildlisttilecell(
                                            image: icon_global.icabout,
                                            name: 'AboutUs'.tr)),
                                    GestureDetector(
                                        onTap: () {
                                          Get.to(HelpContactPage(
                                              profile!.contactinfo!));
                                        },
                                        child: buildlisttilecell(
                                            image:
                                                icon_global.ichelpcontactsus,
                                            name: 'Help_Contact_Us'.tr)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () async {
                                    final Uri url = Uri.parse(
                                        profile!.contactinfo!.facebook!);
                                    if (!await launchUrl(url)) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Image(
                                            image: const AssetImage(
                                                icon_global.icfacebookblack),
                                            width: 7.w,
                                          )))),
                              SizedBox(
                                width: 1.w,
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    final Uri url = Uri.parse(
                                        profile!.contactinfo!.instagram!);
                                    if (!await launchUrl(url)) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Image(
                                            image: const AssetImage(
                                                icon_global.icinstagram),
                                            width: 7.w,
                                          )))),
                              SizedBox(
                                width: 1.w,
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    final Uri url = Uri.parse(
                                        profile!.contactinfo!.linkedin!);
                                    if (!await launchUrl(url)) {
                                      throw 'Could not launch $url';
                                    }
                                  },
                                  child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Image(
                                            image: const AssetImage(
                                                icon_global.iclinkedin),
                                            width: 7.w,
                                          )))),
                              SizedBox(
                                width: 1.w,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  final Uri url =
                                      Uri.parse(profile!.contactinfo!.twitter!);
                                  if (!await launchUrl(url)) {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Center(
                                    child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Image(
                                          image: const AssetImage(
                                              icon_global.ictwitter),
                                          width: 7.w,
                                        ))),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.w,
                          ),
                          Center(
                            child: Text("@Gravityinfotech",
                                style: TextStyle(
                                    fontFamily: GlobalData.fontlistsemibold)),
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Are_you_sure_Logout'.tr),
                                  content: Text(
                                      'Do_you_want_to_Logout_an_App'.tr),
                                  actions: <Widget>[
                                    TextButton(
                                      style: TextButton.styleFrom(),
                                      onPressed: () async {
                                        box.remove("refer");
                                        box.remove("user_id");
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginPage(),
                                                ),
                                                (route) => false);
                                      },
                                      child: Text(
                                        'Yes'.tr,
                                        style: TextStyle(
                                            color: themeModel.isdark.value
                                                ? GlobalData.bluebtn
                                                : GlobalData.fullwhite,
                                            fontSize: 16),
                                      ),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(),
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text(
                                        'No'.tr,
                                        style: TextStyle(
                                            color: themeModel.isdark.value
                                                ? GlobalData.bluebtn
                                                : GlobalData.fullwhite,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 2.h),
                              decoration:
                                  BoxDecoration(color: GlobalData.bluebtn),
                              height: 6.5.h,
                              child: Center(
                                child: Text('Logout'.tr,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontFamily: GlobalData.fontlistmedium,
                                        color: GlobalData.fullwhite)),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return bulidcircu();
                  },
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              ClipOval(
                                child: FadeInImage(
                                  placeholder:
                                      const AssetImage(icon_global.icprofile),
                                  image: const AssetImage(
                                    icon_global.icprofile,
                                  ),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Image.asset(icon_global.icprofile,
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover);
                                  },
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('User'.tr,
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily:
                                                GlobalData.fontlistsemibold)),
                                    Text('User_mail'.tr,
                                        style: TextStyle(
                                            fontSize: 17.sp,
                                            fontFamily:
                                                GlobalData.fontlistregular)),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 1.5.h,
                          ),
                          Column(
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    box.read("user_id") == null
                                        ? Get.offAll(const LoginPage())
                                        : Get.to(const SettingsPage());
                                  },
                                  child: buildlisttilecell(
                                      image: icon_global.icsetting,
                                      name: 'Settings'.tr)),
                              GestureDetector(
                                  onTap: () {
                                    Get.to(const PrivacyPolicy());
                                  },
                                  child: buildlisttilecell(
                                      image: icon_global.icprivacy,
                                      name: 'PrivacyPolicy'.tr)),
                              GestureDetector(
                                  onTap: () {
                                    Get.to(const AboutUs());
                                  },
                                  child: buildlisttilecell(
                                      image: icon_global.icabout,
                                      name: 'AboutUs'.tr)),
                              GestureDetector(
                                  onTap: () {
                                    box.read("user_id") == null
                                        ? Get.offAll(const LoginPage())
                                        : Get.to(HelpContactPage(
                                            profile!.contactinfo!));
                                  },
                                  child: buildlisttilecell(
                                      image: icon_global.ichelpcontactsus,
                                      name: 'Help_Contact_Us'.tr)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Center(
                      child: Text("@Gravityinfotech",
                          style: TextStyle(
                              fontFamily: GlobalData.fontlistsemibold)),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                  ],
                ));
    });
  }
}
