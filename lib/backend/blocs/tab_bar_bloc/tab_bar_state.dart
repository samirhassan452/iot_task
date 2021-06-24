import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class TabBarState extends Equatable {
  const TabBarState();

  @override
  List<Object> get props => [];
}

class TabBarInitial extends TabBarState {}

class TabBarLoadSuccess extends TabBarState {
  final String? tabBarKey;
  final String? tabBarItem;
  final int? tabBarIndex;

  TabBarLoadSuccess({
    @required this.tabBarItem,
    @required this.tabBarKey,
    @required this.tabBarIndex,
  })  : assert(tabBarItem != null),
        assert(tabBarKey != null),
        assert(tabBarIndex != null);

  @override
  List<Object> get props => [tabBarItem!, tabBarIndex!, tabBarKey!];
}
