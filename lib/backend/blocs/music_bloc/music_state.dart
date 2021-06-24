import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class MusicState extends Equatable {
  const MusicState();

  @override
  List<Object> get props => [];
}

class MusicInitial extends MusicState {}

class MusicLoadFailure extends MusicState {}

class MusicTurningOFFON extends MusicState {
  final int? roomId;
  final int? roomType;
  final bool? turn;

  MusicTurningOFFON({
    @required this.roomId,
    @required this.roomType,
    @required this.turn,
  })  : assert(roomId != null),
        assert(roomType != null),
        assert(turn != null);

  @override
  List<Object> get props => [roomId!, roomType!, turn!];
}

class VolumeValueChanging extends MusicState {
  final double? newValue;

  VolumeValueChanging({
    @required this.newValue,
  }) : assert(newValue != null);

  @override
  List<Object> get props => [newValue!];
}
