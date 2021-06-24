import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_task/backend/models/models.dart';

abstract class DevicesState extends Equatable {
  const DevicesState();

  @override
  List<Object> get props => [];
}

class DevicesInitial extends DevicesState {}

class DevicesDataLoadInProgress extends DevicesState {}

class DevicesDataLoadFailure extends DevicesState {}

class DevicesDataLoadSuccess extends DevicesState {
  final List<RoomsDevicesDataModel>? listOfDevicesData;

  DevicesDataLoadSuccess({@required this.listOfDevicesData});

  @override
  List<Object> get props => [listOfDevicesData!];
}

class DevicesLightsLoadSuccess extends DevicesState {
  final RoomsDevicesDataModel? devicesData;

  DevicesLightsLoadSuccess({@required this.devicesData});

  @override
  List<Object> get props => [devicesData!];
}

class DevicesMusicLoadSuccess extends DevicesState {
  final RoomsDevicesDataModel? devicesData;

  DevicesMusicLoadSuccess({@required this.devicesData});

  @override
  List<Object> get props => [devicesData!];
}

class DevicesAirConditionerLoadSuccess extends DevicesState {
  final RoomsDevicesDataModel? devicesData;

  DevicesAirConditionerLoadSuccess({@required this.devicesData});

  @override
  List<Object> get props => [devicesData!];
}
