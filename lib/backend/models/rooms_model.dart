import 'package:flutter/foundation.dart';

class RoomsModel {
  final int? roomId;
  final int? roomType;
  final String? report;
  final String? roomImg;
  final String? roomName;
  final String? roomDescrip;

  RoomsModel({
    @required this.roomId,
    @required this.roomType,
    @required this.report,
    @required this.roomImg,
    @required this.roomName,
    @required this.roomDescrip,
  });

  factory RoomsModel.fromJson(Map<String, dynamic> json) => RoomsModel(
        roomId: int.tryParse(json['room_id']),
        roomType: int.tryParse(json['room_type']),
        report: json['report'],
        roomImg: json['img'],
        roomName: json['name'],
        roomDescrip: json['descrip'],
      );
  static List<RoomsModel> getDataFromList(List<dynamic> json) {
    List<RoomsModel> listOfRooms = [];
    json.forEach((room) {
      listOfRooms.add(RoomsModel.fromJson(room));
    });
    return listOfRooms;
  }
}
