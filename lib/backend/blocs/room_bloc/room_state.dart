import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_task/backend/models/models.dart';

abstract class RoomState extends Equatable {
  const RoomState();

  @override
  List<Object> get props => [];
}

class RoomInitial extends RoomState {}

class RoomLoadFailure extends RoomState {}

class RoomLoadSuccess extends RoomState {
  final RoomsModel? roomsModel;

  RoomLoadSuccess({@required this.roomsModel});

  @override
  List<Object> get props => [roomsModel!];
}
