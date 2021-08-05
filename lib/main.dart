import 'package:flutter/material.dart';
import 'package:practical_task_interview/screens/addAttributeScreen.dart';
import 'package:practical_task_interview/screens/addProductScreen.dart';
import 'package:practical_task_interview/screens/homePageScreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePageScreen(),
        AddAttributeScreen.route: (context) => AddAttributeScreen(),
        AddProductScreen.route: (context) => AddProductScreen(),
      },
    ),
  );
}
