import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../main_page.dart';


class SucessFully extends StatefulWidget {
  const SucessFully({super.key});

  @override
  State<SucessFully> createState() => _SucessFullyState();
}

class _SucessFullyState extends State<SucessFully> {
  GetStorage box= GetStorage();
  _onWillPop() async {
    return (Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPages(0),
        )));
  }

  refresh(dynamic) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: const AssetImage(icon_global.icsuccessorder),width: 90.w),
            Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 10),
                child: Text(
                  "Order_Success".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: GlobalData.fontlistmedium, fontSize: 25),
                )),

            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 20, left: 12, right: 12),
              child: Text(
                  "Your_Packet_will_be_send_to_your_address_Thanks_for_order".tr,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontFamily: GlobalData.fontlistregular,
                  ),
                  textAlign: TextAlign.center),
            ),
          ],
        ),
        bottomSheet: Container(
          alignment: Alignment.center,
          height: 6.5.h,
          width: double.infinity,
          color: GlobalData.bluebtn,
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return MainPages(0);
                },
              )).then((value) => refresh(value));
            },
            child: Text("Continue_Shopping".tr,
                style: TextStyle(
                    color: GlobalData.fullwhite,
                    fontSize: 16,
                    fontFamily: GlobalData.fontlistsemibold)),
          ),
        ),
      ),
      onWillPop: () {
        return _onWillPop();
      },
    );
  }
}
