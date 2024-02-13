import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../api/all_model/success_or_not.dart';

GetStorage box = GetStorage();
ThemeModel themeModel = Get.find<ThemeModel>();

success_or_no_model? favorite;

Widget buildtrendingproductcell(
    {required String productImage,
    required String productName,
    required String productPrice,
    required String productdiscountprice,
    required String ret,
    // ignore: avoid_types_as_parameter_names
    widget}) {
  return Container(
    width: 45.w,
    decoration: BoxDecoration(
        border: GlobalRadious.border,
        borderRadius: const BorderRadius.all(Radius.circular(10))),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: 26.5.h,
          width: 45.w,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(productImage), fit: BoxFit.fill),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child: Stack(
            alignment: Alignment.topRight,
            children: [widget],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(productName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontFamily: GlobalData.fontlistmedium,
                          fontSize: 16.sp)),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Image(
                          image: const AssetImage(icon_global.icfillstar),
                          width: 16,
                          color: GlobalData.orange),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(ret)
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text(
                          box.read("pos") == "right"
                              ? GlobalData.formatCurrency.format(double.parse(productPrice)) + box.read("doller")
                              : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(productPrice))}",
                          style: TextStyle(
                              fontFamily: GlobalData.fontlistsemibold,
                              fontSize: 16.sp)),
                      SizedBox(
                        width: 1.w,
                      ),
                      Text(
                          productdiscountprice != "0"
                              ? box.read("pos") == "right"
                                  ? GlobalData.formatCurrency.format(double.parse(productdiscountprice)) + box.read("doller")
                                  : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(productdiscountprice))}"
                              : "",
                          style: TextStyle(
                              fontFamily: GlobalData.fontlistregular,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14.5.sp)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget buildlisttilecell(
    {String? image,
    required String name,
    String? fontfmly,
    Color? bgclr,
    leadwidg,
    widd}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: ListTile(
        dense: true,
        visualDensity: const VisualDensity(vertical: 1),
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.white38, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        tileColor: themeModel.isdark.value
            ? bgclr ?? GlobalData.whitecolor
            : GlobalData.fullblk,
        minLeadingWidth: 0,
        horizontalTitleGap: 4.w,
        leading: widd ??
            SvgPicture.asset(image!,
                width: 24,
                color: themeModel.isdark.value
                    ? GlobalData.fullblk
                    : GlobalData.whitecolor,
                fit: BoxFit.fill),
        title: Text(name,
            style: TextStyle(
                fontSize: 16.sp,
                fontFamily: fontfmly ?? GlobalData.fontlistmedium)),
        trailing: leadwidg ??
            Icon(
              Icons.keyboard_arrow_right_outlined,
              size: 30,
              color: themeModel.isdark.value
                  ? Colors.black54
                  : GlobalData.fullwhite,
            )),
  );
}

Widget bulidcircu() {
  return Center(
    child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: GlobalData.fullwhite,
        ),
        child: Center(
          child: SizedBox(
              child: CircularProgressIndicator(color: GlobalData.bluebtn)),
        )),
  );
}

Widget buildpostextprice(
    {required String productprice,
    String? fontfmly,
    required double fsize,
    textdecora}) {
  return Text(
      productprice != "0"
          ? box.read("pos") == "right"
              ? GlobalData.formatCurrency.format(double.parse(productprice)) + box.read("doller")
              : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(productprice))}"
          : "",
      style: TextStyle(
          fontFamily: fontfmly ?? GlobalData.fontlistregular,
          decoration: textdecora ?? TextDecoration.none,
          fontSize: fsize));
}
