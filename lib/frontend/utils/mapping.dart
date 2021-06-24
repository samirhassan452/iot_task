import 'package:flutter/material.dart';
import 'package:iot_task/frontend/screens/screens.dart';
import 'package:iot_task/frontend/widgets/widgets.dart';

class Mapping {
  static Widget mapStringToWidget(String mapName) {
    switch (mapName) {
      // NavBars
      case 'rooms':
        return RoomsScreen(screenName: "Rooms");
      case 'schedule':
        return ScheduleScreen(screenName: "Schedule");
      case 'power':
        return PowerScreen(screenName: "Power");
      case 'more':
        return MoreScreen(screenName: "More");

      // TabBars
      case 'back_home':
        return BackHomeWidget();
      case 'home_away':
        return HomeAwayWidget();
      case 'guest_mode':
        return GuestModeWidget();

      default:
        return SizedBox();
    }
  }
}
