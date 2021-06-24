import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class RoomDetailsEvent extends Equatable {
  const RoomDetailsEvent();

  @override
  List<Object> get props => [];
}

class RoomDetailsRequested extends RoomDetailsEvent {
  final int? roomId;
  final int? roomType;

  RoomDetailsRequested({
    @required this.roomId,
    @required this.roomType,
  });

  @override
  List<Object> get props => [roomId!, roomType!];
}

class RoomDetailsRefreshRequested extends RoomDetailsEvent {
  final int? roomId;
  final int? roomType;

  RoomDetailsRefreshRequested({
    @required this.roomId,
    @required this.roomType,
  });

  @override
  List<Object> get props => [roomId!, roomType!];
}
