import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/cart/cart_controller.dart';
import 'package:organicbazzar/app/modules/home/product_list.dart';
import 'package:organicbazzar/app/modules/product_details/product_detail.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isShadow;
  ProductCard({
    super.key,
    required this.product,
    this.isShadow = true,
  });
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          () => ProductDetailPage(product: product),
          transition: Transition.cupertinoDialog,
          duration: pageTransitionDuration,
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 3.w),
        width: 160,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: isShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 5),
                  ),
                ]
              : [], // No shadow if isShadow is false
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.network(
                product.imageUrl, // Replace with your image link
                height: 120,
                width: 199,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                product.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Rs.${product.price}/1kg',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 50, // Adjust the height as needed
                    width: 10.w, // Adjust the width as needed
                    decoration: const BoxDecoration(
                      color: AppColor.buttonColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add,
                          color: const Color.fromARGB(255, 255, 255, 255)),
                      onPressed: () {
                        cartController.addToCart(
                          CartItem(
                            name: product.name,
                            price: product.price,
                            image: product.imageUrl,
                            rate: product.price,
                          ),
                        );
                        // Add action here
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
