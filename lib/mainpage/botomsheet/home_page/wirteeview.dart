import 'package:customer_ecomerce/Config/all_string.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/mainpage/main_page.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart' as store;
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class WriteReview extends StatefulWidget {
  String? img;
  String? pname;
  String? vid;
  String? pid;

  WriteReview(this.img, this.pname, this.vid, this.pid, {super.key});

  @override
  State<WriteReview> createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  store.GetStorage box = store.GetStorage();
  success_or_no_model? suc;
  String retings = "1";
  TextEditingController mes = TextEditingController();
  String messge = "";

  Future orderreviewapi() async {
    Loader.showLoading();
    try {
      var map = {
        "user_id": box.read('user_id'),
        "ratting": retings,
        "comment": messge,
        "vendor_id": widget.vid,
        "product_id": widget.pid
      };

      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlwritereview, data: map);

      suc = success_or_no_model.fromJson(response.data);
      Loader.hideLoading();
      if (suc!.status == 1) {
        Fluttertoast.showToast(
          msg: suc!.message!,
          toastLength: Toast.LENGTH_SHORT,
        );

        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return MainPages(0);
          },
        ), (route) => false);
      } else {
        Fluttertoast.showToast(
          msg: suc!.message!,
          toastLength: Toast.LENGTH_SHORT,
        );
      }

      return suc;
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
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
            title: Text("WriteReview".tr),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 1.5.h),
                Image(
                  image: NetworkImage(widget.img!),
                  fit: BoxFit.fill,
                  height: 36.h,
                  width: double.infinity,
                ),
                SizedBox(height: 1.5.h),
                Text(
                  widget.pname!,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: GlobalData.fontlistsemibold,
                  ),
                ),
                SizedBox(height: 1.5.h),
                RatingBar.builder(
                  initialRating: 1,
                  minRating: 1,
                  glow: false,
                  direction: Axis.horizontal,
                  // allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: GlobalData.bluebtn,
                  ),
                  onRatingUpdate: (rating) {
                    retings = rating.toString();

                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    maxLines: 5,
                    controller: mes,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: GlobalData.ofwhite),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: GlobalData.ofwhite)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: GlobalData.ofwhite),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        hintText: "Write_your_Review".tr,
                        hintStyle: TextStyle(
                            fontSize: 16.sp,
                            fontFamily: GlobalData.fontlistregular),
                        fillColor: themeModel.isdark.value
                            ? GlobalData.fullwhite
                            : GlobalData.fullblk,
                        filled: true,
                        focusColor: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: GestureDetector(
            onTap: () {
              messge = mes.text;
              setState(() {
                if (messge.isEmpty) {
                  Fluttertoast.showToast(
                    msg: GlobalString.givereting,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                } else if (retings.isEmpty) {
                  Fluttertoast.showToast(
                    msg: GlobalString.givereting,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                } else {
                  orderreviewapi();
                }
              });
            },
            child: Container(
              color: GlobalData.bluebtn,
              height: 7.h,
              width: double.infinity,
              child: Center(
                  child: Text(
                "Submit".tr,
                style: TextStyle(
                    color: GlobalData.fullwhite,
                    fontFamily: GlobalData.fontlistsemibold,
                    fontSize: 18.sp),
              )),
            ),
          ),
        );
      },
    );
  }
}
