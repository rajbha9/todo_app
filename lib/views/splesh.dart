import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class Saplesh extends StatefulWidget {
  const Saplesh({super.key});

  @override
  State<Saplesh> createState() => SapleshState();
}

class SapleshState extends State<Saplesh> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
      Duration(seconds: 3),
      () {
        Get.toNamed('/');
        // Navigator.of(context).pushNamed('/');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('asset/img/logo.gif'),
        // child: FlutterLogo(size: 200,),
      ),
    );
  }
}
