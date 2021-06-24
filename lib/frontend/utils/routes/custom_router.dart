import 'package:flutter/material.dart';
import 'package:iot_task/backend/models/models.dart';
import 'package:iot_task/frontend/screens/screens.dart';
import 'package:iot_task/frontend/utils/utils.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RouteNames.roomDetails:
        return MaterialPageRoute(
          builder: (_) {
            return RoomDetailsScreen(
              screenData: settings.arguments as Map<String, dynamic>,
            );
          },
        );
      case RouteNames.liveViewCamera:
        return MaterialPageRoute(
          builder: (_) {
            return LiveViewCameraScreen(
              roomData: settings.arguments as RoomsModel,
            );
          },
        );
    }
    return MaterialPageRoute(builder: (_) => NotFoundScreen());
  }
}
