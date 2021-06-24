import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_task/backend/blocs/blocs.dart';
import 'package:iot_task/backend/models/models.dart';
import 'package:iot_task/backend/services/services.dart';
import 'package:iot_task/frontend/utils/utils.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  final ApiService? apiService;
  DevicesBloc({@required this.apiService}) : super(DevicesInitial());

  @override
  Stream<DevicesState> mapEventToState(DevicesEvent event) async* {
    if (event is DevicesRequested) {
      yield* _mapDevicesRequestedToState(event);
    } else if (event is ChangingLightsRequested) {
      yield* _mapChangingLightsRequestedToState(event);
    } else if (event is ChangingMusicRequested) {
      yield* _mapChangingMusicRequestedToState(event);
    } else if (event is ChangingAirConditionerRequested) {
      yield* _mapChangingAirConditionerRequestedToState(event);
    }
  }

  Stream<DevicesState> _mapDevicesRequestedToState(
      DevicesRequested event) async* {
    yield DevicesDataLoadInProgress();
    try {
      bool isFounded = await apiService!.checkLocalKey('rooms_devices');
      if (!isFounded) {
        apiService!.setRoomDevicesDataLocal(createListOfRoomsDevicesData());
      }
      List<RoomsDevicesDataModel>? listOfDevicesData =
          await apiService!.getRoomDevicesDataLocal();
      yield DevicesDataLoadSuccess(
        listOfDevicesData: listOfDevicesData,
      );
    } catch (_) {
      yield DevicesDataLoadFailure();
    }
  }

  Stream<DevicesState> _mapChangingLightsRequestedToState(
      ChangingLightsRequested event) async* {
    yield DevicesDataLoadInProgress();
    try {
      final devicesData =
          await apiService!.updateRoomDevicesDataLocal(event.roomDevice);
      yield DevicesDataLoadSuccess(listOfDevicesData: devicesData);
    } catch (_) {
      yield DevicesDataLoadFailure();
    }
  }

  Stream<DevicesState> _mapChangingMusicRequestedToState(
      ChangingMusicRequested event) async* {
    yield DevicesDataLoadInProgress();
    try {
      final devicesData =
          await apiService!.updateRoomDevicesDataLocal(event.roomDevice);
      yield DevicesDataLoadSuccess(listOfDevicesData: devicesData);
    } catch (_) {
      yield DevicesDataLoadFailure();
    }
  }

  Stream<DevicesState> _mapChangingAirConditionerRequestedToState(
      ChangingAirConditionerRequested event) async* {
    yield DevicesDataLoadInProgress();
    try {
      final devicesData =
          await apiService!.updateRoomDevicesDataLocal(event.roomDevice);
      yield DevicesDataLoadSuccess(listOfDevicesData: devicesData);
    } catch (_) {
      yield DevicesDataLoadFailure();
    }
  }
}
