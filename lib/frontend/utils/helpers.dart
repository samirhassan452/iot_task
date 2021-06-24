import 'package:flutter/material.dart';

class LinearGradientMask extends StatelessWidget {
  LinearGradientMask({this.child, this.isActive});
  final Widget? child;
  final bool? isActive;

  @override
  Widget build(BuildContext context) {
    return isActive!
        ? ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFd63375),
                  Color(0xFFf0a021),
                ],
              ).createShader(bounds);
            },
            child: child,
          )
        : Container(
            child: child,
          );
  }
}

final Shader linearGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFd63375),
    Color(0xFFf0a021),
  ],
).createShader(
  Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
);

String capitalizeFirstLetter(String? oldWord) {
  String tempWord = "";
  String newWord = "";
  oldWord!.split(' ').forEach((word) {
    tempWord = word[0].toUpperCase();
    tempWord += word.substring(1, word.length);
    tempWord += " ";
    newWord += tempWord;
  });
  return newWord.trim();
}

List<dynamic> createListOfRoomsDevicesData() => [
      {
        "room_id": "1",
        "room_type": "6",
        "lights": false,
        "lights_value": 100,
        "air_conditioner": false,
        "air_conditioner_value": 30,
        "music": false,
        "music_value": 100,
      },
      {
        "room_id": "2",
        "room_type": "2",
        "lights": false,
        "lights_value": 100,
        "air_conditioner": false,
        "air_conditioner_value": 30,
        "music": false,
        "music_value": 100,
      },
      {
        "room_id": "3",
        "room_type": "4",
        "lights": false,
        "lights_value": 100,
        "air_conditioner": false,
        "air_conditioner_value": 30,
        "music": false,
        "music_value": 100,
      },
      {
        "room_id": "4",
        "room_type": "1",
        "lights": false,
        "lights_value": 100,
        "air_conditioner": false,
        "air_conditioner_value": 30,
        "music": false,
        "music_value": 100,
      },
      {
        "room_id": "5",
        "room_type": "8",
        "lights": false,
        "lights_value": 100,
        "air_conditioner": false,
        "air_conditioner_value": 30,
        "music": false,
        "music_value": 100,
      },
      {
        "room_id": "6",
        "room_type": "5",
        "lights": false,
        "lights_value": 100,
        "air_conditioner": false,
        "air_conditioner_value": 30,
        "music": false,
        "music_value": 100,
      },
    ];
