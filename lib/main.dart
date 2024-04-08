import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/views/homepage.dart';
import 'package:todo_app/views/splesh.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomaPage(),
        ),
        GetPage(
          name: '/splash',
          page: () => Saplesh(),
        )
      ],
    );
  }
}
