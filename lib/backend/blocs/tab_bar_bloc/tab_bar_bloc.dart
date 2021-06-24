import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:iot_task/backend/blocs/blocs.dart';

class TabBarBloc extends Bloc<TabBarEvent, TabBarState> {
  final List? tabBarItems;
  TabBarBloc({@required this.tabBarItems})
      : assert(tabBarItems != null),
        super(TabBarInitial());

  @override
  Stream<TabBarState> mapEventToState(TabBarEvent event) async* {
    if (event is TabBarRequested) {
      var tab = tabBarItems?[event.tabBarIndex!];
      yield TabBarLoadSuccess(
        tabBarIndex: event.tabBarIndex,
        tabBarKey: tab['name'],
        tabBarItem: tab['label'],
      );
    }
  }
}
