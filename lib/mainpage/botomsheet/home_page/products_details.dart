import 'package:carousel_slider/carousel_slider.dart';
import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/all_string.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/success_or_not.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/home_page/reting_reviwes.dart';
import 'package:customer_ecomerce/mainpage/botomsheet/home_page/vendors_page.dart';
import 'package:customer_ecomerce/mainpage/main_page.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../api/all_model/product_details_model.dart';
import '../../../coman_widget/cman_widget_product.dart';
import 'reatunr_policy.dart';
import 'descripiton.dart';

// ignore: must_be_immutable
class ProdutsDetails extends StatefulWidget {
  String? productid;
  String? proname;
  String? catname;

  // ignore: use_key_in_widget_constructors
  ProdutsDetails([this.productid, this.proname, this.catname]);

  @override
  State<ProdutsDetails> createState() => _ProdutsDetailsState();
}

class _ProdutsDetailsState extends State<ProdutsDetails> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  GetStorage box = GetStorage();
  bool visible = false;
  productdetails_model? produt;
  success_or_no_model? favorite;

  Future productdetails() async {
    try {
      widget.proname = "";
      widget.catname = "";
      var map = {
        "product_id": widget.productid,
        "user_id": box.read('user_id') ?? ""
      };
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlproductdetails, data: map);

      var finallist = await response.data;

      produt = productdetails_model.fromJson(finallist);

      return produt;
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);
    }
  }

  Future addtocart() async {
    Loader.showLoading();
    try {
      var map = {
        "price": produt!.data!.productPrice!,
        "product_id": produt!.data!.id!,
        "product_name": produt!.data!.productName!,
        "qty": "1",
        "user_id": box.read("user_id"),
        "variation": "",
        "vendor_id": produt!.data!.vendorId!,
        "attributes": produt!.data!.attribute!,
        "image": produt!.data!.productimages![0].imageName
      };

      var responseHome = await Dio()
          .post(default_API.baseUrl + post_api.urladdtocart, data: map);
      Loader.hideLoading();
      favorite = success_or_no_model.fromJson(responseHome.data);

      if (favorite!.status == 0) {
        Loader.showErroDialog(description: favorite!.message!);
      } else if (favorite!.status == 1) {
        // ignore: use_build_context_synchronously
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          context: context,
          builder: (context) {
            return Container(
              height: 40.h,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  border: GlobalRadious.border),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close)),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 16.h,
                            width: 32.w,
                            decoration: BoxDecoration(
                                color: GlobalData.fullwhite,
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                  image: AssetImage(icon_global.icright),
                                  fit: BoxFit.fill,
                                )),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            "Success !",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: GlobalData.fontlistbold,
                                fontSize: 18.sp),
                          ),
                          SizedBox(height: 1.h),
                          Text("Product added successfully into your cart",
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontFamily: GlobalData.fontlistsemibold,
                                  color: themeModel.isdark.value
                                      ? GlobalData.ofwhite
                                      : GlobalData.whitecolor),
                              textAlign: TextAlign.center),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Loader.showLoading();
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return MainPages(0);
                                },
                              ), (route) => false);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: GlobalData.orange,
                                  borderRadius: GlobalRadious.radious_),
                              height: 7.h,
                              width: 45.w,
                              child: Center(
                                child: Text("Continue Shoping",
                                    style: TextStyle(
                                        fontFamily: GlobalData.fontlistsemibold,
                                        color: GlobalData.whitecolor)),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Loader.showLoading();
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return MainPages(2);
                                },
                              ), (route) => false);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: GlobalData.fullblk,
                                  borderRadius: GlobalRadious.radious_),
                              height: 7.h,
                              width: 45.w,
                              child: Center(
                                child: Text("Go to cart",
                                    style: TextStyle(
                                        fontFamily: GlobalData.fontlistsemibold,
                                        color: GlobalData.whitecolor)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                    ],
                  )),
            );
          },
        );
      } else {
        Loader.hideLoading();
        Loader.showErroDialog(description: favorite!.message!);
      }

      return favorite;
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);
    }
  }

  Future like() async {
    try {
      var map = {
        "product_id": widget.productid,
        "user_id": box.read('user_id')
      };
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlmakfavorite, data: map);

      var finallist = await response.data;
      favorite = success_or_no_model.fromJson(finallist);

      setState(() {});
      Loader.hideLoading();
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: 'Something_went_wrong'.tr);
    }
  }

  Future dislike() async {
    try {
      var map = {
        "product_id": widget.productid,
        "user_id": box.read('user_id')
      };
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlmakunfavorite, data: map);

      var finallist = await response.data;
      favorite = success_or_no_model.fromJson(finallist);

      setState(() {});
      Loader.hideLoading();
    } catch (e) {
      Loader.hideLoading();

      Loader.showErroDialog(description: 'Something_went_wrong'.tr);
    }
  }

  int selectedindex = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(
      builder: (controllers) {
        return Scaffold(
            appBar: AppBar(
              primary: true,
              centerTitle: false,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                ),
              ),
              title: Text(widget.proname!),
            ),
            body: Container(
                height: 79.h,
                margin: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                ),
                child: FutureBuilder(
                  future: productdetails(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                CarouselSlider.builder(
                                    carouselController: _controller,
                                    options: CarouselOptions(
                                      height: 52.h,
                                      viewportFraction: 1,
                                      initialPage: 0,
                                      enableInfiniteScroll: false,
                                      reverse: true,
                                      autoPlay: true,
                                      autoPlayInterval: const Duration(seconds: 3),
                                      autoPlayAnimationDuration:
                                          const Duration(milliseconds: 800),
                                      enlargeCenterPage: false,
                                      scrollDirection: Axis.horizontal,
                                      pauseAutoPlayOnTouch: true,
                                    ),
                                    itemCount:
                                        (produt!.data!.productimages!.length /
                                                1)
                                            .round(),
                                    itemBuilder: (context, index, realIdx) {
                                      final int first = index * 5;
                                      return Row(
                                        children: [
                                          first,
                                        ].map((idx) {
                                          return Expanded(
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  8.w, 8, 8.w, 8),
                                              height: 60.h,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          produt!
                                                              .data!
                                                              .productimages![
                                                                  index]
                                                              .imageUrl!),
                                                      fit: BoxFit.fill),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(
                                                              12))),
                                            ),
                                          );
                                        }).toList(),
                                      );
                                    }),
                              ],
                            ),

                            Row(
                              children: [
                                SizedBox(
                                  width: 80.w,
                                  child: Text(
                                      produt!.data!.categoryName != null ||
                                              produt!.data!.subcategoryName !=
                                                  null ||
                                              produt!.data!
                                                      .innersubcategoryName !=
                                                  null
                                          ? "${produt!.data!.categoryName!} | ${produt!.data!.subcategoryName!} | ${produt!.data!.innersubcategoryName!}"
                                              .toUpperCase()
                                          : "",
                                      style: TextStyle(
                                          fontFamily:
                                              GlobalData.fontlistregular,
                                          color: themeModel.isdark.value
                                              ? GlobalData.ofwhite
                                              : GlobalData.fullwhite,
                                          fontSize: 15.sp)),
                                ),
                                const Spacer(),
                                Image(
                                    image: const AssetImage(icon_global.icfillstar),
                                    width: 16,
                                    color: GlobalData.orange),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(produt!.data!.rattings!.isNotEmpty
                                    ? produt!.data!.rattings![0].avgRatting!
                                    : "0.0")
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Text(produt!.data!.productName!,
                                style: TextStyle(
                                    fontFamily: GlobalData.fontlistmedium,
                                    color: themeModel.isdark.value
                                        ? GlobalData.fullblk
                                        : GlobalData.fullwhite,
                                    fontSize: 18.sp)),
                            SizedBox(height: 2.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                        produt!.data!.isVariation == "0"
                                            ? box.read("pos") == "right"
                                                ? GlobalData.formatCurrency.format(double.parse(produt!.data!.productPrice!)) + box.read("doller")
                                                : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(produt!.data!.productPrice!))}"
                                            : box.read("pos") == "right"
                                                ? GlobalData.formatCurrency.format(double.parse(produt!.data!.variations![selectedindex].price!)) + box.read("doller")
                                                : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(produt!.data!.variations![selectedindex].price!))}",
                                        style: TextStyle(
                                            fontFamily:
                                                GlobalData.fontlistsemibold,
                                            fontSize: 17.sp)),
                                    SizedBox(
                                      width: 1.5.w,
                                    ),
                                    Text(
                                        produt!.data!.isVariation == "0"
                                            ? box.read("pos") == "right"
                                                ? GlobalData.formatCurrency.format(double.parse(produt!.data!.discountedPrice!)) + box.read("doller")
                                                : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(produt!.data!.discountedPrice!))}"
                                            : box.read("pos") == "right"
                                                ? GlobalData.formatCurrency.format(double.parse(produt!.data!.variations![selectedindex].discountedVariationPrice!)) + box.read("doller")
                                                : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(produt!.data!.variations![selectedindex].discountedVariationPrice!))}",
                                        style: TextStyle(
                                            fontFamily:
                                                GlobalData.fontlistregular,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 16.sp)),
                                    SizedBox(
                                      width: 1.5.w,
                                    ),
                                  ],
                                ),
                                Text(
                                    produt!.data!.isVariation == "0"
                                        ? produt!.data!.productQty != "0"
                                            ? "In Stock"
                                            : "Out of stock"
                                        : produt!.data!.isVariation == "1"
                                            ? produt!
                                                        .data!
                                                        .variations![
                                                            selectedindex]
                                                        .qty !=
                                                    "0"
                                                ? "In Stock"
                                                : "Out of stock"
                                            : "",
                                    style: TextStyle(
                                      fontFamily: GlobalData.fontlistregular,
                                      color: produt!.data!.isVariation == "0"
                                          ? produt!.data!.productQty != "0"
                                              ? GlobalData.greencolor
                                              : GlobalData.redcolor
                                          : produt!.data!.isVariation == "1"
                                              ? produt!
                                                          .data!
                                                          .variations![
                                                              selectedindex]
                                                          .qty !=
                                                      "0"
                                                  ? GlobalData.greencolor
                                                  : GlobalData.redcolor
                                              : GlobalData.fullwhite,
                                      fontSize: 14.sp,
                                    )),
                              ],
                            ),

                            if (produt!.data!.taxType == "amount") ...{
                              if (produt!.data!.tax == "0") ...{
                                Text("Inclusive_All_Taxes".tr,
                                    style: TextStyle(
                                        fontFamily: GlobalData.fontlistsemibold,
                                        color: themeModel.isdark.value
                                            ? GlobalData.green
                                            : GlobalData.redcolor,
                                        fontSize: 14.sp)),
                              } else ...{
                                Text(
                                    box.read("pos") == "right"
                                        ? "${GlobalData.formatCurrency.format(double.parse(produt!.data!.tax!)) + box.read("doller")} additional tax"
                                        : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(produt!.data!.tax!))} additional tax",
                                    style: TextStyle(
                                        fontFamily: GlobalData.fontlistsemibold,
                                        color: themeModel.isdark.value
                                            ? GlobalData.red
                                            : GlobalData.redcolor,
                                        fontSize: 14.sp)),
                              }
                            } else ...{
                              Text(
                                  box.read("pos") == "right"
                                      ? "${GlobalData.formatCurrency.format(double.parse(produt!.data!.tax!)) + box.read("doller")} additional tax"
                                      : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(produt!.data!.tax!))} additional tax",
                                  style: TextStyle(
                                      fontFamily: GlobalData.fontlistsemibold,
                                      color: themeModel.isdark.value
                                          ? GlobalData.red
                                          : GlobalData.redcolor,
                                      fontSize: 14.sp)),
                            },

                            // Text(
                            //    ?"${produt!.data!.tax} additional tax":
                            //     produt!.data!.tax=="0"?"Inclusive All Taxes":
                            //     box.read("pos") == "right" ?
                            //     "${GlobalData.formatCurrency.format(double.parse(produt!.data!.tax!)) + box.read("doller")} additional tax"
                            //         : "${box.read("doller") + GlobalData.formatCurrency.format(double.parse(produt!.data!.tax!))} additional tax",
                            //     style: TextStyle(
                            //         fontFamily: GlobalData.fontlistsemibold,
                            //         color: themeModel.isdark.value
                            //             ? GlobalData.redcolor
                            //             : GlobalData.redcolor,
                            //         fontSize: 14.sp)),
                            SizedBox(height: 1.5.h),
                            Text(
                                "EST.Shipping Time :${produt!.data!.estShippingDays!} Day",
                                style: TextStyle(
                                    fontFamily: GlobalData.fontlistregular,
                                    color: themeModel.isdark.value
                                        ? GlobalData.fullblk
                                        : GlobalData.fullwhite,
                                    fontSize: 14.sp)),
                            SizedBox(height: 1.5.h),
                            Text(
                                box.read("pos") == "right"
                                    ? "Shipping Charge : ${GlobalData.formatCurrency.format(double.parse(produt!.data!.shippingCost!)) + box.read("doller")}"
                                    : "Shipping Charge :${box.read("doller") + GlobalData.formatCurrency.format(double.parse(produt!.data!.discountedPrice!))}",
                                style: TextStyle(
                                    fontFamily: GlobalData.fontlistregular,
                                    color: themeModel.isdark.value
                                        ? GlobalData.fullblk
                                        : GlobalData.fullwhite,
                                    fontSize: 14.sp)),
                            SizedBox(height: 1.5.h),
                            Text("SKU : ${produt!.data!.sku!}",
                                style: TextStyle(
                                    fontFamily: GlobalData.fontlistmedium,
                                    color: themeModel.isdark.value
                                        ? GlobalData.fullblk
                                        : GlobalData.fullwhite,
                                    fontSize: 15.sp)),
                            SizedBox(height: 1.5.h),
                            Visibility(
                                visible: produt!.data!.isVariation == "1"
                                    ? true
                                    : false,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Size",
                                        style: TextStyle(
                                            fontFamily:
                                                GlobalData.fontlistregular,
                                            color: themeModel.isdark.value
                                                ? GlobalData.fullblk
                                                : GlobalData.fullwhite,
                                            fontSize: 16.sp)),
                                    SizedBox(height: 1.5.h),
                                    SizedBox(
                                      height: 7.h,
                                      child: GridView.builder(
                                        itemCount:
                                            produt!.data!.variations!.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 7,
                                          crossAxisSpacing: 6,
                                          mainAxisSpacing: 81,
                                          childAspectRatio: 0.9,
                                        ),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedindex = index;
                                              });
                                            },
                                            child: selectedindex == index
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: themeModel
                                                                  .isdark.value
                                                              ? GlobalData
                                                                  .bluebtn
                                                              : GlobalData
                                                                  .fullwhite,
                                                          width: 0.1.h),
                                                    ),
                                                    child: Center(
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    8),
                                                            child: Text(
                                                              produt!
                                                                  .data!
                                                                  .variations![
                                                                      index]
                                                                  .variation!,
                                                              style: TextStyle(
                                                                  color: themeModel
                                                                          .isdark
                                                                          .value
                                                                      ? GlobalData
                                                                          .fullblk
                                                                      : GlobalData
                                                                          .fullwhite,
                                                                  fontSize:
                                                                      15.sp),
                                                            ))),
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                        color: themeModel
                                                                .isdark.value
                                                            ? GlobalData
                                                                .fullwhite
                                                            : GlobalData
                                                                .fullblk,
                                                        border: GlobalRadious
                                                            .border),
                                                    child: Center(
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                    8),
                                                            child: Text(
                                                              produt!
                                                                  .data!
                                                                  .variations![
                                                                      index]
                                                                  .variation!,
                                                              style: TextStyle(
                                                                  color: themeModel
                                                                          .isdark
                                                                          .value
                                                                      ? GlobalData
                                                                          .fullblk
                                                                      : GlobalData
                                                                          .fullwhite,
                                                                  fontSize:
                                                                      15.sp),
                                                            ))),
                                                  ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                            GestureDetector(
                                onTap: () {
                                  Get.to(DescriptionPage(
                                      produt!.data!.description!));
                                },
                                child: buildlisttilecell(
                                    bgclr: GlobalData.fullwhite,
                                    image: icon_global.icfile,
                                    name: GlobalString.descriptin)),
                            Divider(
                                height: 1.h,
                                color: themeModel.isdark.value
                                    ? GlobalData.fullblk
                                    : GlobalData.fullwhite),
                            GestureDetector(
                                onTap: () {
                                  Get.to(
                                      retingreviews("${produt!.data!.id!}"));
                                },
                                child: buildlisttilecell(
                                    bgclr: GlobalData.fullwhite,
                                    image: icon_global.icstarblnk,
                                    name: GlobalString.retingreviews)),
                            Divider(
                                height: 1.h,
                                color: themeModel.isdark.value
                                    ? GlobalData.fullblk
                                    : GlobalData.fullwhite),
                            if (produt!.data!.isReturn == "1") ...{
                              GestureDetector(
                                  onTap: () {
                                    Get.to(ReaturnPolicy(
                                        produt!.returnpolicy!.returnPolicies!));
                                  },
                                  child: buildlisttilecell(
                                      bgclr: GlobalData.fullwhite,
                                      image: icon_global.icretunpolicy,
                                      name:
                                          "${produt!.data!.returnDays!} Days ${GlobalString.returnpolicy}")),
                            },

                            Card(
                              color: themeModel.isdark.value
                                  ? GlobalData.fullwhite
                                  : GlobalData.fullblk,
                              child: Container(
                                height: 12.h,
                                width: double.infinity,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5,
                                        color: GlobalData.whitecolor),
                                    color: themeModel.isdark.value
                                        ? GlobalData.fullwhite
                                        : GlobalData.fullblk,
                                    borderRadius:
                                        const BorderRadius.all(Radius.circular(10))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 25.w,
                                      decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  produt!.vendors!.imageUrl!),
                                              fit: BoxFit.cover)),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                                child: Text(
                                              produt!.vendors!.name!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontFamily:
                                                    GlobalData.fontlistsemibold,
                                                color: themeModel.isdark.value
                                                    ? GlobalData.ofblack
                                                    : GlobalData.fullwhite,
                                              ),
                                            )),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 0, right: 0, top: 6),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    height: 14,
                                                    width: 14,
                                                    child: Image(
                                                        image: const AssetImage(
                                                            icon_global
                                                                .icfillstar),
                                                        color:
                                                            GlobalData.orange),
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  SizedBox(
                                                    child: Text(
                                                      produt!.vendors!.rattings!
                                                              .isNotEmpty
                                                          ? "${produt!.vendors!.rattings![0].avgRatting}"
                                                          : "0.0",
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  GestureDetector(
                                                    onTap: () => Get.to(VendorsPage(
                                                        1,
                                                        "${produt!.vendors!.id}",
                                                        "${produt!.vendors!.name}",
                                                        "${produt!.vendors!.imageUrl}")),
                                                    child: Text(
                                                      "Visit_Store".tr,
                                                      style: TextStyle(
                                                          color: themeModel
                                                                  .isdark.value
                                                              ? GlobalData
                                                                  .fullblk
                                                              : GlobalData
                                                                  .fullwhite,
                                                          fontFamily: GlobalData
                                                              .fontlistregular),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 1.5.h),
                            Text("You_May_also_like".tr,
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontFamily: GlobalData.fontlistsemibold)),
                            SizedBox(
                              height: 1.h,
                            ),
                            /////////featured products
                            SizedBox(
                                height: 36.h,
                                width: double.infinity,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      endIndent: 1.5.h,
                                    );
                                  },
                                  scrollDirection: Axis.horizontal,
                                  itemCount: produt!.relatedProducts!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return ProdutsDetails(
                                                  "${produt!.relatedProducts![index].id!}",
                                                  "${produt!.relatedProducts![index]}");
                                            },
                                          ));
                                        },
                                        child: buildtrendingproductcell(
                                          ret: produt!.relatedProducts![index]
                                                  .rattings!.isNotEmpty
                                              ? "${produt!.relatedProducts![index].rattings![0].avgRatting}"
                                              : "0.0",
                                          widget: Container(
                                              margin: const EdgeInsets.only(
                                                  top: 8, right: 8),
                                              height: 25,
                                              width: 25,
                                              child: GestureDetector(
                                                  onTap: () async {
                                                    if (produt!
                                                            .relatedProducts![
                                                                index]
                                                            .isWishlist ==
                                                        "0") {
                                                      Loader.showLoading();
                                                      like();
                                                    } else {
                                                      Loader.showLoading();
                                                      dislike();
                                                    }
                                                  },
                                                  child: produt!
                                                              .relatedProducts![
                                                                  index]
                                                              .isWishlist ==
                                                          "0"
                                                      ? const Image(
                                                          image: AssetImage(
                                                              icon_global
                                                                  .icheart),
                                                          width: 25,
                                                          height: 25,
                                                        )
                                                      : Image(
                                                          image: const AssetImage(
                                                              icon_global
                                                                  .icbalckheart),
                                                          color: GlobalData
                                                              .redcolor,
                                                          width: 25,
                                                          height: 25,
                                                        ))),
                                          productImage: produt!
                                              .relatedProducts![index]
                                              .productimage!
                                              .imageUrl!,
                                          productName: produt!
                                              .relatedProducts![index]
                                              .productName!,
                                          productPrice: produt!
                                              .relatedProducts![index]
                                              .productPrice!,
                                          productdiscountprice: produt!
                                              .relatedProducts![index]
                                              .discountedPrice!,
                                        ));
                                  },
                                )),
                          ],
                        ),
                      );
                    }
                    return Center(
                      child:
                          CircularProgressIndicator(color: GlobalData.bluebtn),
                    );
                  },
                )),
            bottomSheet: FutureBuilder(
              future: productdetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    height: 6.h,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 1.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (produt!.data!.isWishlist == "0") {
                              Loader.showLoading();
                              like();
                            } else {
                              Loader.showLoading();
                              dislike();
                            }
                          },
                          child: Container(
                            height: 7.h,
                            width: 30.w,
                            decoration: BoxDecoration(
                                border: Border.all(
                              color: GlobalData.bluebtn,
                              width: 0.5,
                            )),
                            child: Center(
                                child: produt!.data!.isWishlist == "0"
                                    ? const Image(
                                        image: AssetImage(icon_global.icheart),
                                        width: 40,
                                        height: 40,
                                      )
                                    : Image(
                                        image: const AssetImage(
                                            icon_global.icbalckheart),
                                        color: GlobalData.redcolor,
                                        width: 40,
                                        height: 40,
                                      )),
                          ),
                        ),
                        produt!.data!.isVariation == "0"
                            ? produt!.data!.productQty != "0"
                                ? GestureDetector(
                                    onTap: () async {
                                      addtocart();
                                    },
                                    child: Container(
                                      height: 6.h,
                                      width: 56.w,
                                      decoration: BoxDecoration(
                                          color: GlobalData.bluebtn,
                                          border: Border.all(
                                            color: GlobalData.fullblk,
                                            width: 0.5,
                                          )),
                                      child: Center(
                                          child: Text(
                                        "Add to Cart",
                                        style: TextStyle(
                                            color: GlobalData.fullwhite,
                                            fontSize: 18.sp),
                                      )),
                                    ),
                                  )
                                : Container(
                                    height: 6.h,
                                    width: 56.w,
                                    decoration: BoxDecoration(
                                        color: GlobalData.ofblack,
                                        border: Border.all(
                                          color: GlobalData.fullblk,
                                          width: 0.5,
                                        )),
                                    child: Center(
                                        child: Text(
                                      "Add to Cart",
                                      style: TextStyle(
                                          color: GlobalData.fullwhite,
                                          fontSize: 18.sp),
                                    )),
                                  )
                            : produt!.data!.isVariation == "1"
                                ? produt!.data!.variations![selectedindex]
                                            .qty !=
                                        "0"
                                    ? GestureDetector(
                                        onTap: () async {
                                          Loader.showLoading();
                                          var map = {
                                            "price": produt!
                                                .data!
                                                .variations![selectedindex]
                                                .price!,
                                            "product_id": produt!.data!.id!,
                                            "product_name":
                                                produt!.data!.productName!,
                                            "qty": "1",
                                            "user_id": box.read("user_id"),
                                            "variation": produt!
                                                .data!
                                                .variations![selectedindex]
                                                .variation!,
                                            "vendor_id":
                                                produt!.data!.vendorId!,
                                            "attributes":
                                                produt!.data!.attribute!,
                                            "image": produt!.data!
                                                .productimages![0].imageName,
                                            "shipping_cost":
                                                produt!.data!.shippingCost,
                                            "tax": produt!.data!.tax,
                                          };
                                          var responseHome = await Dio().post(
                                              default_API.baseUrl +
                                                  post_api.urladdtocart,
                                              data: map);
                                          Loader.hideLoading();
                                          favorite = success_or_no_model
                                              .fromJson(responseHome.data);
                                          if (favorite!.status == 1) {
                                            // ignore: use_build_context_synchronously
                                            showModalBottomSheet(
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                ),
                                              ),
                                              context: context,
                                              builder: (context) {
                                                return Container(
                                                  height: 40.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          const BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(12),
                                                              topRight: Radius
                                                                  .circular(
                                                                      12)),
                                                      border: GlobalRadious
                                                          .border),
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                              horizontal: 12),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SizedBox(
                                                                height: 50,
                                                                width: 50,
                                                                child:
                                                                    IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        icon: const Icon(
                                                                            Icons.close)),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                height: 16.h,
                                                                width: 32.w,
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: GlobalData
                                                                            .fullwhite,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image:
                                                                            const DecorationImage(
                                                                          image:
                                                                              AssetImage(icon_global.icright),
                                                                          fit:
                                                                              BoxFit.fill,
                                                                        )),
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                      1.h),
                                                              Text(
                                                                "Success_".tr,
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        GlobalData
                                                                            .fontlistbold,
                                                                    fontSize:
                                                                        18.sp),
                                                              ),
                                                              SizedBox(
                                                                  height:
                                                                      1.h),
                                                              Text(
                                                                  "Product_added_successfully_into_your_cart".tr,
                                                                  style: TextStyle(
                                                                      fontSize: 16
                                                                          .sp,
                                                                      fontFamily:
                                                                          GlobalData
                                                                              .fontlistsemibold,
                                                                      color: themeModel.isdark.value
                                                                          ? GlobalData
                                                                              .ofwhite
                                                                          : GlobalData
                                                                              .whitecolor),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center),
                                                            ],
                                                          ),
                                                          const Spacer(),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Loader
                                                                      .showLoading();
                                                                  Navigator.pushAndRemoveUntil(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                                      return MainPages(
                                                                          0);
                                                                    },
                                                                  ),
                                                                      (route) =>
                                                                          false);
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      color: GlobalData
                                                                          .orange,
                                                                      borderRadius:
                                                                          GlobalRadious
                                                                              .radious_),
                                                                  height: 7.h,
                                                                  width: 45.w,
                                                                  child: Center(
                                                                    child: Text(
                                                                        "Continue_Shoping".tr,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                GlobalData.fontlistsemibold,
                                                                            color: GlobalData.whitecolor)),
                                                                  ),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Loader
                                                                      .showLoading();
                                                                  Navigator.pushAndRemoveUntil(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                    builder:
                                                                        (context) {
                                                                      return MainPages(
                                                                          2);
                                                                    },
                                                                  ),
                                                                      (route) =>
                                                                          false);
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      color: GlobalData
                                                                          .fullblk,
                                                                      borderRadius:
                                                                          GlobalRadious
                                                                              .radious_),
                                                                  height: 7.h,
                                                                  width: 45.w,
                                                                  child: Center(
                                                                    child: Text(
                                                                        "Go_to_cart".tr,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                GlobalData.fontlistsemibold,
                                                                            color: GlobalData.whitecolor)),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 1.h),
                                                        ],
                                                      )),
                                                );
                                              },
                                            );
                                          } else {
                                            Loader.showErroDialog(
                                                description: "aslredys");
                                          }
                                        },
                                        child: Container(
                                          height: 6.h,
                                          width: 56.w,
                                          decoration: BoxDecoration(
                                              color: GlobalData.bluebtn,
                                              border: Border.all(
                                                color: GlobalData.fullblk,
                                                width: 0.5,
                                              )),
                                          child: Center(
                                              child: Text(
                                            "addtocart".tr,
                                            style: TextStyle(
                                                color: GlobalData.fullwhite,
                                                fontSize: 18.sp),
                                          )),
                                        ),
                                      )
                                    : Container(
                                        height: 6.h,
                                        width: 56.w,
                                        decoration: BoxDecoration(
                                            color: GlobalData.ofblack,
                                            border: Border.all(
                                              color: GlobalData.fullblk,
                                              width: 0.5,
                                            )),
                                        child: Center(
                                            child: Text(
                                          "addtocart".tr,
                                          style: TextStyle(
                                              color: GlobalData.fullwhite,
                                              fontSize: 18.sp),
                                        )),
                                      )
                                : const Center(),
                      ],
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(color: GlobalData.bluebtn),
                );
              },
            ));
      },
    );
  }
}
