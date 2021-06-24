import 'package:flutter/material.dart';
import 'package:iot_task/frontend/utils/utils.dart';
import 'package:iot_task/frontend/widgets/widgets.dart';

class PowerScreen extends StatelessWidget {
  final String? screenName;
  const PowerScreen({Key? key, @required this.screenName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SharedViewWidget(
        text: "Power ON/OFF your home",
      ),
    );
  }
}
