import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class TabBarEvent extends Equatable {
  const TabBarEvent();

  @override
  List<Object> get props => [];
}

class TabBarRequested extends TabBarEvent {
  final int? tabBarIndex;

  TabBarRequested({@required this.tabBarIndex}) : assert(tabBarIndex != null);

  @override
  List<Object> get props => [tabBarIndex!];
}
