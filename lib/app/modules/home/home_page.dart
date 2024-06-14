import 'package:flutter/material.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/home/utils/category.dart';
import 'package:organicbazzar/app/modules/home/utils/our_Prouduct_section.dart';
import 'package:organicbazzar/app/modules/home/utils/profile.dart';
import 'package:organicbazzar/app/modules/home/utils/recent.dart';
import 'package:organicbazzar/app/modules/home/utils/custom_appbar.dart';
import 'package:organicbazzar/app/widget/custom_drawer.dart';
import 'package:organicbazzar/app/widget/loading_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      drawer: const CustomDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: AppPadding.screenHorizontalPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomAppBar(
                      name: 'Robert Martiz',
                      location: 'Los Angeles',
                    ),
                    RecentlyListed(),
                    // SizedBox(height: 16),
                    OurProducts()
                  ],
                ),
              ),
            ),
          ),
          // Positioned(
          //   left: 10.w,
          //   right: 0,
          //   top: 40.h, // Use ScreenUtil to adjust according to screen height
          //   child: LoadingWidget(),
          // ),
        ],
      ),
    );
  }
}
