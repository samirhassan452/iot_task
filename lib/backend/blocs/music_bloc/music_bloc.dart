import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:iot_task/backend/blocs/blocs.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicBloc() : super(MusicInitial());

  @override
  Stream<MusicState> mapEventToState(MusicEvent event) async* {
    if (event is MusicOFFONRequested) {
      yield* _mapMusicOFFONRequestedToState(event);
    } else if (event is VolumeChangingValueRequested) {
      yield* _mapMusicChangingValueRequestedToState(event);
    }
  }

  Stream<MusicState> _mapMusicOFFONRequestedToState(
      MusicOFFONRequested event) async* {
    try {
      yield MusicTurningOFFON(
        roomId: event.roomId,
        roomType: event.roomType,
        turn: event.turn,
      );
    } catch (_) {
      yield MusicLoadFailure();
    }
  }

  Stream<MusicState> _mapMusicChangingValueRequestedToState(
      VolumeChangingValueRequested event) async* {
    try {
      yield VolumeValueChanging(newValue: event.newValue);
    } catch (_) {
      yield MusicLoadFailure();
    }
  }
}
