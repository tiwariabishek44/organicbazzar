import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/cart/cart_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CartCard extends StatelessWidget {
  final String image;
  final String name;
  final String rate;
  final double price;

  CartCard({
    required this.image,
    required this.name,
    required this.rate,
    required this.price,
  });
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageWidth = constraints.maxWidth * 0.4;

        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 243, 243),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 5),
              ),
            ],
            //  / No shadow if isShadow is false
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS71yrunowsGOtqw2tISwOGDbHZBtPjUEyBHqN0inYXpFw0qH43rt_ALP-G67UdxOI5X9nJZkJcqI6RnK1WX2SiwrM_PEgICYOXgPVpOw",
                  width: imageWidth,
                  height: 15.h, // Assuming square image for simplicity
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppStyle.text().copyWith(
                          color: Color.fromARGB(255, 43, 40, 40),
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp),
                    ),
                    SizedBox(height: 4),
                    Text(
                      rate,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$$price',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {
                            final cartitem = CartItem(
                                name: name,
                                price: price,
                                image: image,
                                rate: double.parse(rate));
                            cartController.removeFromCart(cartitem);
                          },
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: Colors.grey.shade300,
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
