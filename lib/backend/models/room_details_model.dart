import 'package:flutter/foundation.dart';

class RoomDetailsModel {
  final String? nameRoom;
  final String? descripRoom;
  final String? imgRoom;
  final String? report;
  final String? switchFx;
  final int? controlId;
  final String? icon;
  final String? name;
  final String? urlLive;
  final String? urlLoc;
  final int? lane;

  RoomDetailsModel({
    @required this.nameRoom,
    @required this.descripRoom,
    @required this.imgRoom,
    @required this.report,
    @required this.switchFx,
    @required this.controlId,
    @required this.icon,
    @required this.name,
    @required this.urlLive,
    @required this.urlLoc,
    @required this.lane,
  });

  factory RoomDetailsModel.fromJson(Map<String, dynamic> json) =>
      RoomDetailsModel(
        nameRoom: json['name_room'],
        descripRoom: json['descrip_room'],
        imgRoom: json['img_room'],
        report: json['report'],
        switchFx: json['switch_fx'],
        controlId: int.tryParse(json['control_id']),
        icon: json['icon'],
        name: json['name'],
        urlLive: json['url_live'],
        urlLoc: json['url_loc'],
        lane: int.tryParse(json['lane']),
      );

  static List<RoomDetailsModel> getDataFromList(List<dynamic> json) {
    List<RoomDetailsModel> detailsOfRoom = [];
    json.forEach((roomDetails) {
      detailsOfRoom.add(RoomDetailsModel.fromJson(roomDetails));
    });
    return detailsOfRoom;
  }
}
