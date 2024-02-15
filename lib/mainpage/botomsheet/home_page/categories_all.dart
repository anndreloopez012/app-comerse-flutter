import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/Config/thememodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../api/all_model/category_model.dart';
import 'categories_menue.dart';

// ignore: must_be_immutable
class CategoriesViewAll extends StatefulWidget {
  List<Data>? category;

  CategoriesViewAll(this.category, {super.key});

  @override
  State<CategoriesViewAll> createState() => _CategoriesViewAllState();
}

class _CategoriesViewAllState extends State<CategoriesViewAll> {
  ThemeModel themeModel = Get.find<ThemeModel>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeModel>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
              ),
            ),
            leadingWidth: 6.h,
            primary: true,
            automaticallyImplyLeading: false,
            title: Text("All_Categories".tr),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 88.h,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => CategoriesMenuePage(
                              "${widget.category![index].id!}",
                              widget.category![index].categoryName!));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 6, bottom: 6),
                          decoration: BoxDecoration(
                              borderRadius: GlobalRadious.radious_,
                              color: themeModel.isdark.value
                                  ? GlobalData.whitecolor
                                  : GlobalData.fullblk,
                              border: GlobalRadious.border),
                          alignment: Alignment.center,
                          height: 12.h,
                          width: double.infinity,
                          child: ListTile(
                            title: Text(widget.category![index].categoryName!,
                                style: TextStyle(
                                    fontFamily: GlobalData.fontlistregular)),
                            leading: Image(
                                image: NetworkImage(
                                    widget.category![index].imageUrl!)),
                            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                          ),
                        ),
                      );
                    },
                    itemCount: widget.category!.length,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
