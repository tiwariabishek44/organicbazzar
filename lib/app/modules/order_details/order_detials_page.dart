import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/model/get_order_response.dart';
import 'package:intl/intl.dart';
import 'package:organicbazzar/app/modules/order_details/order_details_controller.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderDetailsPage extends StatelessWidget {
  final Orders order;

  OrderDetailsPage({required this.order});
  final orderDetailController = Get.put(OrderDetailedController());
  // Custom color palette
  final Color primaryGreen = Color(0xFF4CAF50);
  final Color secondaryGreen = Color(0xFF81C784);
  final Color backgroundCream = Color(0xFFF5F5DC);
  final Color textDark = Color(0xFF333333);
  final Color textLight = Color(0xFF757575);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColor.backgroundColor,
        title: Text('Order Details', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderStatusCard(),
            _buildSectionTitle('Order Items'),
            _buildOrderItemsList(),
            _buildSectionTitle('Order Summary'),
            _buildOrderSummary(),
            _buildPaymentInfo(),
            SizedBox(height: 3.h),
            order.status == 'ORDERED'
                ? Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Obx(() => ElevatedButton(
                              onPressed: () =>
                                  orderDetailController.cancelOrder(order.id),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: orderDetailController.isLoading.value
                                  ? const Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text('Cancel Order',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                      )),
                            )),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            SizedBox(
              height: 5.h,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatusCard() {
    return Card(
      margin: EdgeInsets.all(16),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order #${order.id}',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen),
            ),
            SizedBox(height: 8),
            Text(
              'Placed on ${DateFormat('MMMM d, yyyy').format(DateTime.parse(order.creationDate))}',
              style: TextStyle(color: textLight),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.circle,
                    color: order.status == 'ORDERED'
                        ? secondaryGreen
                        : primaryGreen,
                    size: 16),
                SizedBox(width: 8),
                Text(
                  order.status == 'ORDERED' ? 'Processing' : 'Delivered',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: textDark),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: textDark),
      ),
    );
  }

  Widget _buildOrderItemsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: order.orderDetails.length,
      itemBuilder: (context, index) {
        var detail = order.orderDetails[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.white,
          child: ListTile(
            contentPadding: EdgeInsets.all(16),
            leading: CircleAvatar(
              backgroundColor: secondaryGreen,
              child: Icon(Icons.eco, color: Colors.white),
            ),
            title: Text(detail.product.name,
                style: TextStyle(fontWeight: FontWeight.bold, color: textDark)),
            subtitle: Text('Quantity: ${detail.quantity.toInt()}',
                style: TextStyle(color: textLight)),
            trailing: Text(
              'Rs.${(detail.product.price * detail.quantity).toStringAsFixed(2)}',
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: primaryGreen),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrderSummary() {
    double totalAmount = order.orderDetails
        .fold(0, (sum, item) => sum + (item.product.price * item.quantity));

    return Card(
      margin: EdgeInsets.all(16),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSummaryRow(
                'Subtotal', 'Rs.${totalAmount.toStringAsFixed(2)}'),
            // _buildSummaryRow('Delivery Fee', '₹0.00'),
            Divider(color: textLight),
            _buildSummaryRow('Total', 'Rs.${totalAmount.toStringAsFixed(2)}',
                isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: isTotal ? 18 : 16,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  color: textDark)),
          Text(value,
              style: TextStyle(
                  fontSize: isTotal ? 18 : 16,
                  fontWeight: FontWeight.bold,
                  color: isTotal ? primaryGreen : textDark)),
        ],
      ),
    );
  }

  Widget _buildPaymentInfo() {
    return Card(
      margin: EdgeInsets.all(16),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Payment Method',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: textDark)),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.payment, color: primaryGreen),
                SizedBox(width: 8),
                Text('Cash on Delivery',
                    style: TextStyle(fontSize: 16, color: textDark)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
