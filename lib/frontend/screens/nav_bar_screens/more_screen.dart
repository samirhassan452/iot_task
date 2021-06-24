import 'package:flutter/material.dart';
import 'package:iot_task/frontend/utils/utils.dart';
import 'package:iot_task/frontend/widgets/widgets.dart';

class MoreScreen extends StatelessWidget {
  final String? screenName;
  const MoreScreen({Key? key, @required this.screenName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SharedViewWidget(
        text: "Customize your settings",
      ),
    );
  }
}
