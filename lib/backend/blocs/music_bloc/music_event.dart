import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class MusicEvent extends Equatable {
  const MusicEvent();

  @override
  List<Object> get props => [];
}

class MusicOFFONRequested extends MusicEvent {
  final int? roomId;
  final int? roomType;
  final bool? turn;

  MusicOFFONRequested({
    @required this.roomId,
    @required this.roomType,
    @required this.turn,
  })  : assert(roomId != null),
        assert(roomType != null),
        assert(turn != null);

  @override
  List<Object> get props => [roomId!, roomType!, turn!];
}

class VolumeChangingValueRequested extends MusicEvent {
  final double? newValue;

  VolumeChangingValueRequested({
    @required this.newValue,
  }) : assert(newValue != null);

  @override
  List<Object> get props => [newValue!];
}
