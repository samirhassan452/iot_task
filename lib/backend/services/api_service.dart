import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:iot_task/backend/configs/configs.dart';
import 'package:iot_task/backend/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String urlList =
      "https://www.vartola.net/server/home_phone/task/getroomslist.php?fx_id=1&sk=sk_5fe73fe704b8e";
  static const String urlRoomDetails =
      "https://www.vartola.net/server/home_phone/task/get_room_devices.php?fx_id=1&sk=sk_5fe73fe704b8e&";
  final http.Client? httpClient;

  ApiService({@required this.httpClient});

  Future<List<RoomsModel>> fetchRoomsDataList() async {
    final http.Response dataResponse = await this.httpClient!.get(
          _resolveStringToUri(urlList),
        );
    if (dataResponse.statusCode != 200) {
      throw Exception('error getting data from this url: $urlList');
    }

    final dataJson = jsonDecode(dataResponse.body) as List;
    return RoomsModel.getDataFromList(dataJson);
  }

  List<RoomsModel> fetchRoomsDataLocally() {
    final data = defaultConfiguration["ListOfRooms"] as List;
    return RoomsModel.getDataFromList(data);
  }

  List<WeatherModel> fetchRoomsWeatherData() {
    final weather = defaultConfiguration["WeatherOfRooms"] as List;
    return WeatherModel.getDataFromList(weather);
  }

  Future<List<RoomDetailsModel>> fetchRoomDetailsData(
      int? roomId, int? roomType) async {
    String url =
        urlRoomDetails + "room_id=$roomId" + "&" + "room_type=$roomType";
    print(url);
    final http.Response dataResponse = await this.httpClient!.get(
          _resolveStringToUri(url),
        );
    if (dataResponse.statusCode != 200) {
      throw Exception('error getting data from this url: $url');
    }

    final dataJson = jsonDecode(dataResponse.body) as List;
    print(dataJson);
    return RoomDetailsModel.getDataFromList(dataJson);
  }

  Future<void> setRoomDevicesDataLocal(List<dynamic> listOfRoomsData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final dataJson = json.encode(listOfRoomsData);

    prefs.setString('rooms_devices', dataJson);
  }

  Future<List<RoomsDevicesDataModel>> getRoomDevicesDataLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('rooms_devices');
    final dataJson = json.decode(data!) as List<dynamic>;
    return RoomsDevicesDataModel.getDataFromList(dataJson);
  }

  Future<List<RoomsDevicesDataModel>> updateRoomDevicesDataLocal(
      RoomsDevicesDataModel? roomsData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<RoomsDevicesDataModel> listOfRoomsDevicesData =
        await getRoomDevicesDataLocal();
    bool? isRemoved = await prefs.remove('rooms_devices');
    listOfRoomsDevicesData.removeWhere(
      (roomData) =>
          roomData.roomId == roomsData!.roomId &&
          roomData.roomType == roomsData.roomType,
    );
    listOfRoomsDevicesData.add(roomsData!);
    if (isRemoved) {
      setRoomDevicesDataLocal(
        RoomsDevicesDataModel.getDataFromListOfModel(listOfRoomsDevicesData),
      );
    }
    return listOfRoomsDevicesData;
  }

  Future<bool> checkLocalKey(String? key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key!);
  }

  Uri _resolveStringToUri(String uri) => Uri.parse(uri);
}
