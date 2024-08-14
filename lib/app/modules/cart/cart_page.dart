import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/modules/cart/cart_controller.dart';
import 'package:organicbazzar/app/modules/cart/utils/cart_card.dart';
import 'package:organicbazzar/app/modules/cart/utils/order_summary.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CartPage extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              size: 20.sp, color: AppColor.textColor),
          onPressed: () => Get.back(),
        ),
        title: Text("My Cart",
            style: TextStyle(color: AppColor.textColor, fontSize: 18.sp)),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return _buildEmptyCart();
        } else {
          return _buildCartContent();
        }
      }),
    );
  }

  Widget _buildEmptyCart() {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/download.jpg', // Make sure to add this image to your assets
            width: 80.w,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 4.h),
          // Text(
          //   'Your Cart is Empty',
          //   style: TextStyle(
          //     fontSize: 24.sp,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.green[800],
          //   ),
          // ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              'You haven\'t add any product yet. Start exploring our organic products and make your first purchase!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          ElevatedButton(
            onPressed: () {
              Get.back();
              // Navigate to product catalog or home page
            },
            child: Text(
              'Explore Products',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
    ;
  }

  Widget _buildCartContent() {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = cartController.cartItems[index];
                return CartCard(
                  productId: item.productId!,
                  rate: item.rate.toString(),
                  image: item.image,
                  name: item.name,
                  price: item.price,
                  quantity: item.quantity,
                );
              },
              childCount: cartController.cartItems.length,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                OrderSummary(
                  orderTotal: cartController.calculateTotalPrice(),
                  deliveryFee: 15.00,
                  total: cartController.calculateTotalPrice() + 15.00,
                ),
                SizedBox(height: 20),
                _buildCheckoutButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return Obx(() => ElevatedButton(
          onPressed: cartController.orderLoading.value
              ? null
              : () => cartController.createOrder(),
          child: cartController.orderLoading.value
              ? CircularProgressIndicator(color: Colors.white)
              : Text('Checkout', style: TextStyle(fontSize: 16.sp)),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: AppColor.primaryColor,
            padding: EdgeInsets.symmetric(vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            minimumSize: Size(double.infinity, 50),
          ),
        ));
  }
}
