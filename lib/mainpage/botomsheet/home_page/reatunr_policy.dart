import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ReaturnPolicy extends StatefulWidget {
  String? returnpolicy;

  ReaturnPolicy(this.returnpolicy, {super.key});

  @override
  State<ReaturnPolicy> createState() => _ReaturnPolicyState();
}

class _ReaturnPolicyState extends State<ReaturnPolicy> {
  ThemeModel themeModel = Get.find<ThemeModel>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            primary: true,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
            title: Text("Return_policies".tr),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12),
            child: SingleChildScrollView(
                child: Text(widget.returnpolicy!,
                    style: TextStyle(fontFamily: GlobalData.fontlistregular))),
          ),
        );
      },
    );
  }
}
