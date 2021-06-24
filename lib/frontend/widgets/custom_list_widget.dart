import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_task/backend/blocs/blocs.dart';
import 'package:iot_task/backend/models/models.dart';
import 'package:iot_task/frontend/utils/utils.dart';
import 'package:iot_task/frontend/widgets/widgets.dart';

class CustomListWidget extends StatelessWidget {
  final RoomsModel? roomData;
  final WeatherModel? roomWeather;
  final RoomsDevicesDataModel? roomDevices;

  CustomListWidget({
    Key? key,
    @required this.roomData,
    @required this.roomWeather,
    @required this.roomDevices,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final img = 'assets/${roomData!.roomImg}';
    final name = capitalizeFirstLetter(roomData!.roomName);
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RouteNames.roomDetails,
        arguments: {
          'room_id': roomData!.roomId,
          'room_type': roomData!.roomType,
          'room_devices': roomDevices,
        },
      ),
      child: Container(
        height: 160,
        margin: EdgeInsets.symmetric(vertical: defaultPadding - 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: new ColorFilter.mode(
                Colors.black.withOpacity(0.3), BlendMode.dstATop),
            image: AssetImage(img),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding * 1.5,
            vertical: defaultPadding * 2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextWidget(
                text: name,
                textSize: 26,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextWidget(
                    text: roomWeather!.temprature!.toString() + ' °C',
                    textSize: 27,
                    fontWeight: FontWeight.w400,
                  ),
                  Row(
                    children: [
                      CustomCircular(
                        icon: 'assets/icons/video_camera.svg',
                        onTap: () {},
                      ),
                      CustomCircular(
                        icon: 'assets/icons/air_condition.svg',
                        onTap: () {
                          final roomDevice = RoomsDevicesDataModel(
                            roomId: roomDevices!.roomId,
                            roomType: roomDevices!.roomType,
                            lights: roomDevices!.lights,
                            lightsValue: roomDevices!.lightsValue,
                            airConditioner: !(roomDevices!.airConditioner!),
                            airConditionerValue:
                                roomDevices!.airConditionerValue,
                            music: roomDevices!.music,
                            musicValue: roomDevices!.musicValue,
                          );
                          BlocProvider.of<DevicesBloc>(context).add(
                            ChangingMusicRequested(roomDevice: roomDevice),
                          );
                        },
                        state: roomDevices!.airConditioner,
                      ),
                      CustomCircular(
                        icon: 'assets/icons/music.svg',
                        onTap: () {
                          final roomDevice = RoomsDevicesDataModel(
                            roomId: roomDevices!.roomId,
                            roomType: roomDevices!.roomType,
                            lights: roomDevices!.lights,
                            lightsValue: roomDevices!.lightsValue,
                            airConditioner: roomDevices!.airConditioner,
                            airConditionerValue:
                                roomDevices!.airConditionerValue,
                            music: !(roomDevices!.music!),
                            musicValue: roomDevices!.musicValue,
                          );
                          BlocProvider.of<DevicesBloc>(context).add(
                            ChangingMusicRequested(roomDevice: roomDevice),
                          );
                        },
                        state: roomDevices!.music,
                      ),
                      CustomCircular(
                        icon: 'assets/icons/lights.svg',
                        onTap: () {
                          print("Old Lights: ${(roomDevices!.lights!)}");
                          print("New Lights: ${!(roomDevices!.lights!)}");
                          final roomDevice = RoomsDevicesDataModel(
                            roomId: roomDevices!.roomId,
                            roomType: roomDevices!.roomType,
                            lights: !(roomDevices!.lights!),
                            lightsValue: roomDevices!.lightsValue,
                            airConditioner: roomDevices!.airConditioner,
                            airConditionerValue:
                                roomDevices!.airConditionerValue,
                            music: roomDevices!.music,
                            musicValue: roomDevices!.musicValue,
                          );
                          BlocProvider.of<DevicesBloc>(context).add(
                            ChangingMusicRequested(roomDevice: roomDevice),
                          );
                        },
                        state: roomDevices!.lights,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
