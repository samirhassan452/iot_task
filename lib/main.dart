import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_task/app.dart';
import 'package:iot_task/backend/blocs/blocs.dart';
import 'package:iot_task/backend/configs/configs.dart';
import 'package:iot_task/backend/services/services.dart';
import 'package:iot_task/simple_bloc_observer.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  final ApiService apiService = ApiService(httpClient: http.Client());

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<BottomNavBarBloc>(
          create: (context) => BottomNavBarBloc(
            navBarItems: defaultConfiguration["NavBars"],
          ),
        ),
        BlocProvider<TabBarBloc>(
          create: (context) => TabBarBloc(
            tabBarItems: defaultConfiguration["TabBars"],
          ),
        ),
        BlocProvider<DataBloc>(
          create: (context) => DataBloc(apiService: apiService),
        ),
        BlocProvider<RoomDetailsBloc>(
          create: (context) => RoomDetailsBloc(apiService: apiService),
        ),
        BlocProvider<DevicesBloc>(
          create: (context) => DevicesBloc(apiService: apiService)
            ..add(
              DevicesRequested(),
            ),
        ),
        BlocProvider<MusicBloc>(
          create: (context) => MusicBloc(),
        ),
        BlocProvider<RoomBloc>(
          create: (context) => RoomBloc(),
        ),
      ],
      child: App(),
    ),
  );
}
