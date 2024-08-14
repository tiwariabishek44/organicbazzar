import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/model/cart_response_model.dart';
import 'package:organicbazzar/app/modules/cart/cart_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class CartCard extends StatelessWidget {
  final int productId;
  final String image;
  final String name;
  final String rate;
  final double price;
  final int quantity;

  CartCard({
    required this.productId,
    required this.quantity,
    required this.image,
    required this.name,
    required this.rate,
    required this.price,
  });

  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final imageWidth = constraints.maxWidth * 0.4;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 240, 243, 243),
                  borderRadius: BorderRadius.circular(15),

                  //  / No shadow if isShadow is false
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10)),
                      child: CachedNetworkImage(
                        imageUrl: ApiEndpoints.baseUrl + image,
                        height: 15.h,
                        width: imageWidth,
                        fit: BoxFit.fill,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 15.h,
                            width: imageWidth,
                            color: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) => Image.asset(
                          'assets/placeholder.png',
                          height: 15.h,
                          width: imageWidth,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppStyle.text().copyWith(
                                color: Color.fromARGB(255, 134, 133, 133),
                                fontWeight: FontWeight.w400,
                                fontSize: 18.sp),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Rate : Rs$rate * $quantity',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rs.${price * quantity}',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 73, 29, 29),
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 20,
                                  // Add green border
                                  foregroundColor: Colors.green,
                                  child: IconButton(
                                    icon:
                                        Icon(Icons.remove, color: Colors.black),
                                    onPressed: () {
                                      if (quantity > 1) {
                                        cartController.updateCartItemQuantity(
                                            name, quantity - 1);
                                      } else if (quantity == 1) {
                                        cartController.removeFromCart(name);
                                      }
                                    },
                                  ),
                                ),
                                Text(
                                  '$quantity',
                                  style: TextStyle(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Color(0xff93C22F),
                                  child: IconButton(
                                    icon: Icon(Icons.add,
                                        size: 18.sp,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255)),
                                    onPressed: () {
                                      cartController.updateCartItemQuantity(
                                          name, quantity + 1);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //divider
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),

        // divider
        Divider(
          color: Colors.grey,
          thickness: 0.5,
        ),
      ],
    );
  }
}
