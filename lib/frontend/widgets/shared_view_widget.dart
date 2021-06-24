import 'package:flutter/material.dart';
import 'package:iot_task/frontend/utils/utils.dart';
import 'package:iot_task/frontend/widgets/widgets.dart';

class SharedViewWidget extends StatelessWidget {
  final String? text;
  const SharedViewWidget({Key? key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 3,
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        color: primaryColor,
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding * 1.7),
          child: CustomTextWidget(
            text: text,
            textSize: text!.length > 30 ? 18 : 20,
          ),
        ),
      ),
    );
  }
}
