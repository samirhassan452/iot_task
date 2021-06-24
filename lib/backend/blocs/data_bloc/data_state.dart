import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_task/backend/models/rooms_with_weather_model.dart';

abstract class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}

class DataLoadInProgress extends DataState {}

class DataLoadFailure extends DataState {}

class DataInternetConnectionFailure extends DataState {}

class DataLoadSuccess extends DataState {
  final RoomsWithWeatherModel? roomsWithWeatherData;

  DataLoadSuccess({@required this.roomsWithWeatherData})
      : assert(roomsWithWeatherData != null);

  @override
  List<Object> get props => [roomsWithWeatherData!];
}
