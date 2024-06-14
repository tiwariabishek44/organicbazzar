import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
              'https://via.placeholder.com/150'), // Placeholder for profile image
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Robert Martiz',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Los Angeles', style: TextStyle(color: Colors.grey)),
          ],
        )
      ],
    );
  }
}
