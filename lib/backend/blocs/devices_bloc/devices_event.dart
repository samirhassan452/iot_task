import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_task/backend/models/models.dart';

abstract class DevicesEvent extends Equatable {
  const DevicesEvent();

  @override
  List<Object> get props => [];
}

class DevicesRequested extends DevicesEvent {}

class ChangingLightsRequested extends DevicesEvent {
  final RoomsDevicesDataModel? roomDevice;

  ChangingLightsRequested({
    @required this.roomDevice,
  });

  @override
  List<Object> get props => [roomDevice!];
}

class ChangingMusicRequested extends DevicesEvent {
  final RoomsDevicesDataModel? roomDevice;

  ChangingMusicRequested({
    @required this.roomDevice,
  });

  @override
  List<Object> get props => [roomDevice!];
}

class ChangingAirConditionerRequested extends DevicesEvent {
  final RoomsDevicesDataModel? roomDevice;

  ChangingAirConditionerRequested({
    @required this.roomDevice,
  });

  @override
  List<Object> get props => [roomDevice!];
}
