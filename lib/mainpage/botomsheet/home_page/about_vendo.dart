import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/coman_widget/widget_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart' as store;
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../api/all_model/vendors_produt_model.dart';

// ignore: must_be_immutable
class AboutVendor extends StatefulWidget {
  Vendordetails?vdetails;
  String?name;
  String?image;

  AboutVendor(this.vdetails,this.name,this.image, {super.key});

  @override
  State<AboutVendor> createState() => _AboutVendorState();
}

class _AboutVendorState extends State<AboutVendor> {
  ThemeModel themeModel = Get.find<ThemeModel>();

  store.GetStorage box = store.GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(
      builder: (controller) {
        return Scaffold(
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
            title: Text("About".tr),

          ),
          body: Container(
            margin: const EdgeInsets.only(right: 12, left: 12),
            child:
            Column(
              children: [
                Container(
                  height: 11.h,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 0.5,
                          color: GlobalData.whitecolor),

                      borderRadius: const BorderRadius.all(
                          Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 22.w,
                        decoration: BoxDecoration(
                            borderRadius:const BorderRadius.all(Radius.circular(8)),
                            image: widget.image!
                                .isEmpty
                                ? const DecorationImage(
                                image: AssetImage(
                                    icon_global.icmans),
                                fit: BoxFit.cover)
                                : DecorationImage(
                                image: NetworkImage(
                                    widget.image!),
                                fit: BoxFit.fill)),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10,),
                          child: Column(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child:
                                    Text(
                                      widget.name!,
                                      maxLines: 1,
                                      overflow:
                                      TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontFamily: GlobalData.fontlistsemibold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [

                                  Image(
                                      image: const AssetImage(
                                          icon_global
                                              .icfillstar),
                                      width: 16,
                                      color: GlobalData
                                          .orange),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  SizedBox(
                                    child: Text(
                                    widget.vdetails!.rattings!.isNotEmpty?"${  widget.vdetails!.rattings![0].avgRatting}":"0.0" ,

                                    ),
                                  ),

                                ],
                              ),

                              Container(
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: buildSvgimage(imgnem: icon_global.iccall,lightclr: GlobalData.darkgray)),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        widget.vdetails!.mobile ==
                                            null
                                            ? "Mobile_no".tr
                                            : widget.vdetails!.mobile!,
                                        overflow:
                                        TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontFamily: GlobalData
                                              .fontlistregular,
                                          fontSize: 16.sp,
                                          color: themeModel.isdark.value
                                              ? GlobalData.fullblk
                                              : GlobalData
                                              .fullwhite,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 1.5.h,),
                Row(
                  children: [
                    SizedBox(
                        height: 20,
                        width: 20,
                        child: buildSvgimage(imgnem: icon_global.icaadre,lightclr: GlobalData.darkgray)),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: 85.w,
                      child: Text(
                        widget.vdetails!.storeAddress ==
                            null
                            ? "Adddress".tr
                            : widget.vdetails!.storeAddress!,
                        overflow:
                        TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: GlobalData
                              .fontlistregular,
                          fontSize: 16.sp,
                          color: themeModel.isdark.value
                              ? GlobalData.fullblk
                              : GlobalData
                              .fullwhite,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.5.h,),
                Row(
                  children: [
                    SizedBox(
                        height: 20,
                        width: 20,
                        child: buildSvgimage(imgnem: icon_global.icmail,lightclr: GlobalData.darkgray)),
                    const SizedBox(
                      width: 8,
                    ),
                    SizedBox(
                      width: 85.w,
                      child: Text(
                        widget.vdetails!.email ==
                            null
                            ? "E_mail".tr
                            : widget.vdetails!.email!,
                        overflow:
                        TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontFamily: GlobalData
                              .fontlistregular,
                          fontSize: 16.sp,
                          color: themeModel.isdark.value
                              ? GlobalData.fullblk
                              : GlobalData
                              .fullwhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )

          ),
        );
      },
    );
  }
}
