import 'package:flutter/foundation.dart';

class WeatherModel {
  final int? temprature;
  final int? humidity;
  final int? powerConsumption;
  final int? roomId;
  final int? roomType;

  WeatherModel({
    @required this.temprature,
    @required this.humidity,
    @required this.powerConsumption,
    @required this.roomId,
    @required this.roomType,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        temprature: json['temprature'],
        humidity: json['humidity'],
        powerConsumption: json['power_consumption'],
        roomId: json['room_id'],
        roomType: json['room_type'],
      );
  static List<WeatherModel> getDataFromList(List<dynamic> json) {
    List<WeatherModel> roomsWeather = [];
    json.forEach((weather) {
      roomsWeather.add(WeatherModel.fromJson(weather));
    });
    return roomsWeather;
  }
}
