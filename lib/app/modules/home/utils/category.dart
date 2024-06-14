import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CategoryController extends GetxController {
  var selectedCategory = ''.obs;

  void selectCategory(String category) {
    selectedCategory.value = category;
  }
}

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  final CategoryController controller = Get.put(CategoryController());

  CategorySelector({required this.categories});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Shop by category',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 19.0.sp,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Row(
            children: categories.map((category) {
              return Obx(() => CategoryItem(
                    title: category,
                    isSelected: controller.selectedCategory.value == category,
                    onTap: () {
                      controller.selectCategory(category);
                    },
                  ));
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  CategoryItem(
      {required this.title, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 23, 118, 27)
              : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border:
              Border.all(color: isSelected ? Colors.transparent : Colors.grey),
        ),
        child: Text(
          title,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
