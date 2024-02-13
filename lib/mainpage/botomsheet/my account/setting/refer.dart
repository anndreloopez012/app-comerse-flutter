import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/all_string.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../coman_widget/cman_widget_product.dart';

class ReferEarn extends StatefulWidget {
  const ReferEarn({Key? key}) : super(key: key);

  @override
  State<ReferEarn> createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          GlobalString.abrefer,
        ),
        primary: true,
        elevation: 0,
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
      body: Column(
        children: [
          SizedBox(height: 2.5.h),
          const Image(image: AssetImage(icon_global.icreferimg)),
          Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 35),
              child: Text(
                GlobalString.abrefer,
                style: TextStyle(
                    fontFamily: GlobalData.fontlistbold, fontSize: 16),
              )),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Text(
                "Share this code with a friend and you both could be eligibile for \$20.00 bouns amount under our Referral  Program ",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: GlobalData.fontlistsemibold,
                ),
                textAlign: TextAlign.center),
          ),
          Card(
            margin: const EdgeInsets.only(top: 25, left: 0, right: 0),
            child: SizedBox(
              height: 50,
              width: 70.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(),
                  Text(
                    box.read("u_rcode"),
                    style: TextStyle(
                        fontFamily: GlobalData.fontlistbold,
                        fontSize: 16,
                        color: themeModel.isdark.value
                            ? GlobalData.darkgray
                            : GlobalData.fullwhite),
                  ),
                  SizedBox(
                    height: 40,
                    width: 80,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: GlobalData.bluebtn),
                        onPressed: () {
                          Share.share(
                              'use this code ${box.read("u_rcode")} to register with eCommerce User & get 5.00\$ bonus amount');
                        },
                        child: const Text(GlobalString.btnrefer)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
