import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:organicbazzar/app/config/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Blurred background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        // Loading indicator
        Center(
            child: SpinKitFadingCircle(
          color: Color.fromARGB(255, 0, 173, 0),
        )),
      ],
    );
  }
}
