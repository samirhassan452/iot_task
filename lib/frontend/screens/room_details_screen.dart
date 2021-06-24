import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_task/backend/blocs/blocs.dart';
import 'package:iot_task/backend/configs/config.dart';
import 'package:iot_task/backend/models/models.dart';
import 'package:iot_task/frontend/utils/utils.dart';
import 'package:iot_task/frontend/widgets/widgets.dart';

class RoomDetailsScreen extends StatefulWidget {
  final Map<String, dynamic>? screenData;
  const RoomDetailsScreen({Key? key, @required this.screenData})
      : super(key: key);

  @override
  _RoomDetailsScreenState createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  late PageController pageController;
  late PageController subPageController;
  int currentIndex = 0;
  late List<RoomsModel> roomsData;
  late List<WeatherModel> weathersData;
  int? roomId;
  int? roomType;
  RoomsDevicesDataModel? roomDevices;

  @override
  void initState() {
    int currentIndex = 0;
    roomId = widget.screenData!['room_id'];
    roomType = widget.screenData!['room_type'];
    roomDevices = widget.screenData!['room_devices'];
    roomsData = RoomsModel.getDataFromList(defaultConfiguration["ListOfRooms"]);
    weathersData =
        WeatherModel.getDataFromList(defaultConfiguration["WeatherOfRooms"]);
    for (int i = 0; i < roomsData.length; i++) {
      if (roomsData[i].roomId == roomId && roomsData[i].roomType == roomType) {
        currentIndex = i;
      }
    }
    pageController = PageController(
      viewportFraction: 0.5,
      keepPage: true,
      initialPage: currentIndex,
    );
    subPageController = PageController(
      viewportFraction: 0.3,
      keepPage: true,
      initialPage: roomDevices!.airConditionerValue!,
    );
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    subPageController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<RoomBloc>(context).add(
      RoomRequested(roomId: roomId, roomType: roomType),
    );
    BlocProvider.of<RoomDetailsBloc>(context).add(
      RoomDetailsRequested(roomId: roomId, roomType: roomType),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          BlocBuilder<RoomBloc, RoomState>(
            builder: (context, state) {
              RoomsModel? roomData;
              WeatherModel? weatherData;
              if (state is RoomInitial) {
                roomsData.forEach((room) {
                  if (room.roomId == roomId && room.roomType == roomType) {
                    roomData = room;
                  }
                });
              } else if (state is RoomLoadSuccess) {
                roomData = state.roomsModel;
              }
              roomId = roomData!.roomId;
              roomType = roomData!.roomType;
              weathersData.forEach((weather) {
                if (weather.roomId == roomData!.roomId &&
                    weather.roomType == roomData!.roomType) {
                  weatherData = weather;
                }
              });
              return Container(
                height: 230,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.dstATop),
                    image: AssetImage("assets/${roomData!.roomImg!}"),
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBackArrow(context),
                      SizedBox(
                        height: 30,
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          controller: pageController,
                          itemCount: roomsData.length,
                          onPageChanged: (index) {
                            BlocProvider.of<RoomBloc>(context).add(
                              RoomRequested(
                                roomId: roomsData[index].roomId,
                                roomType: roomsData[index].roomType,
                              ),
                            );
                            BlocProvider.of<RoomDetailsBloc>(context).add(
                              RoomDetailsRequested(
                                roomId: roomsData[index].roomId,
                                roomType: roomsData[index].roomType,
                              ),
                            );
                          },
                          itemBuilder: (_, index) {
                            if (roomData!.roomId == roomsData[index].roomId &&
                                roomData!.roomType ==
                                    roomsData[index].roomType) {
                              return CustomTextWidget(
                                  text: capitalizeFirstLetter(
                                      roomData!.roomName));
                            } else {
                              return CustomTextWidget(
                                text: capitalizeFirstLetter(
                                    roomsData[index].roomName),
                                textColor: Colors.grey.shade600,
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding * 2,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildCustomWeatherData(
                                  word: 'Temprature',
                                  degree:
                                      '${weatherData!.temprature.toString().padLeft(2, "0")} °C'),
                              _buildCustomWeatherData(
                                  word: 'Humidity',
                                  degree:
                                      '${weatherData!.humidity.toString().padLeft(2, "0")} °C'),
                              _buildCustomWeatherData(
                                word: 'Power Consumption',
                                degree:
                                    '${weatherData!.powerConsumption.toString().padLeft(2, "0")}',
                                isDegree: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<RoomDetailsBloc, RoomDetailsState>(
              builder: (context, state) {
                Widget? widget;
                if (state is RoomDetailsInitial) {
                  widget = Container();
                } else if (state is RoomDetailsLoadFailure) {
                  widget = Center(
                    child: CustomTextWidget(
                      text: "Error in retrieving data",
                      textColor: Colors.red,
                      textSize: 17.0,
                    ),
                  );
                } else if (state is RoomDetailsLoadInProgress) {
                  widget = Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  );
                } else if (state is RoomDetailsInternetConnectionFailure) {
                  widget = Center(
                    child: CustomTextWidget(
                      text: "Check your internet connection",
                      textColor: Colors.red,
                      textSize: 17.0,
                    ),
                  );
                } else if (state is RoomDetailsLoadSuccess) {
                  widget = SingleChildScrollView(
                    child: BlocBuilder<DevicesBloc, DevicesState>(
                      builder: (context, deviceState) {
                        Widget? subWidget;
                        if (deviceState is DevicesInitial) {
                          subWidget = Container();
                        } else if (deviceState is DevicesDataLoadInProgress) {
                          subWidget = CircularProgressIndicator();
                        } else if (deviceState is DevicesDataLoadFailure) {
                          subWidget =
                              Icon(Icons.error, color: Colors.red, size: 20);
                        } else if (deviceState is DevicesDataLoadSuccess) {
                          final roomDevices =
                              deviceState.listOfDevicesData!.firstWhere(
                            (roomDevice) =>
                                roomDevice.roomId == roomId &&
                                roomDevice.roomType == roomType,
                          );
                          subWidget = Column(
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.of(context).pushNamed(
                                  RouteNames.liveViewCamera,
                                  arguments: roomsData.firstWhere(
                                    (room) =>
                                        room.roomId == roomId &&
                                        room.roomType == roomType,
                                  ),
                                ),
                                child:
                                    CustomRoomDetailsCardWidget(isCamera: true),
                              ),
                              Column(
                                children: state.roomsDetailsModel!
                                    .map(
                                      (roomDetails) =>
                                          CustomRoomDetailsCardWidget(
                                        roomDetailsModel: roomDetails,
                                        roomDevices: roomDevices,
                                        pageController: subPageController,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ],
                          );
                        } else {
                          subWidget = Container();
                        }
                        return subWidget;
                      },
                    ),
                  );
                }
                return widget!;
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildBackArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: defaultPadding,
        horizontal: defaultPadding,
      ),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Column _buildCustomWeatherData({
    String? word,
    String? degree,
    bool isDegree = true,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextWidget(
          text: word,
          textSize: 12.5,
          fontWeight: FontWeight.w400,
        ),
        isDegree
            ? CustomTextWidget(
                text: degree,
                textSize: 25,
              )
            : SizedBox(
                width: 65,
                child: Stack(
                  children: [
                    CustomTextWidget(
                      text: degree,
                      textSize: 25,
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: CustomTextWidget(
                        text: 'kWh',
                        textSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}

// widget.weatherModel!.temprature.toString()

/*
BlocBuilder<LightsBloc, LightsState>(
                        builder: (context, state) {
                          bool turn = false;
                          double newValue = 0.0;
                          if (state is LightsInitial) {
                            turn = false;
                          } else if (state is LightsTurningOFFON) {
                            if (roomId == state.roomId &&
                                roomType == state.roomType) {
                              turn = state.turn!;
                            }
                          } else if (state is LightsValueChanging) {
                            if (roomId == state.roomId &&
                                roomType == state.roomType) {
                              newValue = state.newValue!;
                              if (state.newValue == 0)
                                turn = false;
                              else
                                turn = true;
                            }
                          }

                          if (newValue == 0.0 && turn) {
                            newValue = 50.0;
                          } else if (newValue == 50.0 && !turn) {
                            newValue = 0.0;
                          }
                          return _buildRoomDetailsCard(
                            leading: 'assets/icons/lights.svg',
                            title: 'Lightings',
                            trailing: Switch(
                              value: turn,
                              onChanged: (newVal) {
                                lightsBloc.add(
                                  LightsOFFONRequested(
                                    roomId: roomId,
                                    roomType: roomType,
                                    turn: newVal,
                                  ),
                                );
                              },
                            ),
                            body: Slider(
                              min: 0,
                              max: 50,
                              value: newValue,
                              divisions: 2,
                              onChanged: (newVal) {
                                lightsBloc.add(
                                  LightsChangingValueRequested(
                                    roomId: roomId,
                                    roomType: roomType,
                                    newValue: newVal,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                      _buildRoomDetailsCard(
                        leading: 'assets/icons/air_condition.svg',
                        title: 'Air Conditioner',
                        trailing: Switch(
                          value: true,
                          onChanged: (newVal) {},
                        ),
                      ),
                      
                      _buildRoomDetailsCard(
                        leading: 'assets/icons/music.svg',
                        title: 'Music Player',
                      ),
*/