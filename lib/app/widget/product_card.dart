import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/api_endpoint.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/model/cart_response_model.dart';
import 'package:organicbazzar/app/model/produc_response.dart';
import 'package:organicbazzar/app/modules/cart/cart_controller.dart';
import 'package:organicbazzar/app/modules/product_details/product_detail.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class ProductCard extends StatelessWidget {
  final ProductResponse product;

  ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);
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
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: const Color.fromARGB(
                  255, 202, 202, 202)), // Light grey-black border color
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: ApiEndpoints.baseUrl + product.filePath,
                height: 120,
                width: 199,
                fit: BoxFit.fill,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 120,
                    width: 199,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/placeholder.png',
                  height: 120,
                  width: 199,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.0,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Rs.${product.price}',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.green,
                          fontSize: 16.0.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  if (product.stockStatus != 'INSTOCK')
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          // backgroundColor: const Color.fromARGB(255, 231, 235, 231),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Color.fromARGB(255, 224, 240, 225),
                            ), // Set border color to green
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'Out of stock',
                          style: TextStyle(
                              fontSize: 17.0.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ),
                    )
                  else
                    Obx(() {
                      if (cartController.isInCart(product.name)) {
                        var quantity =
                            cartController.getProductQuantity(product.name).obs;

                        return Row(
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
                                          product.name, quantity.value - 1);
                                    } else if (quantity.value == 1) {
                                      cartController
                                          .removeFromCart(product.name);
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
                                        product.name, quantity.value + 1);
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    size: 19.sp,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              )
                            ]);
                      } else {
                        return Center(
                          child: ElevatedButton(
                            onPressed: () {
                              cartController.addToCart(
                                CartItem(
                                  productId: product.id,
                                  name: product.name,
                                  price: product.price,
                                  image: product.filePath,
                                  rate: product.price,
                                  quantity: 1,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              // backgroundColor: const Color.fromARGB(255, 231, 235, 231),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.green,
                                ), // Set border color to green
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              'Add to cart',
                              style: TextStyle(
                                  fontSize: 17.0.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                        );
                      }
                    })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
