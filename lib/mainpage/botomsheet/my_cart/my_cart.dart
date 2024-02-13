import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/coman_widget/widget_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../api/all_model/cart_model.dart';
import '../../../coman_widget/cman_widget_product.dart';
import '../home_page/products_details.dart';
import 'chekout_page.dart';

class MyCartPage extends StatefulWidget {
  const MyCartPage({Key? key}) : super(key: key);

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  cart_model? cart;
  success_or_no_model? favorite;
  int count = 0;
  int? qty;

  double pri = 0.0;

  Future chekoutapi() async {
    try {
      var map = {"user_id": box.read('user_id')};
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlgetcart, data: map);

      var finallist = await response.data;
      cart = cart_model.fromJson(finallist);
      return cart;
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);
    }
  }

  add(int index, bool isplus) async {
    Loader.showLoading();
    try {
      if (isplus) {
        setState(() {
          pri = double.parse(cart!.data![index].price!.toString()) *
              int.parse(cart!.data![index].qty!);
          qty = int.parse(cart!.data![index].qty!) + 1;
        });
      } else {
        if (qty == 1) {
          Loader.hideLoading();
        } else {
          setState(() {
            pri = double.parse(cart!.data![index].price!.toString()) *
                int.parse(cart!.data![index].qty!);
            qty = int.parse(cart!.data![index].qty!) - 1;
          });
        }
      }
      var map = {"cart_id": cart!.data![index].id, "qty": qty.toString()};
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlqtyupdate, data: map);
      var finallist = await response.data;
      favorite = success_or_no_model.fromJson(finallist);
      setState(() {});
      Loader.hideLoading();
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);
    }
  }

  delet(int index) async {
    Loader.showLoading();
    try {
      var map = {
        "cart_id": cart!.data![index].id,
        "user_id": box.read('user_id')
      };
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urldeletcart, data: map);
      var finallist = await response.data;
      favorite = success_or_no_model.fromJson(finallist);
      setState(() {});
      Loader.hideLoading();
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
              title: Text("My_Cart".tr),
            ),
            body: FutureBuilder(
              future: chekoutapi(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (cart!.data!.isEmpty) {
                    return buildNodata(imge: icon_global.iccartnodata);
                  }
                  return Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 12, left: 12),
                            height: 74.5.h,
                            child: ListView.separated(
                              separatorBuilder: (context, index) {
                                return Divider(
                                  color: GlobalData.darkgray,
                                  height: 0.5,
                                );
                              },
                              itemCount: cart!.data!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Get.to(ProdutsDetails(
                                      cart!.data![index].productId!,
                                      cart!.data![index].productName!,
                                    ));
                                  },
                                  child: Slidable(
                                    endActionPane: ActionPane(
                                        extentRatio: 0.25,
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (context) {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return Container(
                                                    alignment: Alignment.center,
                                                    height: 40.h,
                                                    width: double.infinity,
                                                    color: themeModel
                                                            .isdark.value
                                                        ? GlobalData.fullwhite
                                                        : GlobalData.fullblk,
                                                    margin: const EdgeInsets.only(
                                                        left: 12, right: 12),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 50,
                                                          width: 50,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              icon: const Icon(
                                                                  Icons.close)),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets.only(
                                                                  left: 12,
                                                                  right: 12),
                                                          child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                    child: Image(
                                                                        image: const AssetImage(icon_global
                                                                            .iccancelround),
                                                                        width: 30
                                                                            .w)),
                                                                SizedBox(
                                                                  height: 1.5.h,
                                                                ),
                                                                SizedBox(
                                                                  child: Text(
                                                                    "Remove_Product"
                                                                        .tr,
                                                                    style: TextStyle(
                                                                        fontSize: 18
                                                                            .sp,
                                                                        fontFamily:
                                                                            GlobalData.fontlistsemibold),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  height: 8,
                                                                ),
                                                                SizedBox(
                                                                  child: Text(
                                                                    "Are_you_sure_to_Remove_the_product_from_your_order"
                                                                        .tr,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        fontSize: 16
                                                                            .sp,
                                                                        fontFamily:
                                                                            GlobalData.fontlistmedium),
                                                                  ),
                                                                )
                                                              ]),
                                                        ),
                                                        const Spacer(),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                            delet(index);
                                                          },
                                                          child: Container(
                                                            height: 5.5.h,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom:
                                                                        1.5.h),
                                                            width:
                                                                double.infinity,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    GlobalRadious
                                                                        .radious_,
                                                                color: GlobalData
                                                                    .fullblk),
                                                            child: Center(
                                                              child: Text(
                                                                "Proceed".tr,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        GlobalData
                                                                            .fontlistsemibold,
                                                                    color: GlobalData
                                                                        .fullwhite,
                                                                    fontSize:
                                                                        18.sp),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            backgroundColor: GlobalData.red,
                                            foregroundColor: Colors.white,
                                            label: 'Delete'.tr,
                                          ),
                                        ]),
                                    child: Container(
                                      height: 11.8.h,
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(top: 8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.5,
                                              color: GlobalData.whitecolor),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 20.w,
                                            height: 10.h,
                                            decoration: BoxDecoration(
                                                borderRadius: const BorderRadius.all(
                                                    Radius.circular(8)),
                                                image: DecorationImage(
                                                    image: NetworkImage(cart!
                                                        .data![index]
                                                        .imageUrl!),
                                                    fit: BoxFit.fill)),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                        child: Text(
                                                      cart!.data![index]
                                                          .productName!,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: GlobalData
                                                            .fontlistbold,
                                                      ),
                                                    )),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  Container(
                                                    margin: const EdgeInsets.only(
                                                        left: 0,
                                                        right: 0,
                                                        top: 6),
                                                    child: Row(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                                cart!.data![index].attribute !=
                                                                        null
                                                                    ? cart!
                                                                        .data![
                                                                            index]
                                                                        .attribute!
                                                                    : "Size : ",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        GlobalData
                                                                            .fontlistregular)),
                                                            Text(
                                                                cart!.data![index].variation !=
                                                                        null
                                                                    ? cart!
                                                                        .data![
                                                                            index]
                                                                        .variation!
                                                                    : "-",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        GlobalData
                                                                            .fontlistregular)),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: SizedBox(
                                                            child: buildpostextprice(
                                                                productprice: pri ==
                                                                        0.0
                                                                    ? cart!
                                                                        .data![
                                                                            index]
                                                                        .price!
                                                                    : pri
                                                                        .toString(),
                                                                fsize: 16.sp,
                                                                fontfmly: GlobalData
                                                                    .fontlistsemibold)),
                                                      ),
                                                      SizedBox(
                                                        height: 2.5.h,
                                                        width: 24.w,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                if (cart!.data![index].qty.toString() == "1") {
                                                                  pri = double.parse(cart!
                                                                          .data![
                                                                              index]
                                                                          .price!
                                                                          .toString()) *
                                                                      int.parse(cart!
                                                                          .data![
                                                                              index]
                                                                          .qty!);
                                                                }
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                          width:
                                                                              0.5),
                                                                  color: themeModel
                                                                          .isdark
                                                                          .value
                                                                      ? Colors
                                                                          .transparent
                                                                      : GlobalData
                                                                          .whitecolor,
                                                                ),
                                                                width: 5.w,
                                                                height: 2.2.h,
                                                                child: const Center(
                                                                    child: Padding(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                0),
                                                                        child: Text(
                                                                            "-"))),
                                                              ),
                                                            ),
                                                            Text(cart!
                                                                .data![index]
                                                                .qty!),
                                                            GestureDetector(
                                                              onTap: () {
                                                                add(index,
                                                                    true);
                                                                pri = double.parse(cart!
                                                                        .data![
                                                                            index]
                                                                        .price!
                                                                        .toString()) *
                                                                    int.parse(cart!
                                                                        .data![
                                                                            index]
                                                                        .qty!);
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                          width:
                                                                              0.5),
                                                                  color: themeModel
                                                                          .isdark
                                                                          .value
                                                                      ? Colors
                                                                          .transparent
                                                                      : GlobalData
                                                                          .whitecolor,
                                                                ),
                                                                width: 5.w,
                                                                height: 2.2.h,
                                                                child: const Center(
                                                                    child: Padding(
                                                                        padding:
                                                                            EdgeInsets.all(
                                                                                0),
                                                                        child: Text(
                                                                            "+"))),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(CheckOutPage());
                        },
                        child: Container(
                          decoration: BoxDecoration(color: GlobalData.bluebtn),
                          height: 6.5.h,
                          child: Center(
                            child: Text("Checkout".tr,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: GlobalData.fontlistmedium,
                                    color: GlobalData.fullwhite)),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return bulidcircu();
              },
            ));
      },
    );
  }
}
