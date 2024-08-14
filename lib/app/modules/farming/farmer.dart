import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:organicbazzar/app/modules/farming/summary_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TodayEarningsCard extends StatelessWidget {
  final double todayEarnings;
  final double yesterdayEarnings;
  final int totalLiters;

  const TodayEarningsCard({
    Key? key,
    required this.todayEarnings,
    required this.yesterdayEarnings,
    required this.totalLiters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double earningsDifference = todayEarnings - yesterdayEarnings;
    bool isIncrease = earningsDifference >= 0;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "आजको आम्दानी",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${todayEarnings.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          isIncrease
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: isIncrease ? Colors.green : Colors.red,
                        ),
                        Text(
                          '${earningsDifference.abs().toStringAsFixed(2)}',
                          style: TextStyle(
                            color: isIncrease ? Colors.green : Colors.red,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "हिजोको तुलनामा फरक",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn('कुल लिटर', '$totalLiters L'),
                _buildInfoColumn(
                    'हिजोको', '₹${yesterdayEarnings.toStringAsFixed(2)}'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
              color: Colors.green[800],
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class ShiftInfoCard extends StatelessWidget {
  final bool isMorning;
  final double totalLiters;
  final double snf;
  final double fat;
  final double pricePerLiter;
  final double totalAmount;

  const ShiftInfoCard({
    Key? key,
    required this.isMorning,
    required this.totalLiters,
    required this.snf,
    required this.fat,
    required this.pricePerLiter,
    required this.totalAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat("#,##0.00", "ne_NP");
    final literFormat = NumberFormat("#,##0.0", "ne_NP");

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isMorning
                ? [
                    const Color.fromARGB(255, 131, 96, 44),
                    const Color.fromARGB(255, 152, 76, 165)
                  ]
                : [Color(0xFF7E57C2), Color(0xFFB39DDB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isMorning ? "बिहानी पाली" : "बेलुकी पाली",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  isMorning ? Icons.wb_sunny : Icons.nights_stay,
                  color: Colors.white,
                  size: 28,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoColumn(
                    "कुल दूध", "${literFormat.format(totalLiters)} लि"),
                _buildInfoColumn("एस.एन.एफ", "${snf.toStringAsFixed(1)}%"),
                _buildInfoColumn("फ्याट", "${fat.toStringAsFixed(1)}%"),
              ],
            ),
            SizedBox(height: 20),
            _buildPriceInfo(numberFormat),
            SizedBox(height: 15),
            _buildTotalAmount(numberFormat),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(right: 19.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style:
                TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceInfo(NumberFormat formatter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "प्रति लिटर मूल्य",
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 16),
        ),
        SizedBox(height: 4),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "₹${formatter.format(pricePerLiter)}",
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTotalAmount(NumberFormat formatter) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "कुल रकम  ",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        Text(
          "₹${formatter.format(totalAmount)}",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class FifteenDayEarningsSection extends StatelessWidget {
  final List<double> dailyEarnings;
  final double totalEarnings;
  final bool isbutton;

  FifteenDayEarningsSection({
    Key? key,
    required this.dailyEarnings,
    required this.totalEarnings,
    this.isbutton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat("#,##0.00", "en_US");
    final dateFormat = DateFormat("dd MMM");
    final DateTime now = DateTime.now();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "१५ दिनको आम्दानी",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                if (isbutton)
                  ElevatedButton.icon(
                    onPressed: () => Get.to(() => SummaryPage()),
                    icon: Icon(Icons.visibility, size: 18),
                    label: Text("विस्तृत हेर्नुहोस्"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              '₹ ${numberFormat.format(totalEarnings)}',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            Text(
              "कुल आम्दानी",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 30),
            SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 1000,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: Colors.grey[300],
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            NumberFormat.compact(locale: "ne_NP").format(value),
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 12),
                          );
                        },
                        reservedSize: 40,
                      ),
                    ),
                    topTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles:
                        AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: 14,
                  minY: 0,
                  maxY: dailyEarnings.reduce((a, b) => a > b ? a : b) * 1.2,
                  lineBarsData: [
                    LineChartBarData(
                      spots: dailyEarnings.asMap().entries.map((entry) {
                        return FlSpot(entry.key.toDouble(), entry.value);
                      }).toList(),
                      isCurved: true,
                      color: Colors.green[700],
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.green[200]!.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "पछिल्लो १५ दिनको दैनिक आम्दानी",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherSection extends StatelessWidget {
  final String temperature;
  final String condition;
  final String humidity;
  final String windSpeed;

  WeatherSection({
    required this.temperature,
    required this.condition,
    required this.humidity,
    required this.windSpeed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(15.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.green[800]),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            SizedBox(width: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  temperature,
                  style: TextStyle(
                    color: Colors.green[800],
                    fontSize: 23.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 5.w),
                Text(
                  condition,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 17.sp,
                  ),
                ),
              ],
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildInfoRow(Icons.water_drop, humidity),
                SizedBox(height: 8),
                _buildInfoRow(Icons.air, windSpeed),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.green[800],
          size: 16,
        ),
        SizedBox(width: 5),
        Text(
          value,
          style: TextStyle(
            color: Colors.green[800],
            fontSize: 17.sp,
          ),
        ),
      ],
    );
  }
}

class NotificationsSection extends StatelessWidget {
  final List<Map<String, String>> notifications;

  const NotificationsSection({Key? key, required this.notifications})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notifications",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ElevatedButton.icon(
                  onPressed: () => Get.to(() => SummaryPage()),
                  icon: Icon(Icons.visibility, size: 18),
                  label: Text("विस्तृत हेर्नुहोस्"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Container(
                    width: 150, // Adjust width as needed
                    margin: EdgeInsets.only(right: 8),
                    child: Card(
                      elevation: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display image
                          ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(8)),
                            child: Image.network(
                              notification['image']!,
                              width: double.infinity,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // Display title
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              notification['title']!,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
