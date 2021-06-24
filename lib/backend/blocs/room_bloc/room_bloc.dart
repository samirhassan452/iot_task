import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:iot_task/backend/blocs/blocs.dart';
import 'package:iot_task/backend/configs/configs.dart';
import 'package:iot_task/backend/models/models.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(RoomInitial());

  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    if (event is RoomRequested) {
      try {
        List<RoomsModel>? roomsModel = RoomsModel.getDataFromList(
          defaultConfiguration['ListOfRooms'],
        );
        RoomsModel? roomModel;
        roomsModel.forEach((room) {
          if (room.roomId == event.roomId && room.roomType == event.roomType) {
            roomModel = room;
          }
        });
        yield RoomLoadSuccess(roomsModel: roomModel);
      } catch (_) {
        yield RoomLoadFailure();
      }
    }
  }
}
