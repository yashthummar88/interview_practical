import 'package:flutter/material.dart';
import 'package:practical_task_interview/screens/addAttributeScreen.dart';
import 'package:practical_task_interview/screens/addProductScreen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products and Catagory"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddAttributeScreen.route);
              },
              child: Text("Add Attribute"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddProductScreen.route);
              },
              child: Text("Add Product"),
            ),
          ],
        ),
      ),
    );
  }
}
