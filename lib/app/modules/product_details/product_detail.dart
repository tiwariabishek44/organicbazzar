import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/model/cart_response_model.dart';
import 'package:organicbazzar/app/model/produc_response.dart';
import 'package:organicbazzar/app/modules/product_details/utils/out_of_stock.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';
import '../cart/cart_controller.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductResponse product;

  ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final CartController cartController = Get.put(CartController());

  int quantity = 1;

  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isInCart = cartController.isInCart(widget.product.name);
    log(
      "${ApiEndpoints.baseUrl}${widget.product.filePath}",
    );

    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Product Details',
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, size: 22.sp, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Images with zoom functionality
            Container(
              height: 300,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: CachedNetworkImage(
                  imageUrl: "${ApiEndpoints.baseUrl}${widget.product.filePath}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    'assets/placeholder.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: AppPadding.screenHorizontalPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  // Product Title and Price
                  // to display proucdt id
                  Text(
                    'Product ID: ${widget.product.id}',
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        'Rs.${widget.product.price}',
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Container(
                        // curve decoration with red background
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                        decoration: BoxDecoration(
                          color: widget.product.stockStatus != 'INSTOCK'
                              ? Colors.red
                              : Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 5),
                            Text(
                              widget.product.stockStatus != 'INSTOCK'
                                  ? 'Out of Stock'
                                  : 'In Stock',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // Stock Status

                  SizedBox(height: 10),
                  // Product Description
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          widget.product.description,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),
                  // Add to Cart Button

                  Obx(() {
                    if (cartController.isInCart(widget.product.name)) {
                      var quantity = cartController
                          .getProductQuantity(widget.product.name)
                          .obs;

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Quantity',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20,
                                  // Add green border
                                  foregroundColor: Colors.green,
                                  child: IconButton(
                                    onPressed: () {
                                      if (quantity.value > 1) {
                                        cartController.updateCartItemQuantity(
                                            widget.product.name,
                                            quantity.value - 1);
                                      } else if (quantity.value == 1) {
                                        cartController.removeFromCart(
                                            widget.product.name);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                      color: Colors.green,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  '${quantity.value}',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                SizedBox(width: 10),
                                CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Color(0xff93C22F),
                                  child: IconButton(
                                    onPressed: () {
                                      cartController.updateCartItemQuantity(
                                          widget.product.name,
                                          quantity.value + 1);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      size: 19.sp,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                    ),
                                  ),
                                )
                              ]),
                        ],
                      );
                    } else {
                      return Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (widget.product.stockStatus != 'INSTOCK') {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return OutOfStockPopup(
                                        productName: "Organic Apples",
                                        onNotifyMe: () {},
                                      );
                                    });
                              } else {
                                cartController.addToCart(
                                  CartItem(
                                    productId: widget.product.id,
                                    name: widget.product.name,
                                    price: widget.product.price,
                                    image: widget.product.filePath,
                                    rate: widget.product.price,
                                    quantity: 1,
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff93C22F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              isInCart ? 'Update Cart' : 'Add to Cart',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  }),

                  SizedBox(height: 20),
                  // Customer Reviews Section

                  Divider(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
