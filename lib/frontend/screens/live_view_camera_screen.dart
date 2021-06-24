import 'package:flutter/material.dart';
import 'package:iot_task/backend/models/models.dart';
import 'package:iot_task/frontend/utils/utils.dart';
import 'package:iot_task/frontend/widgets/widgets.dart';

class LiveViewCameraScreen extends StatelessWidget {
  final RoomsModel? roomData;
  const LiveViewCameraScreen({Key? key, @required this.roomData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: CustomTextWidget(text: 'Live from ${roomData!.roomName}'),
      ),
    );
  }
}
