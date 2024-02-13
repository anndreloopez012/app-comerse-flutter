import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/coman_widget/cman_widget_product.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class Loader {
  // show error; Dialog
  static void showErroDialog(
      {String title = 'E-Commerce',
        String? description = 'Something went wrong'}) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18),
              ),
              Text(
                description ?? '',
                style: const TextStyle(fontSize: 16),
              ),
              TextButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: Text(
                  'Ok',
                  style: TextStyle(color: GlobalData.fullblk, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show toast
  //show snack bar
  //show loading
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(color: GlobalData.bluebtn),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static void showLoading([String? message]) {
    Get.dialog(

        bulidcircu()
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }

  showloding([String? message]) {
    showLoading(message);
  }

  hideloading() {
    hideLoading();
  }
}
