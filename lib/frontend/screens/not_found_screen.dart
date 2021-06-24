import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Not found page",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
      body: Center(
        child: Text(
          "This page does not exist!",
          style: TextStyle(
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }
}
