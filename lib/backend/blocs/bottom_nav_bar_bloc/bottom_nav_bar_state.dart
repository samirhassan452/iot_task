import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class BottomNavBarState extends Equatable {
  const BottomNavBarState();

  @override
  List<Object> get props => [];
}

class BottomNavBarInitial extends BottomNavBarState {}

class BottomNavBarLoadSuccess extends BottomNavBarState {
  final String? navBarKey;
  final String? navBarItem;
  final int? navBarIndex;

  BottomNavBarLoadSuccess({
    @required this.navBarItem,
    @required this.navBarKey,
    @required this.navBarIndex,
  })  : assert(navBarItem != null),
        assert(navBarKey != null),
        assert(navBarIndex != null);

  @override
  List<Object> get props => [navBarItem!, navBarIndex!, navBarKey!];
}
