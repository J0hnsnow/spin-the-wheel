import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spin the Wheel',
      home: SpinTheWheel(),
    );
  }
}

class SpinTheWheel extends StatefulWidget {
  @override
  _SpinTheWheelState createState() => _SpinTheWheelState();
}

class _SpinTheWheelState extends State<SpinTheWheel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _angle = 0;
  List<String> _items = [
    'Prize 1',
    'Prize 2',
    'Prize 3',
    'Prize 4',
    'Prize 5',
    'Prize 6'
  ];
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    )..addListener(() {
        setState(() {
          _angle = _animation.value * 2 * pi;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Spin the Wheel'),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _spin() {
    if (_emailController.text.isEmpty) {
      _showDialog('Please enter your email to spin the wheel.');
    } else {
      _controller.forward(from: 0).whenComplete(() {
        int index = Random().nextInt(_items.length);
        _showDialog('Congratulations! You won ${_items[index]}');
        _controller.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spin the Wheel'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Transform.rotate(
              angle: _angle,
              child: Image.asset(
                'assets/wheel.png',
                height: 250,
                width: 250,
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'Enter your email address',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _spin,
            child: Text('Spin the Wheel'),
          ),
        ],
      ),
    );
  }
}
