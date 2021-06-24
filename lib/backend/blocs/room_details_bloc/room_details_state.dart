import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_task/backend/models/models.dart';

abstract class RoomDetailsState extends Equatable {
  const RoomDetailsState();

  @override
  List<Object> get props => [];
}

class RoomDetailsInitial extends RoomDetailsState {}

class RoomDetailsLoadInProgress extends RoomDetailsState {}

class RoomDetailsLoadFailure extends RoomDetailsState {}

class RoomDetailsInternetConnectionFailure extends RoomDetailsState {}

class RoomDetailsLoadSuccess extends RoomDetailsState {
  final List<RoomDetailsModel>? roomsDetailsModel;

  RoomDetailsLoadSuccess({@required this.roomsDetailsModel})
      : assert(roomsDetailsModel != null);

  @override
  List<Object> get props => [roomsDetailsModel!];
}
