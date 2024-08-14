import 'package:flutter/material.dart';
import 'package:organicbazzar/app/modules/farming/farmer.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FarmerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data
    double todayEarnings = 3000.0;
    List<double> fifteenDayEarnings =
        List.generate(15, (index) => (index + 1) * 200.0);
    List<double> dailyEarnings = [
      1000,
      1200,
      950,
      1100,
      1300,
      1150,
      1000,
      1250,
      1100,
      1300,
      1200,
      1150,
      1050,
      1100,
      1300
    ];

    double totalEarnings = 45000;
    return Scaffold(
      // drawer
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/leaf.png'),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Farmer Name',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 4.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: WeatherSection(
                temperature: '28°',
                condition: 'Sunny',
                humidity: '60%',
                windSpeed: '5 km/h',
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: TodayEarningsCard(
                todayEarnings: 3000.0,
                yesterdayEarnings: 2800.0,
                totalLiters: 95,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ShiftInfoCard(
                      isMorning: true,
                      totalLiters: 50.5,
                      snf: 8.5,
                      fat: 3.5,
                      pricePerLiter: 30.0,
                      totalAmount: 1515.0,
                    ),
                    SizedBox(width: 16),
                    ShiftInfoCard(
                      isMorning: false,
                      totalLiters: 45.0,
                      snf: 8.7,
                      fat: 3.6,
                      pricePerLiter: 31.0,
                      totalAmount: 1395.0,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: FifteenDayEarningsSection(
                dailyEarnings: dailyEarnings,
                totalEarnings: totalEarnings,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            // notice
            const NotificationsSection(
              notifications: [
                {
                  'image':
                      'https://media.istockphoto.com/id/1282514444/photo/cow-udder-large-and-full-and-with-horns-in-the-green-pasture-and-a-blue-sky.jpg?s=612x612&w=0&k=20&c=a2TuO1u4H4wKW7aSizBh7Df8CLA70MEPTcadLfc35bk=', // Replace with actual image URL
                  'title':
                      'The goverment has allow to give the new level of the prfamer '
                },
                {
                  'image':
                      'https://media.istockphoto.com/id/1282514444/photo/cow-udder-large-and-full-and-with-horns-in-the-green-pasture-and-a-blue-sky.jpg?s=612x612&w=0&k=20&c=a2TuO1u4H4wKW7aSizBh7Df8CLA70MEPTcadLfc35bk=', // Replace with actual image URL
                  'title':
                      'The goverment has allow to give the new level of the prfamer '
                },
                {
                  'image':
                      'https://media.istockphoto.com/id/1282514444/photo/cow-udder-large-and-full-and-with-horns-in-the-green-pasture-and-a-blue-sky.jpg?s=612x612&w=0&k=20&c=a2TuO1u4H4wKW7aSizBh7Df8CLA70MEPTcadLfc35bk=', // Replace with actual image URL
                  'title':
                      'The goverment has allow to give the new level of the prfamer '
                },
                {
                  'image':
                      'https://media.istockphoto.com/id/1282514444/photo/cow-udder-large-and-full-and-with-horns-in-the-green-pasture-and-a-blue-sky.jpg?s=612x612&w=0&k=20&c=a2TuO1u4H4wKW7aSizBh7Df8CLA70MEPTcadLfc35bk=', // Replace with actual image URL
                  'title':
                      'The goverment has allow to give the new level of the prfamer '
                },
                {
                  'image':
                      'https://media.istockphoto.com/id/1282514444/photo/cow-udder-large-and-full-and-with-horns-in-the-green-pasture-and-a-blue-sky.jpg?s=612x612&w=0&k=20&c=a2TuO1u4H4wKW7aSizBh7Df8CLA70MEPTcadLfc35bk=', // Replace with actual image URL
                  'title':
                      'The goverment has allow to give the new level of the prfamer '
                },
                {
                  'image':
                      'https://media.istockphoto.com/id/1282514444/photo/cow-udder-large-and-full-and-with-horns-in-the-green-pasture-and-a-blue-sky.jpg?s=612x612&w=0&k=20&c=a2TuO1u4H4wKW7aSizBh7Df8CLA70MEPTcadLfc35bk=', // Replace with actual image URL
                  'title':
                      'The goverment has allow to give the new level of the prfamer '
                },
              ],
            ),
          ],
        ),
      ),
    );
  }
}
