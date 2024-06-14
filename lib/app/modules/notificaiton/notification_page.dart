import 'package:flutter/material.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({Key? key});

  final List<Map<String, String>> notifications = [
    {
      'title':
          'QR Health 772340 is your token verification code. For your security, do not share this code.',
      'time': '2d ago',
      'initial': 'QR',
    },
    {
      'title':
          'You have just had the vaccine, for further information click here',
      'time': '5w ago',
      'initial': 'VC',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Notifications', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.black),
            onPressed: () {
              // Implement filter action
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            leading: CircleAvatar(
              backgroundColor: AppColor.primaryColor,
              child: Text(
                notification['initial']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              notification['title']!,
              style: TextStyle(fontSize: 16.sp, color: Colors.black87),
            ),
            subtitle: Text(
              notification['time']!,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey),
            ),
            onTap: () {
              // Handle notification tap
            },
          );
        },
      ),
    );
  }
}
