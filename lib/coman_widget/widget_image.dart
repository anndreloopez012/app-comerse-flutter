import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Config/thememodel.dart';
ThemeModel themeModel =Get.find<ThemeModel>();
Widget buildSvgimage({
 Color? lightclr,
 Color? drkclr,
  required String imgnem,
  double? widt,
  boxfit
})
{
  return  SvgPicture.asset(imgnem,width: widt,
    color: themeModel.isdark.value
?  lightclr
    : drkclr??GlobalData.fullblk);
}

Widget buildNodata({
  required String imge
}){
  return Center(
    heightFactor:  25,
    widthFactor:  25,
    child: Image(image: AssetImage(imge)),


  );
}
Widget buildNodat({required String imge}){
  return  Align(
    alignment: Alignment.topCenter,
    child: Container(
      margin: EdgeInsets.only(top: 6.h),


      height: 45.h,
      width: 90.w,
      child: Image(
          image: AssetImage(
             imge),
          fit: BoxFit.cover),
    ),
  );
}
