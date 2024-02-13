import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/coman_widget/cman_widget_product.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../api/all_model/order_return_conditon.dart';

// ignore: must_be_immutable
class ReturnRequest extends StatefulWidget {
  String? orderid;

  ReturnRequest(this.orderid, {super.key});

  @override
  State<ReturnRequest> createState() => _ReturnRequestState();
}

class _ReturnRequestState extends State<ReturnRequest> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  TextEditingController note = TextEditingController();
  String cmt = "";
  // ignore: prefer_typing_uninitialized_variables
  var conditon;
  GetStorage box = GetStorage();
  int? selectedindex;
  int? selectindex;
  success_or_no_model? suss;
  return_condition? rtncon;

  Future orderrtnconapi() async {
    try {
      var map = {"user_id": box.read('user_id'), "order_id": widget.orderid!};

      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlreturnconditions, data: map);
      
      rtncon = return_condition.fromJson(response.data);
      return rtncon;
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);
    }
  }

  Future orderrtnreq() async {
    Loader.showLoading();
    try {
      var map = {
        "user_id": box.read('user_id'),
        "order_id": widget.orderid!,
        "return_reason": conditon,
        "comment": cmt,
        "status": "7"
      };

      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlreturnrequest, data: map);
      
      Loader.hideLoading();
      suss = success_or_no_model.fromJson(response.data);
      if (suss!.status == 1) {
        Fluttertoast.showToast(msg: suss!.message!);
        Get.back();
      } else {
        Fluttertoast.showToast(msg: suss!.message!);
      }
      return suss;
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
          appBar: AppBar(
            primary: true,
            automaticallyImplyLeading: false,
            title: Text("ReturnRequest".tr),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: FutureBuilder(
              future: orderrtnconapi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          height: 11.h,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 24.w,
                                decoration: BoxDecoration(
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(10)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            rtncon!.orderInfo!.imageUrl!),
                                        fit: BoxFit.fill)),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          rtncon!.orderInfo!.productName!,
                                          maxLines: 1,
                                          overflow: TextOverflow.clip,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontFamily: GlobalData.fontlistbold,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              Text("Size ",
                                                  style: TextStyle(
                                                    color: themeModel
                                                            .isdark.value
                                                        ? GlobalData.darkgray
                                                        : GlobalData.fullblk,
                                                  )),
                                              Text(
                                                  rtncon!.orderInfo!
                                                              .variation !=
                                                          null
                                                      ? ": ${rtncon!.orderInfo!
                                                              .variation!}"
                                                      : " ",
                                                  style: TextStyle(
                                                    color: themeModel
                                                            .isdark.value
                                                        ? GlobalData.darkgray
                                                        : GlobalData.fullblk,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "Qty : ${rtncon!.orderInfo!.qty!}",
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                color: themeModel.isdark.value
                                                    ? GlobalData.darkgray
                                                    : GlobalData.fullblk,
                                              )),
                                          const Spacer(),
                                          Text(
                                              box.read("pos") == "right"
                                                  ? GlobalData.formatCurrency.format(
                                                          double.parse(rtncon!
                                                              .orderInfo!
                                                              .price!)) +
                                                      box.read("doller")
                                                  : box.read("doller") +
                                                      GlobalData.formatCurrency
                                                          .format(double.parse(
                                                              rtncon!
                                                                  .orderInfo!
                                                                  .price!)),
                                              style: TextStyle(
                                                  fontFamily:
                                                      GlobalData.fontlistsemibold,
                                                  fontSize: 16.sp)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 2.5.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: SizedBox(
                            height: 12.h * rtncon!.data!.length,
                            width: double.infinity,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: rtncon!.data!.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedindex = index;
                                    });
                                    conditon =
                                        rtncon!.data![index].returnConditions!;
                                    selectindex = index;
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.only(top: 10),
                                      height: 80,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: GlobalData.fullwhite),
                                          color: themeModel.isdark.value
                                              ? GlobalData.whitecolor
                                              : GlobalData.fullblk,
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 6),
                                            child: ListTile(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              tileColor: themeModel.isdark.value
                                                  ? GlobalData.whitecolor
                                                  : GlobalData.fullblk,
                                              minLeadingWidth: 0,
                                              horizontalTitleGap: 4.w,
                                              trailing: selectedindex == index
                                                  ? const Image(
                                                      image: AssetImage(
                                                          icon_global.icpaymnetselect),
                                                      width: 20,
                                                    )
                                                  : const SizedBox(
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                              title: Text(
                                                  rtncon!.data![index]
                                                      .returnConditions!,
                                                  style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontFamily: GlobalData
                                                          .fontlistmedium)),
                                            ),
                                          ))),
                                );
                              },
                            )),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: Text(
                          "Note".tr,
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontFamily: GlobalData.fontlistsemibold),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        child: TextField(
                          controller: note,
                          maxLines: 5,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white38),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.white38)),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white38),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              hintText: "Writte_Comments(optional)".tr,
                              hintStyle: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: GlobalData.fontlistregular,
                                color: themeModel.isdark.value
                                    ? GlobalData.darkgray
                                    : GlobalData.whitecolor,
                              ),
                              fillColor: themeModel.isdark.value
                                  ? GlobalData.whitecolor
                                  : GlobalData.fullblk,
                              filled: true,
                              focusColor: Colors.white),
                        ),
                      ),
                      SizedBox(height: 10.h),
                    ],
                  );
                }
                return bulidcircu();
              },
            ),
          ),
          bottomSheet: GestureDetector(
            onTap: () {
              cmt = note.text;
              setState(() {
                if (selectedindex == null) {
                  Fluttertoast.showToast(
                    msg: "Please_select_return_condition".tr,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                } else {
                  orderrtnreq();
                }
              });
            },
            child: Container(
              color: GlobalData.bluebtn,
              height: 7.h,
              width: double.infinity,
              child: Center(
                  child: Text(
                "Submit_ReturnRequest".tr,
                style: TextStyle(
                    color: GlobalData.fullwhite,
                    fontFamily: GlobalData.fontlistsemibold,
                    fontSize: 16.sp),
              )),
            ),
          ),
        );
      },
    );
  }
}
