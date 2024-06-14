import 'package:flutter/material.dart';
import 'package:organicbazzar/app/config/colors.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:organicbazzar/app/modules/order/utils/all_order_tab.dart';
import 'package:organicbazzar/app/modules/order/utils/history_order.dart';
import 'package:organicbazzar/app/modules/order/utils/order_tile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage>
    with SingleTickerProviderStateMixin {
  @override
  late TabController _tabController;
  bool _isAllOrdersTabActive = true;
  bool _isHistoryTabActive = false;
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {
          if (_tabController.index == 0) {
            _isAllOrdersTabActive = true;
            _isHistoryTabActive = false;
          } else {
            _isAllOrdersTabActive = false;
            _isHistoryTabActive = true;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 24.0,
        title: Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text(
            'Orders',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21.sp),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.receipt, size: 22.sp, color: Colors.black),
                    SizedBox(width: 8),
                    Text('All orders',
                        style: TextStyle(color: Colors.black, fontSize: 17.sp)),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.history, size: 22.sp, color: Colors.black),
                    SizedBox(width: 8),
                    Text('History',
                        style: TextStyle(color: Colors.black, fontSize: 17.sp)),
                  ],
                ),
              ),
            ],
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 4.0,
                ),
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 4.0,
            labelColor: Colors.black,
            splashFactory: NoSplash.splashFactory,
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed) ||
                    states.contains(MaterialState.focused) ||
                    states.contains(MaterialState.hovered)) {
                  return Colors.grey.withOpacity(0.2);
                }
                return null;
              },
            ),
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) => true,
        child: TabBarView(
          controller: _tabController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _isAllOrdersTabActive
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: AllOrdersTab(),
                  )
                : SizedBox.shrink(),
            _isHistoryTabActive
                ? Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: HistoryOrderTAb(),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
