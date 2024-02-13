



// ignore_for_file: prefer_const_constructors, unused_import, prefer_final_fields, file_names, avoid_print

import 'package:customer_ecomerce/Config/global_data.dart';
import 'package:customer_ecomerce/mainpage/main_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  PageController _pageController = PageController();
  bool onlastpage = false;
  int chnage=2;
  // initdata() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   await prefs.setInt(init_Screen, 1);
  // }


  final controller = PageController(viewportFraction: 0.8, keepPage: true);

   List<String> bordingimage = [
    "assets/image/ic_pageone.png",
    "assets/image/ic_pagetwo.png",
    "assets/image/ic_pagethree.png",
    "assets/image/ic_pagefour.png",

  ];
GetStorage box =GetStorage();
@override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
    return 
      SafeArea(
        child: Scaffold(
        body:
        Stack(
          alignment: Alignment.center,
          children: [
            PageView.builder(
              itemCount: bordingimage.length,
              controller: _pageController,
              onPageChanged: (index) {
                if (index + 1 ==  bordingimage.length) {
                  setState(() {
                    onlastpage = true;
                    box.write("bord", chnage);
                  });
                } else {
                  setState(() {
                    onlastpage = false;
                  });
                }
              },
              itemBuilder: (context, index) {
                return
                    Image(image: AssetImage(bordingimage[index]),fit: BoxFit.fill,);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topRight,

                child:
                GestureDetector(
                  onTap: () {
                    box.write("bord", chnage);
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                      return MainPages(0);
                    },), (route) => false);
                  },
                  child: Container(
                   width: 20.w,
                   height: 5.5.h,
                   decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)),
                     color:  GlobalData.bluebtn,
                   ),

                    child: Center(child: Text(
                        onlastpage ? "Start":"Skip",style: TextStyle(fontFamily: GlobalData.fontlistsemibold,color: GlobalData.fullwhite,fontSize: 17.sp),
                    ))
                    ,
           ),
                ),
              ),
            ),

            Padding(
              padding:  EdgeInsets.only(bottom: 10.h),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SmoothPageIndicator(
                    controller: _pageController,  // PageController
                    count:  bordingimage.length,
                    effect:  SwapEffect(activeDotColor: GlobalData.fullwhite,dotColor: GlobalData.lightgraycolor,dotHeight: 10,dotWidth: 10),  // your preferred effect
                    onDotClicked: (index){
                    }
                ),
              ),
            )
          ],)
    ),
      );
  }
}



