import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_task/frontend/utils/constants.dart';

class CustomCircular extends StatelessWidget {
  final String? icon;
  final Function? onTap;
  final bool? state;
  const CustomCircular({
    Key? key,
    @required this.icon,
    @required this.onTap,
    this.state = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap!(),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 5),
        width: 40,
        height: 40,
        decoration: state!
            ? BoxDecoration(
                border: null,
                borderRadius: BorderRadius.circular(24.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    fGradColor,
                    sGradColor,
                  ],
                ),
              )
            : BoxDecoration(
                border: Border.all(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(24.0),
              ),
        child: state!
            ? SvgPicture.asset(
                icon!,
                width: 20,
                height: 20,
                color: Colors.grey.shade800,
              )
            : SvgPicture.asset(
                icon!,
                width: 20,
                height: 20,
                color: Colors.white,
              ),
      ),
    );
  }
}
