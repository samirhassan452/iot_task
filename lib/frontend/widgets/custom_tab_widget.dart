import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_task/frontend/utils/constants.dart';
import 'package:iot_task/frontend/widgets/widgets.dart';

class CustomTabWidget extends StatelessWidget {
  final String? text;
  final String? icon;
  final bool? isActive;
  const CustomTabWidget({
    Key? key,
    @required this.text,
    @required this.icon,
    @required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: isActive! ? null : Colors.grey.shade800,
        gradient: isActive!
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  fGradColor,
                  sGradColor,
                ],
              )
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            icon!,
            width: 25,
            height: 25,
            color: Colors.white,
          ),
          CustomTextWidget(
            text: text,
            textSize: 18,
          ),
        ],
      ),
    );
  }
}
