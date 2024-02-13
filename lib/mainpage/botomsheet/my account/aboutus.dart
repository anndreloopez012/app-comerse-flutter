import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/coman_widget/cman_widget_product.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../api/all_model/about_us_model.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  cmpspage? cmpage;

  Future gethomepage() async {
    try {
      var response =
          await Dio().get(default_API.baseUrl + post_api.urlcmpage);
      var finallist = await response.data;
      cmpage = cmpspage.fromJson(finallist);
      return cmpage;
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: "Something went wrong");
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
              title: Text(
                "AboutUs".tr,
              ),
              primary: true,
              leadingWidth: 40,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_outlined,
                  )),
            ),
            body: FutureBuilder(
              future: gethomepage(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return cmpage!.message!.isNotEmpty
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          margin: const EdgeInsets.only(left: 12, right: 12, top: 10),
                          child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      child: Text(
                                    cmpage!.about!,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                        color: themeModel.isdark.value
                                            ? GlobalData.darkgray
                                            : GlobalData.fullwhite,
                                        fontSize: 16.5.sp,
                                        fontFamily: GlobalData.fontlistregular),
                                  )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ]),
                          ),
                        )
                      : const SizedBox(
                          height: 500,
                          width: 500,
                          child: Image(
                              image:
                                  AssetImage("image/${icon_global.icnodata}"),
                              fit: BoxFit.cover),
                        );
                } //if conditon
                return bulidcircu();
              },
            ));
      },
    );
  }
}
