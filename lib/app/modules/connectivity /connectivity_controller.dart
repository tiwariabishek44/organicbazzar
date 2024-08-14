import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  var isInternetConnected = true.obs;
  OverlayEntry? overlayEntry;

  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      print("Couldn't check connectivity status: $e");
      return;
    }
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    bool isConnected = (result != ConnectivityResult.none);
    if (isConnected != isInternetConnected.value) {
      isInternetConnected.value = isConnected;
      if (!isConnected) {
        _showNoInternetOverlay();
      } else {
        _removeNoInternetOverlay();
      }
    }
  }

  void _showNoInternetOverlay() {
    if (overlayEntry == null) {
      overlayEntry = OverlayEntry(
        builder: (context) => NoInternetOverlay(
          onRetry: () => _initConnectivity(),
        ),
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Overlay.of(Get.overlayContext!)?.insert(overlayEntry!);
      });
    }
  }

  void _removeNoInternetOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  void onClose() {
    _removeNoInternetOverlay();
    super.onClose();
  }
}

class NoInternetOverlay extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetOverlay({Key? key, required this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.9),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/nointernet.png'),
            Padding(
              padding: const EdgeInsets.all(19.0),
              child: Text(
                'Please check your connection and try again',
                style: TextStyle(
                  fontSize: 19.sp,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// class NoInternetScreen extends StatelessWidget {
//   final VoidCallback onRetry;

//   NoInternetScreen({required this.onRetry});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset('assets/nointernet.png'),
//               Padding(
//                 padding: const EdgeInsets.all(19.0),
//                 child: Text(
//                   'Please check your connection and try again',
//                   style: TextStyle(
//                     fontSize: 19.sp,
//                     color: Colors.grey[600],
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
