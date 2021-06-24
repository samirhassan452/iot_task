import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_task/backend/blocs/blocs.dart';
import 'package:iot_task/backend/models/models.dart';
import 'package:iot_task/frontend/utils/utils.dart';
import 'package:iot_task/frontend/widgets/widgets.dart';

class CustomRoomDetailsCardWidget extends StatelessWidget {
  final RoomDetailsModel? roomDetailsModel;
  final bool? isCamera;
  final RoomsDevicesDataModel? roomDevices;
  final PageController? pageController;
  const CustomRoomDetailsCardWidget({
    Key? key,
    this.roomDetailsModel,
    this.roomDevices,
    this.isCamera = false,
    this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(
        defaultPadding - 2,
        defaultPadding - 2,
        defaultPadding - 2,
        defaultPadding / 2,
      ),
      color: Colors.grey.shade800,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding * 1.5,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCircular(
              icon: _checkCardIcon(
                  isCamera! ? 'live-view' : roomDetailsModel!.icon!),
              onTap: () {},
              state: _changeIconColor(
                isCamera! ? 'live-view' : roomDetailsModel!.icon!,
              ),
            ),
            SizedBox(width: defaultPadding),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(
                        text: _checkCardTitle(
                          isCamera! ? 'live-view' : roomDetailsModel!.icon!,
                        ),
                        textSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      _checkCardTrealing(
                        isCamera! ? '' : roomDetailsModel!.switchFx!,
                        isCamera! ? '' : roomDetailsModel!.icon!,
                        context,
                      ),
                    ],
                  ),
                  _checkCardBody(
                    isCamera! ? '' : roomDetailsModel!.switchFx!,
                    isCamera! ? '' : roomDetailsModel!.icon!,
                    context,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _checkCardIcon(String icon) {
    switch (icon) {
      case 'contrast-outline':
        return 'assets/icons/lights.svg';
      case 'sunny':
        return 'assets/icons/lights.svg';
      case 'snow-outline':
        return 'assets/icons/air_condition.svg';
      case 'live-view':
        return 'assets/icons/video_camera.svg';
      default:
        return 'assets/icons/lights.svg';
    }
  }

  String _checkCardTitle(String title) {
    switch (title) {
      case 'contrast-outline':
        return 'Lightings';
      case 'sunny':
        return 'Music Player';
      case 'snow-outline':
        return 'Air Conditioner';
      case 'live-view':
        return 'Live Camera View';
      default:
        return 'Lights';
    }
  }

  Widget _checkCardTrealing(String type, String title, BuildContext context) {
    switch (type) {
      case 'switch':
        return CupertinoSwitch(
          activeColor: backgroundColor,
          trackColor: backgroundColor,
          value: _checkDeviceState(title),
          onChanged: (newVal) {
            _changeDeviceState(title, newVal, context);
          },
        );
      case 'switch_and_slider':
        return CupertinoSwitch(
          activeColor: backgroundColor,
          trackColor: backgroundColor,
          value: _checkDeviceState(title),
          onChanged: (newVal) {
            _changeDeviceState(title, newVal, context);
          },
        );
      default:
        return Container();
    }
  }

  Widget _checkCardBody(String type, String title, BuildContext context) {
    switch (type) {
      case 'slider':
        return Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/img/user-icon.png'),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextWidget(
                            text: 'Uptown Funk',
                            fontWeight: FontWeight.w500,
                            textSize: 18,
                          ),
                          SizedBox(height: 5),
                          CustomTextWidget(
                            text: 'ft. Bruno Mars',
                            textColor: Colors.grey.shade500,
                            fontWeight: FontWeight.w400,
                            textSize: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      children: [
                        RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.fast_forward,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
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
                          child: Icon(
                            roomDevices!.music!
                                ? Icons.pause_circle_outline_sharp
                                : Icons.play_circle_outline_sharp,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                        Icon(
                          Icons.fast_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.volume_off, color: Colors.white),
                  SizedBox(width: 10),
                  BlocBuilder<MusicBloc, MusicState>(
                    builder: (context, state) {
                      Widget? subWidget;
                      print("State is: $state");
                      if (state is MusicInitial) {
                        subWidget = CupertinoSlider(
                          activeColor: backgroundColor,
                          min: 0,
                          max: 100,
                          divisions: 10,
                          value: roomDevices!.musicValue!.toDouble(),
                          onChanged: (newVal) {
                            BlocProvider.of<MusicBloc>(context).add(
                              VolumeChangingValueRequested(newValue: newVal),
                            );
                          },
                          onChangeEnd: (val) {
                            _changeDeviceValue(
                              val.toInt(),
                              title,
                              context,
                            );
                          },
                        );
                      } else if (state is VolumeValueChanging) {
                        subWidget = CupertinoSlider(
                          activeColor: backgroundColor,
                          min: 0,
                          max: 100,
                          divisions: 10,
                          value: state.newValue!,
                          onChanged: (newVal) {
                            BlocProvider.of<MusicBloc>(context).add(
                              VolumeChangingValueRequested(newValue: newVal),
                            );
                          },
                          onChangeEnd: (val) {
                            _changeDeviceValue(
                              val.toInt(),
                              title,
                              context,
                            );
                          },
                        );
                      } else {
                        subWidget = Container();
                      }
                      return subWidget;
                    },
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.volume_up, color: Colors.white),
                ],
              ),
            ],
          ),
        );
      case 'switch_and_slider':
        return Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            height: 30,
            width: 190,
            child: PageView.builder(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemCount: 31,
              onPageChanged: (index) {
                // _changeDeviceValue(index, title, context);
                pageController!.animateToPage(
                  index,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.linear,
                );
                Future.delayed(
                  Duration(seconds: 1),
                ).then((_) => _changeDeviceValue(index, title, context));
              },
              itemBuilder: (_, index) {
                return Row(
                  children: [
                    CustomTextWidget(
                      text: index.toString(),
                      textSize:
                          index == roomDevices!.airConditionerValue ? 22 : 18,
                      textColor: index == roomDevices!.airConditionerValue
                          ? Colors.white
                          : Colors.grey.shade600,
                    ),
                    if (index != 30)
                      CustomTextWidget(
                        text: ' ||||',
                        textColor: index == roomDevices!.airConditionerValue
                            ? Colors.yellow[900]
                            : index == roomDevices!.airConditionerValue! - 1
                                ? Colors.yellow[900]
                                : Colors.yellow.withOpacity(0.3),
                      ),
                  ],
                );
              },
            ),
          ),
        );
      default:
        return Container();
    }
  }

  bool _checkDeviceState(String title) {
    bool value;
    switch (title) {
      case 'contrast-outline':
        value = roomDevices!.lights!;
        break;
      case 'sunny':
        value = roomDevices!.music!;
        break;
      case 'snow-outline':
        value = roomDevices!.airConditioner!;
        break;
      default:
        value = false;
        break;
    }
    return value;
  }

  void _changeDeviceState(String title, bool val, BuildContext context) {
    switch (title) {
      case 'contrast-outline':
        final roomDevice = RoomsDevicesDataModel(
          roomId: roomDevices!.roomId,
          roomType: roomDevices!.roomType,
          lights: val,
          lightsValue: roomDevices!.lightsValue,
          airConditioner: roomDevices!.airConditioner,
          airConditionerValue: roomDevices!.airConditionerValue,
          music: roomDevices!.music,
          musicValue: roomDevices!.musicValue,
        );
        BlocProvider.of<DevicesBloc>(context).add(
          ChangingLightsRequested(roomDevice: roomDevice),
        );
        break;
      case 'sunny':
        final roomDevice = RoomsDevicesDataModel(
          roomId: roomDevices!.roomId,
          roomType: roomDevices!.roomType,
          lights: roomDevices!.lights,
          lightsValue: roomDevices!.lightsValue,
          airConditioner: roomDevices!.airConditioner,
          airConditionerValue: roomDevices!.airConditionerValue,
          music: val,
          musicValue: roomDevices!.musicValue,
        );
        BlocProvider.of<DevicesBloc>(context).add(
          ChangingMusicRequested(roomDevice: roomDevice),
        );
        break;
      case 'snow-outline':
        final roomDevice = RoomsDevicesDataModel(
          roomId: roomDevices!.roomId,
          roomType: roomDevices!.roomType,
          lights: roomDevices!.lights,
          lightsValue: roomDevices!.lightsValue,
          airConditioner: val,
          airConditionerValue: roomDevices!.airConditionerValue,
          music: roomDevices!.music,
          musicValue: roomDevices!.musicValue,
        );
        BlocProvider.of<DevicesBloc>(context).add(
          ChangingAirConditionerRequested(roomDevice: roomDevice),
        );
        break;
      default:
        break;
    }
  }

  bool _changeIconColor(String icon) {
    switch (icon) {
      case 'contrast-outline':
        return roomDevices!.lights!;
      case 'sunny':
        return roomDevices!.music!;
      case 'snow-outline':
        return roomDevices!.airConditioner!;
      default:
        return false;
    }
  }

  void _changeDeviceValue(int newVal, String title, BuildContext context) {
    switch (title) {
      case 'contrast-outline':
        final roomDevice = RoomsDevicesDataModel(
          roomId: roomDevices!.roomId,
          roomType: roomDevices!.roomType,
          lights: roomDevices!.lights,
          lightsValue: newVal,
          airConditioner: roomDevices!.airConditioner,
          airConditionerValue: roomDevices!.airConditionerValue,
          music: roomDevices!.music,
          musicValue: roomDevices!.musicValue,
        );
        BlocProvider.of<DevicesBloc>(context).add(
          ChangingLightsRequested(roomDevice: roomDevice),
        );
        break;
      case 'sunny':
        final roomDevice = RoomsDevicesDataModel(
          roomId: roomDevices!.roomId,
          roomType: roomDevices!.roomType,
          lights: roomDevices!.lights,
          lightsValue: roomDevices!.lightsValue,
          airConditioner: roomDevices!.airConditioner,
          airConditionerValue: roomDevices!.airConditionerValue,
          music: roomDevices!.music,
          musicValue: newVal,
        );
        BlocProvider.of<DevicesBloc>(context).add(
          ChangingMusicRequested(roomDevice: roomDevice),
        );
        break;
      case 'snow-outline':
        final roomDevice = RoomsDevicesDataModel(
          roomId: roomDevices!.roomId,
          roomType: roomDevices!.roomType,
          lights: roomDevices!.lights,
          lightsValue: roomDevices!.lightsValue,
          airConditioner: roomDevices!.airConditioner,
          airConditionerValue: newVal,
          music: roomDevices!.music,
          musicValue: roomDevices!.musicValue,
        );
        BlocProvider.of<DevicesBloc>(context).add(
          ChangingAirConditionerRequested(roomDevice: roomDevice),
        );
        break;
      default:
        break;
    }
  }
}
