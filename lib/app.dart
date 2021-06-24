import 'package:flutter/material.dart';
import 'package:iot_task/frontend/utils/utils.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Task',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.home,
      onGenerateRoute: CustomRouter.allRoutes,
    );
  }
}
