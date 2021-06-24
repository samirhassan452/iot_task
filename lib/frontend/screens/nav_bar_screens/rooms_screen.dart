import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_task/backend/blocs/blocs.dart';
import 'package:iot_task/backend/configs/configs.dart';
import 'package:iot_task/frontend/utils/utils.dart';
import 'package:iot_task/frontend/widgets/widgets.dart';

class RoomsScreen extends StatefulWidget {
  final String? screenName;
  const RoomsScreen({Key? key, @required this.screenName}) : super(key: key);

  @override
  _RoomsScreenState createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  List? tabBars;

  @override
  void initState() {
    tabBars = defaultConfiguration["TabBars"].toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tabBloc = BlocProvider.of<TabBarBloc>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                _buildHeader(),
                _buildTabBars(tabBloc),
              ],
            ),
            Expanded(
              child: buildTabBarsBody(),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildTabBarsBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: BlocBuilder<TabBarBloc, TabBarState>(
        builder: (context, state) {
          if (state is TabBarInitial) {
            return Mapping.mapStringToWidget('back_home');
          } else if (state is TabBarLoadSuccess) {
            return Mapping.mapStringToWidget(state.tabBarKey!);
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Padding _buildTabBars(TabBarBloc tabBloc) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        defaultPadding,
        defaultPadding,
        0.0,
        defaultPadding,
      ),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: tabBars!.length,
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.only(right: defaultPadding),
            child: GestureDetector(
              onTap: () => tabBloc.add(
                TabBarRequested(tabBarIndex: index),
              ),
              child: BlocBuilder<TabBarBloc, TabBarState>(
                builder: (context, state) {
                  int? tabBarIndex = 0;
                  if (state is TabBarInitial) {
                    tabBarIndex = 0;
                  } else if (state is TabBarLoadSuccess) {
                    tabBarIndex = state.tabBarIndex;
                  }
                  return CustomTabWidget(
                    text: tabBars![index]['label'],
                    icon: tabBars![index]['icon'],
                    isActive: tabBarIndex == index,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Center(
        child: CustomTextWidget(
          text: widget.screenName,
          textSize: 25,
        ),
      ),
    );
  }
}
