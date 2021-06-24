import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_task/backend/blocs/blocs.dart';
import 'package:iot_task/backend/services/services.dart';

class RoomDetailsBloc extends Bloc<RoomDetailsEvent, RoomDetailsState> {
  final ApiService? apiService;
  RoomDetailsBloc({@required this.apiService}) : super(RoomDetailsInitial());

  @override
  Stream<RoomDetailsState> mapEventToState(RoomDetailsEvent event) async* {
    if (event is RoomDetailsRequested) {
      yield* _mapRoomDetailsRequestedToState(event);
    } else if (event is RoomDetailsRefreshRequested) {
      yield* _mapRoomDetailsRefreshRequestedToState(event);
    }
  }

  Stream<RoomDetailsState> _mapRoomDetailsRequestedToState(
      RoomDetailsRequested event) async* {
    yield RoomDetailsLoadInProgress();
    try {
      final roomDetailsData = await apiService!.fetchRoomDetailsData(
        event.roomId,
        event.roomType,
      );
      yield RoomDetailsLoadSuccess(roomsDetailsModel: roomDetailsData);
    } on SocketException catch (_) {
      yield RoomDetailsInternetConnectionFailure();
    } catch (_) {
      yield RoomDetailsLoadFailure();
    }
  }

  Stream<RoomDetailsState> _mapRoomDetailsRefreshRequestedToState(
      RoomDetailsRefreshRequested event) async* {}
}
