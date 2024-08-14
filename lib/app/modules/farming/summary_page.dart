import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  String selectedMonth = 'बैशाख';
  String selectedRange = '1-15';
  final List<String> months = [
    'बैशाख',
    'जेष्ठ',
    'अषाढ',
    'श्रावण',
    'भाद्र',
    'आश्विन',
    'कार्तिक',
    'मंसिर',
    'पौष',
    'माघ',
    'फाल्गुन',
    'चैत्र'
  ];
  final List<String> ranges = ['1-15', '16-30'];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    List<double> dailyEarnings = [
      28,
      30,
      32,
      34,
      36,
      20,
      22,
      24,
      36,
      28,
      30,
      32,
      34,
      36
    ];
    double totalEarnings = dailyEarnings.reduce((a, b) => a + b);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title:
            Text('मासिक सारांश', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.green[700],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(totalEarnings),
            SizedBox(height: 16),
            SizedBox(height: 16),
            _buildQualityGraph(),
            SizedBox(height: 16),
            _buildDailyRecordsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(double totalEarnings) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[700],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDropdown(
                value: selectedMonth,
                items: months,
                onChanged: (newValue) {
                  setState(() {
                    selectedMonth = newValue!;
                    _loadData();
                  });
                },
                hint: 'महिना',
              ),
              _buildDropdown(
                value: selectedRange,
                items: ranges,
                onChanged: (newValue) {
                  setState(() {
                    selectedRange = newValue!;
                    _loadData();
                  });
                },
                hint: 'मिति',
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'कुल आम्दानी',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 8),
          isLoading
              ? _buildShimmerTotalEarnings()
              : Text(
                  '₹${NumberFormat("#,##0.00", "en_US").format(totalEarnings)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildQualityGraph() {
    // Sample data for SNF and Fat
    final List<FlSpot> snfSpots = [
      FlSpot(1, 8.5),
      FlSpot(2, 8.6),
      FlSpot(3, 8.4),
      FlSpot(4, 8.7),
      FlSpot(5, 8.5),
      FlSpot(6, 8.6),
      FlSpot(7, 8.5),
      FlSpot(8, 8.4),
      FlSpot(9, 8.6),
      FlSpot(10, 8.7),
      FlSpot(11, 8.5),
      FlSpot(12, 8.6),
      FlSpot(13, 8.4),
      FlSpot(14, 8.5),
      FlSpot(15, 8.6),
    ];

    final List<FlSpot> fatSpots = [
      FlSpot(1, 3.5),
      FlSpot(2, 3.6),
      FlSpot(3, 3.4),
      FlSpot(4, 3.7),
      FlSpot(5, 3.5),
      FlSpot(6, 3.6),
      FlSpot(7, 3.5),
      FlSpot(8, 3.4),
      FlSpot(9, 3.6),
      FlSpot(10, 3.7),
      FlSpot(11, 3.5),
      FlSpot(12, 3.6),
      FlSpot(13, 3.4),
      FlSpot(14, 3.5),
      FlSpot(15, 3.6),
    ];

    return isLoading
        ? // make a shrimmer container  of the width screen widht and corner as rectangle little bit curve
        SizedBox.shrink()
        : Card(
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'दूधको गुणस्तर ग्राफ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 300,
                    child: LineChart(
                      LineChartData(
                        gridData:
                            FlGridData(show: true, drawVerticalLine: true),
                        titlesData: FlTitlesData(
                          show: true,
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: false,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  NumberFormat.compact(locale: "ne_NP")
                                      .format(value),
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 12),
                                );
                              },
                              reservedSize: 40,
                            ),
                          ),
                          topTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: false)),
                        ),
                        borderData: FlBorderData(show: true),
                        minX: 1,
                        maxX: 15,
                        minY: 0,
                        maxY: 10,
                        lineBarsData: [
                          LineChartBarData(
                            spots: snfSpots,
                            isCurved: true,
                            color: Colors.blue,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                          ),
                          LineChartBarData(
                            spots: fatSpots,
                            isCurved: true,
                            color: Colors.red,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendItem('SNF', Colors.blue),
                      SizedBox(width: 20),
                      _buildLegendItem('फ्याट', Colors.red),
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        SizedBox(width: 4),
        Text(label),
      ],
    );
  }

  Widget _buildDailyRecordsList() {
    final List<Map<String, dynamic>> milkData = [
      {
        "date": "2024-01-01",
        "morning": {
          "liters": 10.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 500.0
        },
        "evening": {
          "liters": 8.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 400.0
        }
      },
      {
        "date": "2024-01-01",
        "morning": {
          "liters": 10.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 500.0
        },
        "evening": {
          "liters": 8.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 400.0
        }
      },
      {
        "date": "2024-01-01",
        "morning": {
          "liters": 10.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 500.0
        },
        "evening": {
          "liters": 8.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 400.0
        }
      },
      {
        "date": "2024-01-01",
        "morning": {
          "liters": 10.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 500.0
        },
        "evening": {
          "liters": 8.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 400.0
        }
      },
      {
        "date": "2024-01-01",
        "morning": {
          "liters": 10.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 500.0
        },
        "evening": {
          "liters": 8.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 400.0
        }
      },
      {
        "date": "2024-01-01",
        "morning": {
          "liters": 10.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 500.0
        },
        "evening": {
          "liters": 8.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 400.0
        }
      },
      {
        "date": "2024-01-01",
        "morning": {
          "liters": 10.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 500.0
        },
        "evening": {
          "liters": 8.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 400.0
        }
      },
      {
        "date": "2024-01-01",
        "morning": {
          "liters": 10.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 500.0
        },
        "evening": {
          "liters": 8.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 400.0
        }
      },
      {
        "date": "2024-01-01",
        "morning": {
          "liters": 10.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 500.0
        },
        "evening": {
          "liters": 8.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 400.0
        }
      },
      {
        "date": "2024-01-01",
        "morning": {
          "liters": 10.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 500.0
        },
        "evening": {
          "liters": 8.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 400.0
        }
      },
      {
        "date": "2024-01-01",
        "morning": {
          "liters": 10.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 500.0
        },
        "evening": {
          "liters": 8.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 400.0
        }
      },
      {
        "date": "2024-01-01",
        "morning": {
          "liters": 10.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 500.0
        },
        "evening": {
          "liters": 8.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 400.0
        }
      },
      {
        "date": "2024-01-01",
        "morning": {
          "liters": 10.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 500.0
        },
        "evening": {
          "liters": 8.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 400.0
        }
      },
      {
        "date": "2024-01-01",
        "morning": {
          "liters": 10.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 500.0
        },
        "evening": {
          "liters": 8.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 400.0
        }
      },
      {
        "date": "2024-01-01",
        "morning": {
          "liters": 10.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 500.0
        },
        "evening": {
          "liters": 8.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 400.0
        }
      },
      {
        "date": "2024-01-01",
        "morning": {
          "liters": 10.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 500.0
        },
        "evening": {
          "liters": 8.0,
          "rate": 50.0,
          'snf': 5.5,
          'fat': 4.4,
          "total": 400.0
        }
      },
    ];

    return isLoading
        ? _buildShimmerList()
        : ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: milkData.length,
            itemBuilder: (context, index) {
              final data = milkData[index];
              return _buildDailyRecord(data);
            },
          );
  }

  Widget _buildDailyRecord(Map<String, dynamic> data) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('MMMM d, yyyy').format(DateTime.parse(data['date'])),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ShiftInfoCard(
                    isMorning: true,
                    totalLiters: data['morning']['liters'],
                    pricePerLiter: data['morning']['rate'],
                    totalAmount: data['morning']['total'],
                    snf: data['morning']['snf'],
                    fat: data['morning']['fat'],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ShiftInfoCard(
                    isMorning: false,
                    totalLiters: data['evening']['liters'],
                    pricePerLiter: data['evening']['rate'],
                    totalAmount: data['evening']['total'],
                    snf: data['evening']['snf'],
                    fat: data['evening']['fat'],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    required String hint,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint),
          icon: Icon(Icons.arrow_drop_down, color: Colors.green[700]),
          style: TextStyle(color: Colors.green[700], fontSize: 16),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  // build shimmer chart
  Widget _buildShimmerChart() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerTotalEarnings() {
    return Shimmer.fromColors(
      baseColor: Colors.white54,
      highlightColor: Colors.white,
      child: Container(
        width: 200,
        height: 40,
        color: Colors.white,
      ),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (_, __) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(height: 150, color: Colors.white),
        ),
      ),
    );
  }

  void _loadData() {
    setState(() {
      isLoading = true;
    });
    // Simulate API call
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }
}

class ShiftInfoCard extends StatelessWidget {
  final bool isMorning;
  final double totalLiters;
  final double pricePerLiter;
  final double totalAmount;
  final double snf;
  final double fat;

  const ShiftInfoCard({
    Key? key,
    required this.isMorning,
    required this.totalLiters,
    required this.pricePerLiter,
    required this.totalAmount,
    required this.snf,
    required this.fat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat("#,##0.00", "en_US");
    final literFormat = NumberFormat("#,##0.0", "en_US");

    return Container(
      decoration: BoxDecoration(
        color: isMorning ? Colors.orange[100] : Colors.purple[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isMorning ? Colors.orange[300]! : Colors.purple[300]!,
          width: 2,
        ),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isMorning ? "बिहान" : "बेलुका",
                style: TextStyle(
                  color: isMorning ? Colors.orange[800] : Colors.purple[800],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                isMorning ? Icons.wb_sunny : Icons.nights_stay,
                color: isMorning ? Colors.orange[800] : Colors.purple[800],
                size: 24,
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            "${literFormat.format(totalLiters)} लिटर",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(height: 4),
          // row to show the snf and the fat with the respective nuber
          Column(
            children: [
              _buildInfoColumn("एस.एन.एफ", "${snf.toStringAsFixed(1)}%"),
              _buildInfoColumn("फ्याट", "${fat.toStringAsFixed(1)}%"),
              // add rate also

              _buildInfoColumn(
                  "प्रति लि", "₹${numberFormat.format(pricePerLiter)}"),
              // to show the total
              _buildInfoColumn("कुल", "₹${numberFormat.format(totalAmount)}"),
            ],
          ),
          // Text(
          //   "₹${numberFormat.format(totalAmount)}",
          //   style: TextStyle(
          //     color: Colors.green[700],
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.black, fontSize: 16.sp),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: label == 'कुल'
                ? Color.fromARGB(255, 25, 130, 28)
                : Colors.black,
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
