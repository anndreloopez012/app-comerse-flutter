import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/coman_widget/widget_image.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/my%20account/setting/add_money.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_plus/pull_to_refresh_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../api/all_model/walet_model.dart';
import '../../../../coman_widget/cman_widget_product.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  late int totalPages;
  late int totalPa;
  late int too;
  late int tos;
  List<Datasub> passengers = [];
  bool isRefresh = false;
  bool mss = false;
  int type = 0;
  int currentPage = 1;
  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

  Future<bool> viewallapi({isRefresh = false}) async {
    Loader.showLoading();

    if (isRefresh) {
      currentPage = 1;
    } else {
      if (too == totalPages) {
        Loader.hideLoading();
        refreshController.loadNoData();
        return false;
      }
    }
    Map map = {"user_id": box.read('user_id')};
    var response = await Dio().post(
        "${default_API.baseUrl + post_api.urlwallet}?page=$currentPage",
        data: map);
    Loader.hideLoading();
    if (response.statusCode == 200) {
      var result = await response.data;
      walet = WalletModel.fromJson(result);
      if (isRefresh) {
        passengers = walet!.data!.data!;
      } else {
        passengers.addAll(walet!.data!.data!);
      }
      currentPage++;
      totalPages = walet!.data!.total!;
      too = walet!.data!.to!;
     
      setState(() {
        mss = true;
      });
      return true;
    } else {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);
      return false;
    }
  }

  WalletModel? walet;

  waletapi() async {
    try {
      var map = {"user_id": box.read('user_id')};
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlwallet, data: map);
     
      var finallist = await response.data;
      walet = WalletModel.fromJson(finallist);
     
      Loader.hideLoading();
      return walet;
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
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'My_Wallet'.tr,
            ),
            primary: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
            actions: const [],
          ),
          body: Column(
            children: [
              FutureBuilder(
                future: waletapi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 16.h,
                          decoration: BoxDecoration(
                              borderRadius: GlobalRadious.radious_,
                              color: themeModel.isdark.value
                                  ? GlobalData.whitecolor
                                  : GlobalData.fullblk,
                              border: GlobalRadious.border),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 6.w,
                              ),
                              ClipOval(
                                  child: buildSvgimage(
                                      imgnem: icon_global.icwallet,
                                      widt: 20.w)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('My_Wallet_Balance'.tr,
                                        style: TextStyle(
                                            fontSize: 17.5.sp,
                                            fontFamily:
                                                GlobalData.fontlistregular)),
                                    buildpostextprice(
                                      productprice:
                                          walet!.walletamount!.toString(),
                                      fsize: 19.sp,
                                      fontfmly: GlobalData.fontlistsemibold,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 12, right: 12, top: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: GlobalData.greencolor,
                                        borderRadius: GlobalRadious.radious_),
                                    height: 9.h,
                                    width: 18.w,
                                    child: Center(
                                        child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Image(
                                              image: const AssetImage(
                                                  icon_global.icorder),
                                              color: GlobalData.whitecolor,
                                            ))),
                                  ),
                                  Center(
                                    child: Text('order'.tr,
                                        style: TextStyle(
                                            color: themeModel.isdark.value
                                                ? GlobalData.fullblk
                                                : GlobalData.fullwhite,
                                            fontFamily:
                                                GlobalData.fontlistregular)),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: GlobalData.darkpink,
                                        borderRadius: GlobalRadious.radious_),
                                    height: 9.h,
                                    width: 18.w,
                                    child: Center(
                                        child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: buildSvgimage(
                                                imgnem: icon_global.icwallet,
                                                widt: 20.w,
                                                lightclr:
                                                    GlobalData.fullwhite))),
                                  ),
                                  Center(
                                    child: Text('Wallet_in'.tr,
                                        style: TextStyle(
                                            color: themeModel.isdark.value
                                                ? GlobalData.fullblk
                                                : GlobalData.fullwhite,
                                            fontFamily:
                                                GlobalData.fontlistregular)),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: GlobalData.darkred,
                                        borderRadius: GlobalRadious.radious_),
                                    height: 9.h,
                                    width: 18.w,
                                    child: Center(
                                        child: Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: Image(
                                              image: const AssetImage(icon_global
                                                  .icordercancelledpackage),
                                              color: GlobalData.whitecolor,
                                            ))),
                                  ),
                                  Center(
                                    child: Text('Cancel'.tr,
                                        style: TextStyle(
                                            color: themeModel.isdark.value
                                                ? GlobalData.fullblk
                                                : GlobalData.fullwhite,
                                            fontFamily:
                                                GlobalData.fontlistregular)),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            'Transaction_History'.tr,
                            style: TextStyle(
                                fontFamily: GlobalData.fontlistsemibold,
                                fontSize: 19.sp),
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 12,
                  left: 12,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    height: 52.h,
                    margin: const EdgeInsets.only(top: 0),
                    child: SmartRefresher(
                      controller: refreshController,
                      primary: true,
                      header: CustomHeader(
                        builder: (context, mode) {
                          if (mode == LoadStatus.loading) {
                            const Center(
                              child: Center(),
                            );
                          }
                          return const Center();
                        },
                      ),
                      footer: CustomFooter(
                        builder: (context, mode) {
                          Widget body;
                          if (mode == LoadStatus.loading) {
                            body = const Center(child: Center());
                          } else {
                            body = const Text("");
                          }
                          return SizedBox(
                            height: 55.0,
                            child: Center(child: body),
                          );
                        },
                      ),
                      enablePullUp: true,
                      enablePullDown: mss == false ? true : false,
                      onRefresh: () async {
                        final result = await viewallapi(isRefresh: true);
                        if (result) {
                          refreshController.refreshCompleted();
                        } else {
                          refreshController.refreshFailed();
                        }
                      },
                      onLoading: () async {
                        final result = await viewallapi();
                        if (result) {
                          refreshController.loadComplete();
                        } else {
                          refreshController.loadNoData();
                        }
                      },
                      child: passengers.isNotEmpty
                          ? ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 1.h,
                                );
                              },
                              itemCount: passengers.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 8.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: GlobalData.whitecolor,
                                          width: 0.5),
                                      borderRadius: GlobalRadious.radious_),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: passengers[index]
                                                        .transactionType ==
                                                    "1"
                                                ? GlobalData.darkred
                                                : passengers[index]
                                                            .transactionType ==
                                                        "2"
                                                    ? GlobalData.green
                                                    : passengers[index]
                                                                .transactionType ==
                                                            "3"
                                                        ? GlobalData.darkpink
                                                        : passengers[index]
                                                                    .transactionType ==
                                                                "4"
                                                            ? GlobalData
                                                                .darkpink
                                                            : GlobalData
                                                                .darkpink,
                                            borderRadius:
                                                GlobalRadious.radious_),
                                        height: 8.h,
                                        width: 17.w,
                                        child: Center(
                                            child: Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Image(
                                                  image: AssetImage(passengers[
                                                                  index]
                                                              .transactionType ==
                                                          "1"
                                                      ? icon_global
                                                          .icordercancel
                                                      : passengers[index]
                                                                  .transactionType ==
                                                              "2"
                                                          ? icon_global
                                                              .icorderconfirmed
                                                          : passengers[index]
                                                                      .transactionType ==
                                                                  "3"
                                                              ? icon_global
                                                                  .icwalletpaymnet
                                                              : passengers[index]
                                                                          .transactionType ==
                                                                      "4"
                                                                  ? icon_global
                                                                      .icwalletpaymnet
                                                                  : icon_global
                                                                      .icorder),
                                                  color: GlobalData.fullwhite,
                                                ))),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    passengers[index]
                                                                .transactionType ==
                                                            "1"
                                                        ? "Order id : ${passengers[index].orderNumber!}"
                                                        : passengers[index]
                                                                    .transactionType ==
                                                                "2"
                                                            ? "Order id : ${passengers[index].orderNumber!}"
                                                            : passengers[index]
                                                                        .transactionType ==
                                                                    "3"
                                                                ? "User Name : ${passengers[index].username!}"
                                                                : passengers[index]
                                                                            .transactionType ==
                                                                        "4"
                                                                    ? 'Wallet_Reacharge'
                                                                        .tr
                                                                    : 'Wallet_Reacharge'
                                                                        .tr,
                                                    style: TextStyle(
                                                      fontFamily: GlobalData
                                                          .fontlistsemibold,
                                                      fontSize: 16.sp,
                                                      color: themeModel
                                                              .isdark.value
                                                          ? GlobalData.fullblk
                                                          : GlobalData
                                                              .fullwhite,
                                                    ),
                                                  ),
                                                  Text(
                                                    formateddatelist(
                                                        passengers[index].date),
                                                    style: TextStyle(
                                                      fontFamily: GlobalData
                                                          .fontlistregular,
                                                      fontSize: 12,
                                                      color: themeModel
                                                              .isdark.value
                                                          ? GlobalData.ofblack
                                                          : GlobalData
                                                              .fullwhite,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 0.5.h),
                                              Row(children: [
                                                Text(
                                                  passengers[index].type == "1"
                                                      ? "Cash".tr
                                                      : passengers[index]
                                                                  .type ==
                                                              "2"
                                                          ? "wallet".tr
                                                          : passengers[index]
                                                                      .type ==
                                                                  "3"
                                                              ? "RazorPay".tr
                                                              : passengers[index]
                                                                          .type ==
                                                                      "4"
                                                                  ? "Stripe".tr
                                                                  : passengers[index]
                                                                              .type ==
                                                                          "5"
                                                                      ? "Flutterwave".tr
                                                                      : passengers[index].type ==
                                                                              "6"
                                                                          ? "Paystack".tr
                                                                          : " ",
                                                  style: TextStyle(
                                                    fontFamily: GlobalData
                                                        .fontlistregular,
                                                    fontSize: 12,
                                                    color: themeModel
                                                            .isdark.value
                                                        ? GlobalData.ofblack
                                                        : GlobalData.fullwhite,
                                                  ),
                                                ),
                                                const Spacer(),
                                                buildpostextprice(
                                                    productprice:
                                                        passengers[index]
                                                            .wallet!,
                                                    fsize: 16.sp,
                                                    fontfmly: GlobalData
                                                        .fontlistsemibold)
                                              ]),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : buildNodat(imge: icon_global.icnodata),
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.black,
            onPressed: () {
              Get.to(const AddMoneyPage());
            },
            child: Center(
                child: Text(
              box.read("doller"),
              style: TextStyle(fontSize: 20.sp, color: GlobalData.fullwhite),
            )),
          ),
        );
      },
    );
  }
}

/*











 */
