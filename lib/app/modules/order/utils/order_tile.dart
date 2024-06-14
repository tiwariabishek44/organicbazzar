import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/order_details/order_detials_page.dart';

class OrderTile extends StatelessWidget {
  final String status;
  final String orderDate;
  final String shippingDate;
  final String orderNumber;

  const OrderTile({
    required this.status,
    required this.orderDate,
    required this.shippingDate,
    required this.orderNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.screenHorizontalPadding,
      child: GestureDetector(
        onTap: () {
          Get.to(() => OrderDetailsPage());
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 213, 212, 212).withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: statusColor(status),
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.calendar_today, size: 16.0),
                  SizedBox(width: 8.0),
                  Text(orderDate),
                ],
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Icon(Icons.assignment, size: 16.0),
                  SizedBox(width: 8.0),
                  Text(orderNumber),
                ],
              ),
              SizedBox(height: 8.0),
              // Row(
              //   children: [
              //     Icon(Icons.local_shipping, size: 16.0),
              //     SizedBox(width: 8.0),
              //     Text('Shipping Date: $shippingDate'),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Color statusColor(String status) {
    switch (status) {
      case 'Processing':
        return Colors.orange;
      case 'Shipment on the way':
        return Colors.blue;
      case 'Delivered':
        return Colors.green;
      default:
        return Colors.black;
    }
  }
}
