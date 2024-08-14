import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/modules/order/order_controller.dart';
import 'package:organicbazzar/app/service/http_client.dart';

class OrderDetailedController extends GetxController {
  final isLoading = false.obs;
  final orderController = Get.find<MyOrderController>();

  void showSuccessPopup(String message) {
    Get.dialog(
      CustomPopup(
        title: 'Success',
        message: message,
        icon: Icons.check_circle,
        iconColor: Colors.green,
      ),
    );
  }

  void showErrorPopup(String message) {
    Get.dialog(
      CustomPopup(
        title: 'Error',
        message: message,
        icon: Icons.error,
        iconColor: Colors.red,
      ),
    );
  }

  Future<void> cancelOrder(int orderId) async {
    final url =
        "https://businessitpartners.website/api/ecommerce/user/cancel-order/$orderId";

    try {
      isLoading(true);
      log("Attempting to cancel order $orderId");
      final response = await httpClient.delete(Uri.parse(url));
      log('Response status code: ${response.statusCode}');

      switch (response.statusCode) {
        case 200:
        case 204:
          log('Order cancelled successfully');
          showSuccessPopup('Your order has been successfully cancelled.');
          await orderController.getOrders(); // Refresh the orders list
          break;
        case 500:
          log('Internal Server Error: ${response.body}');
          showErrorPopup(
              'We encountered a server error. Please try again later.');
          break;
        default:
          log('Unexpected status code: ${response.statusCode}');
          log('Response body: ${response.body}');
          showErrorPopup('An unexpected error occurred. Please try again.');
      }
    } catch (e) {
      log('Error cancelling order: $e');
      showErrorPopup(
          'An error occurred while cancelling the order. Please try again.');
    } finally {
      isLoading(false);
    }
  }
}

class CustomPopup extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Color iconColor;

  const CustomPopup({
    Key? key,
    required this.title,
    required this.message,
    required this.icon,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, top: 65, right: 20, bottom: 20),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: Offset(0, 10),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 15),
              Text(
                message,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 22),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Close',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(45)),
              child: Icon(icon, color: iconColor, size: 80),
            ),
          ),
        ),
      ],
    );
  }
}
