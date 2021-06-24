import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_task/backend/blocs/blocs.dart';
import 'package:iot_task/frontend/widgets/widgets.dart';

class BackHomeWidget extends StatefulWidget {
  const BackHomeWidget({Key? key}) : super(key: key);

  @override
  _BackHomeWidgetState createState() => _BackHomeWidgetState();
}

class _BackHomeWidgetState extends State<BackHomeWidget> {
  @override
  void didChangeDependencies() {
    final dataBloc = BlocProvider.of<DataBloc>(context);
    dataBloc.add(DataRequested());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataBloc, DataState>(
      listener: (context, state) {
        if (state is DataInternetConnectionFailure) {
          BlocProvider.of<DataBloc>(context).add(DataLocalRequested());
        }
      },
      builder: (context, state) {
        Widget? widget;
        if (state is DataInitial) {
          widget = Container();
        } else if (state is DataLoadInProgress) {
          widget = Center(child: CircularProgressIndicator());
        } else if (state is DataLoadFailure) {
          widget = Center(
            child: CustomTextWidget(
              text: "Error in retrieving data",
              textColor: Colors.red,
              textSize: 17.0,
            ),
          );
        } else if (state is DataInternetConnectionFailure) {
          widget = Container();
        } else if (state is DataLoadSuccess) {
          widget = ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: state.roomsWithWeatherData!.roomsData!.length,
            itemBuilder: (_, index) {
              final roomWeather =
                  state.roomsWithWeatherData!.roomsWeather!.firstWhere(
                (weather) =>
                    weather.roomId ==
                        state.roomsWithWeatherData!.roomsData![index].roomId &&
                    weather.roomType ==
                        state.roomsWithWeatherData!.roomsData![index].roomType,
              );

              // final roomsWeather = state.roomsWithWeatherData!
              //                 .roomsWeather![index].roomId ==
              //             state
              //                 .roomsWithWeatherData!.roomsData![index].roomId &&
              //         state.roomsWithWeatherData!.roomsWeather![index]
              //                 .roomType ==
              //             state.roomsWithWeatherData!.roomsData![index].roomType
              //     ? state.roomsWithWeatherData!.roomsWeather![index]
              //     : WeatherModel.fromJson(
              //         defaultConfiguration['WeatherOfRooms'][0],
              //       );

              return BlocBuilder<DevicesBloc, DevicesState>(
                builder: (context, deviceState) {
                  Widget? subWidget;
                  if (deviceState is DevicesInitial) {
                    subWidget = Container();
                  } else if (deviceState is DevicesDataLoadInProgress) {
                    subWidget = CircularProgressIndicator();
                  } else if (deviceState is DevicesDataLoadFailure) {
                    subWidget = Icon(Icons.error, color: Colors.red, size: 20);
                  } else if (deviceState is DevicesDataLoadSuccess) {
                    final roomDevices =
                        deviceState.listOfDevicesData!.firstWhere(
                      (roomDevice) =>
                          roomDevice.roomId ==
                              state.roomsWithWeatherData!.roomsData![index]
                                  .roomId &&
                          roomDevice.roomType ==
                              state.roomsWithWeatherData!.roomsData![index]
                                  .roomType,
                    );
                    subWidget = CustomListWidget(
                      roomData: state.roomsWithWeatherData!.roomsData![index],
                      roomWeather: roomWeather,
                      roomDevices: roomDevices,
                    );
                  } else {
                    subWidget = Container();
                  }
                  return subWidget;
                },
              );
            },
          );
        } else {
          widget = Container();
        }
        return widget;
      },
    );
  }
}
