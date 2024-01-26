import 'package:appapijtest/presentation/1/start/startscreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String globalVariable = "https://gemstone-shop-api-ix6i.onrender.com";


void main() {
  runApp(const MyApp());} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StartScreen(),
    );
  }
}
