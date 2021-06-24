import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class BottomNavBarEvent extends Equatable {
  const BottomNavBarEvent();

  @override
  List<Object> get props => [];
}

class BottomNavBarRequested extends BottomNavBarEvent {
  final int? navBarIndex;

  BottomNavBarRequested({@required this.navBarIndex})
      : assert(navBarIndex != null);

  @override
  List<Object> get props => [navBarIndex!];
}
