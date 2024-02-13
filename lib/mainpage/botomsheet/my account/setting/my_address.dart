import 'package:customer_ecomerce/Config/all_icon.dart';
import 'package:customer_ecomerce/Config/comntost.dart';
import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:customer_ecomerce/api/all_model/get_add_model.dart';
import 'package:customer_ecomerce/api/api_default.dart';
import 'package:customer_ecomerce/api/register_model.dart';
import 'package:customer_ecomerce/coman_widget/cman_widget_product.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../coman_widget/widget_image.dart';
import '../../my_cart/chekout_page.dart';
import 'adrees_add_page.dart';

// ignore: must_be_immutable
class MyAdressPage extends StatefulWidget {
  bool? as;


  // ignore: use_key_in_widget_constructors
  MyAdressPage([this.as]);

  @override
  State<MyAdressPage> createState() => _MyAdressPageState();
}

class _MyAdressPageState extends State<MyAdressPage> {
  ThemeModel themeModel = Get.find<ThemeModel>();
  address_get_model? getadd;
  register_api? delead;
  GetStorage box = GetStorage();

  Future getaddaddress() async {
    try {
      var map = {"user_id": box.read('user_id')};
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urlgetaddres, data: map);
    
      var finallist = await response.data;
      getadd = address_get_model.fromJson(finallist);
      return getadd!;
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: "No Data Found");
      
    }
  }

  Future getdeletaddress(id, index) async {
    try {
      var map = {
        "user_id": box.read('user_id'),
        "address_id": id};
      
      var response = await Dio()
          .post(default_API.baseUrl + post_api.urldeletaddres, data: map);
      
      var finallist = await response.data;
      delead = register_api.fromJson(finallist);

      setState(() {
        getadd!.data!.remove(index);
      });
      Loader.hideLoading();
    } catch (e) {
      Loader.hideLoading();
      Loader.showErroDialog(description: "No Data Found");
      
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
                "My_Address".tr,
              ),
              primary: true,
              leadingWidth: 40,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.only(right: 12, left: 10),
                  height: 25,
                  width: 25,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return AdreesEditPage();
                        },
                      ));
                    },
                    child: Image(
                      image: const AssetImage(icon_global.icadd),
                      color: themeModel.isdark.value
                          ? GlobalData.fullblk
                          : GlobalData.fullwhite,
                    ),
                  ),
                ),
              ],
            ),
            body: FutureBuilder(
                future: getaddaddress(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return getadd!.data!.isNotEmpty
                          ? Container(
                              width: double.infinity,
                              height: double.infinity,
                              margin: const EdgeInsets.only(left: 12, right: 12),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 87.5.h,
                                    child: ListView.separated(
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          thickness: 0.5,
                                          height: 0.1,
                                          color: themeModel.isdark.value
                                              ? GlobalData.fullblk
                                              : GlobalData.fullwhite,
                                        );
                                      },
                                      itemCount: getadd!.data!.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (widget.as == true) {
                                              Navigator.pushReplacement(context, MaterialPageRoute(
                                                builder: (context) {
                                                  return CheckOutPage(
                                                    "",
                                                    getadd!.data![index].firstName!,
                                                    getadd!.data![index].lastName!,
                                                    getadd!.data![index].landmark!,
                                                    getadd!.data![index].mobile!,
                                                    getadd!.data![index].email!,
                                                    getadd!.data![index].streetAddress!,
                                                    getadd!.data![index].pincode!,

                                                  );
                                                },
                                              ));
                                            }
                                          },
                                          child: Container(
                                            height: 15.h,
                                            width: double.infinity,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 10),
                                                child: Slidable(
                                                    endActionPane: ActionPane(
                                                        motion: const ScrollMotion(),
                                                        children: [
                                                          SlidableAction(
                                                            autoClose: true,
                                                            onPressed:
                                                                (context) {
                                                              Loader
                                                                  .showLoading();
                                                              getdeletaddress(
                                                                  getadd!
                                                                      .data![
                                                                          index]
                                                                      .id!
                                                                      .toString(),
                                                                  index);
                                                            },
                                                            backgroundColor:
                                                                const Color(
                                                                    0xFFFE4A49),
                                                            foregroundColor:
                                                                Colors.white,

                                                            label: 'Delete'.tr,
                                                          ),
                                                          SlidableAction(
                                                            onPressed:
                                                                (context) {
                                                              Navigator
                                                                  .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                                  return AdreesEditPage(
                                                                      getadd!.data![
                                                                          index]);
                                                                },
                                                              ));
                                                            },
                                                            backgroundColor:
                                                                GlobalData
                                                                    .fullblk,
                                                            foregroundColor:
                                                                Colors.white,
                                                            icon: Icons.edit,
                                                            label: 'Edit'.tr,
                                                          ),
                                                        ]),
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${getadd!.data![index]
                                                                .firstName} ${getadd!.data![index]
                                                                .lastName}",

                                                            style: TextStyle(
                                                                fontFamily:
                                                                    GlobalData
                                                                        .fontlistsemibold,
                                                                fontSize: 14),
                                                          ),
                                                          Text(
                                                            "${getadd!.data![index].streetAddress} ${getadd!.data![index].landmark} ${getadd!.data![index].pincode} "
                                                            ,
                                                            style: TextStyle(
                                                              color:themeModel.isdark.value?GlobalData.darkgray:GlobalData.fullwhite,
                                                                fontFamily:
                                                                    GlobalData
                                                                        .fontlistregular,
                                                                fontSize: 15.sp),
                                                          ),
                                                          Text(
                                                            getadd!.data![index]
                                                                .mobile
                                                                .toString(),
                                                            // "12345679890",
                                                            style: TextStyle(
                                                                color:themeModel.isdark.value?GlobalData.darkgray:GlobalData.fullwhite,

                                                                fontFamily:
                                                                    GlobalData
                                                                        .fontlistregular,
                                                                fontSize: 14),
                                                          ),
                                                          Text(
                                                            getadd!.data![index]
                                                                .email
                                                                .toString(),
                                                            // "xyz@yopmail.com",
                                                            style: TextStyle(
                                                                color:themeModel.isdark.value?GlobalData.darkgray:GlobalData.fullwhite,

                                                                fontFamily:
                                                                    GlobalData
                                                                        .fontlistregular,
                                                                fontSize: 14),
                                                          ),
                                                        ],
                                                      ),
                                                    ))),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          :buildNodata(imge: icon_global.icnodata);
                    }
                    return buildNodata(
                      imge: icon_global.icnodata
                    );
                  }
                  return bulidcircu();
                }));
      },
    );
  }
}
