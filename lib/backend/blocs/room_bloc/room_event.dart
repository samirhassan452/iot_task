import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => [];
}

class RoomRequested extends RoomEvent {
  final int? roomId;
  final int? roomType;

  RoomRequested({
    @required this.roomId,
    @required this.roomType,
  });

  @override
  List<Object> get props => [roomId!, roomType!];
}
