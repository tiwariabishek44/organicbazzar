import 'package:flutter/material.dart';
import 'package:organicbazzar/app/config/colors.dart'; // Assuming this file contains color definitions

class OrderDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Detail'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Number and Status
            _buildOrderInfoSection(),

            SizedBox(height: 16),

            // Delivery Address
            _buildInfoSection(
                'Delivered to', '1633 Hampton Meadows, Lexington'),

            SizedBox(height: 16),

            // Payment Method
            _buildInfoSection('Payment Method', 'Apple Pay'),

            SizedBox(height: 16),

            // Items List
            _buildItemRow('Ocean Reach Oatmeal Stout x 2', '\$19.00', '8 Pack'),
            _buildItemRow('Stone Peak Conditions x 1', '\$2.33', 'Single'),
            _buildItemRow('Budweiser x 1', '\$1.73', 'Single'),

            Divider(thickness: 1, color: Colors.grey),

            // Summary Section
            _buildSummaryRow('Item Total', '\$23.06'),
            _buildSummaryRow('Delivery Charges', '\$2.00'),
            _buildSummaryRow('Donate \$1.00 to Needy', '\$1.00'),

            Divider(thickness: 1, color: Colors.grey),

            _buildSummaryRow('Total ', '\$26.06'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderInfoSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '#5689045678',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            Text(
              '27 May, 2020',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        Text(
          'Delivered',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildInfoSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        SizedBox(height: 4),
        Text(
          content,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildItemRow(String item, String price, String quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item, style: TextStyle(fontSize: 16)),
              Text(quantity, style: TextStyle(color: Colors.grey)),
            ],
          ),
          Text(price, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 16)),
          Text(value,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
