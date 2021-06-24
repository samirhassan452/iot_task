import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:iot_task/backend/blocs/blocs.dart';
import 'package:iot_task/backend/models/rooms_with_weather_model.dart';
import 'package:iot_task/backend/services/services.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  final ApiService? apiService;
  DataBloc({@required this.apiService}) : super(DataInitial());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is DataRequested) {
      yield* _mapDataRequestedToState(event);
    } else if (event is DataRefreshRequested) {
      yield* _mapDataRefreshRequestedToState(event);
    } else if (event is DataLocalRequested) {
      yield* _mapDataLocalRequestedToState(event);
    }
  }

  Stream<DataState> _mapDataRequestedToState(DataRequested event) async* {
    yield DataLoadInProgress();
    try {
      final roomsData = await apiService!.fetchRoomsDataList();
      final roomsWeather = apiService!.fetchRoomsWeatherData();
      final RoomsWithWeatherModel roomsWithWeatherData = RoomsWithWeatherModel(
        roomsData: roomsData,
        roomsWeather: roomsWeather,
      );
      yield DataLoadSuccess(roomsWithWeatherData: roomsWithWeatherData);
    } on SocketException catch (_) {
      yield DataInternetConnectionFailure();
    } catch (_) {
      yield DataLoadFailure();
    }
  }

  Stream<DataState> _mapDataRefreshRequestedToState(
      DataRefreshRequested event) async* {
    try {
      final roomsData = apiService!.fetchRoomsDataLocally();
      final roomsWeather = apiService!.fetchRoomsWeatherData();
      final RoomsWithWeatherModel roomsWithWeatherData = RoomsWithWeatherModel(
        roomsData: roomsData,
        roomsWeather: roomsWeather,
      );
      yield DataLoadSuccess(roomsWithWeatherData: roomsWithWeatherData);
    } on SocketException catch (_) {
      yield DataInternetConnectionFailure();
    } catch (_) {
      yield DataLoadFailure();
    }
  }

  Stream<DataState> _mapDataLocalRequestedToState(
      DataLocalRequested event) async* {
    yield DataLoadInProgress();
    try {
      final roomsData = apiService!.fetchRoomsDataLocally();
      final roomsWeather = apiService!.fetchRoomsWeatherData();
      final RoomsWithWeatherModel roomsWithWeatherData = RoomsWithWeatherModel(
        roomsData: roomsData,
        roomsWeather: roomsWeather,
      );
      yield DataLoadSuccess(roomsWithWeatherData: roomsWithWeatherData);
    } catch (_) {
      yield DataLoadFailure();
    }
  }
}
