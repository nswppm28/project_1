// main.dart

import 'package:flutter/material.dart';
import 'package:project_1/screens/home/add_menu.dart';
import 'package:project_1/screens/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      routes: {
        AddMenuPage.routeName: (context) => const AddMenuPage(),
      },
    );
  }
}
