import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_task/backend/blocs/blocs.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  final List? navBarItems;
  BottomNavBarBloc({@required this.navBarItems})
      : assert(navBarItems != null),
        super(BottomNavBarInitial());

  @override
  Stream<BottomNavBarState> mapEventToState(BottomNavBarEvent event) async* {
    if (event is BottomNavBarRequested) {
      var tab = navBarItems?[event.navBarIndex!];
      yield BottomNavBarLoadSuccess(
        navBarIndex: event.navBarIndex,
        navBarKey: tab['name'],
        navBarItem: tab['label'],
      );
    }
  }
}
