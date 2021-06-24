import 'package:flutter/foundation.dart';
import 'package:iot_task/backend/models/models.dart';

class RoomsWithWeatherModel {
  final List<RoomsModel>? roomsData;
  final List<WeatherModel>? roomsWeather;

  RoomsWithWeatherModel({
    @required this.roomsData,
    @required this.roomsWeather,
  });
}
