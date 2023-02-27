import 'package:flutter/material.dart';
import 'package:spin_wheel/main.dart';
import 'package:spin_wheel/spin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: SpinTheWheel(), // Import and use the LoginPage widget here
    );
  }
}
