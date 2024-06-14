import 'package:flutter/material.dart';
import 'package:organicbazzar/app/config/style.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final String text;
  final Color? buttonColor;
  final Color? textColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.isLoading,
    this.buttonColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color defaultButtonColor =
        const Color.fromARGB(255, 0, 0, 0); // Default button color
    Color defaultTextColor = Colors.white; // Default text color

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 6.h,
          width: 100.w,
          decoration: BoxDecoration(
            color: buttonColor ?? defaultButtonColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(text,
                    style: AppStyle.text().copyWith(
                      color: textColor ?? defaultTextColor,
                      fontSize: 18.sp,
                    )),
          ),
        ),
      ),
    );
  }
}
