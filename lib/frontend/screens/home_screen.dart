import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iot_task/backend/blocs/blocs.dart';
import 'package:iot_task/backend/configs/configs.dart';
import 'package:iot_task/frontend/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List? navBars;

  @override
  void initState() {
    navBars = defaultConfiguration["NavBars"].toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navBloc = BlocProvider.of<BottomNavBarBloc>(context);
    return Scaffold(
      body: BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
        builder: (context, state) {
          if (state is BottomNavBarInitial) {
            return Mapping.mapStringToWidget('rooms');
          } else if (state is BottomNavBarLoadSuccess) {
            return Mapping.mapStringToWidget(state.navBarKey!);
          } else {
            return SizedBox();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
        builder: (context, state) {
          int? navBarIndex = 0;
          String? navBarItem = 'Rooms';
          if (state is BottomNavBarInitial) {
            navBarIndex = 0;
            navBarItem = 'Rooms';
          } else if (state is BottomNavBarLoadSuccess) {
            navBarIndex = state.navBarIndex;
            navBarItem = state.navBarItem;
          }
          return BottomNavigationBar(
            backgroundColor: primaryColor,
            unselectedFontSize: 14.5,
            selectedFontSize: 14.5,
            selectedLabelStyle: TextStyle(
              foreground: Paint()..shader = linearGradient,
            ),
            unselectedLabelStyle: TextStyle(
              foreground: Paint()..color = Colors.grey.shade500,
            ),
            type: BottomNavigationBarType.fixed,
            currentIndex: navBarIndex!,
            onTap: (index) => navBloc.add(
              BottomNavBarRequested(navBarIndex: index),
            ),
            items: navBars!.map(
              (item) {
                return BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7),
                    child: LinearGradientMask(
                      isActive: navBarItem == item['label'],
                      child: SvgPicture.asset(
                        item['icon'],
                        width: 25,
                        height: 25,
                        color: navBarItem == item['label']
                            ? Colors.white
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                  label: item['label'],
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
