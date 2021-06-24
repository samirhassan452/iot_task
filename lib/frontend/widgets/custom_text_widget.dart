import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final double? textSize;
  final FontWeight? fontWeight;

  const CustomTextWidget({
    Key? key,
    @required this.text,
    this.textColor = Colors.white,
    this.textSize = 22.0,
    this.fontWeight = FontWeight.w700,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
        color: textColor,
        fontSize: textSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
