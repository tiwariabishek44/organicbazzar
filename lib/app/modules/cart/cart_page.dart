import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/cart/cart_controller.dart';
import 'package:organicbazzar/app/modules/cart/utils/cart_card.dart';
import 'package:organicbazzar/app/modules/cart/utils/order_summary.dart';
import 'package:organicbazzar/app/widget/custom_button.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CartPage extends StatelessWidget {
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        title: Text(
          "My Cart",
        ),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return Center(
            child: Text('Your cart is empty'),
          );
        } else {
          return Padding(
            padding: AppPadding.screenHorizontalPadding,
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: cartController.cartItems.length,
                      itemBuilder: (context, index) {
                        return CartCard(
                          rate: cartController.cartItems[index].rate.toString(),
                          image: cartController.cartItems[index].image,
                          name: cartController.cartItems[index].name,
                          price: cartController.cartItems[index].price,
                        );
                      },
                    ),
                    OrderSummary(
                      orderTotal: 117.98,
                      deliveryFee: 15.00,
                      total: cartController
                          .calculateTotalPrice()
                          .toInt()
                          .toDouble(),
                    ),
                    CustomButton(
                      buttonColor: AppColor.buttonColor,
                      textColor: AppColor.backgroundColor,
                      text: 'Check Out',
                      onPressed: () {},
                      isLoading: false,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }),
    );
  }
}
