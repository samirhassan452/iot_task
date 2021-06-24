import 'package:flutter/foundation.dart';

class RoomsDevicesDataModel {
  final int? roomId;
  final int? roomType;
  final bool? lights;
  final int? lightsValue;
  final bool? airConditioner;
  final int? airConditionerValue;
  final bool? music;
  final int? musicValue;

  RoomsDevicesDataModel({
    @required this.roomId,
    @required this.roomType,
    @required this.lights,
    @required this.lightsValue,
    @required this.airConditioner,
    @required this.airConditionerValue,
    @required this.music,
    @required this.musicValue,
  });

  factory RoomsDevicesDataModel.fromJson(Map<String, dynamic> json) =>
      RoomsDevicesDataModel(
        roomId: int.tryParse(json['room_id']),
        roomType: int.tryParse(json['room_type']),
        lights: json['lights'],
        lightsValue: json['lights_value'],
        airConditioner: json['air_conditioner'],
        airConditionerValue: json['air_conditioner_value'],
        music: json['music'],
        musicValue: json['music_value'],
      );

  static Map<String, dynamic> toJson(RoomsDevicesDataModel roomsDevicesData) =>
      {
        'room_id': roomsDevicesData.roomId.toString(),
        'room_type': roomsDevicesData.roomType.toString(),
        'lights': roomsDevicesData.lights,
        'lights_value': roomsDevicesData.lightsValue,
        'air_conditioner': roomsDevicesData.airConditioner,
        'air_conditioner_value': roomsDevicesData.airConditionerValue,
        'music': roomsDevicesData.music,
        'music_value': roomsDevicesData.musicValue,
      };

  static List<dynamic> getDataFromListOfModel(
      List<RoomsDevicesDataModel> roomsDevicesData) {
    List listOfRoomsDevicesData = [];
    roomsDevicesData.forEach((roomDevices) {
      listOfRoomsDevicesData.add(
        RoomsDevicesDataModel.toJson(roomDevices),
      );
    });
    return listOfRoomsDevicesData;
  }

  static List<RoomsDevicesDataModel> getDataFromList(List<dynamic> json) {
    List<RoomsDevicesDataModel> listOfRoomsDevicesData = [];
    json.forEach((roomDevicesData) {
      listOfRoomsDevicesData
          .add(RoomsDevicesDataModel.fromJson(roomDevicesData));
    });
    return listOfRoomsDevicesData;
  }
}
