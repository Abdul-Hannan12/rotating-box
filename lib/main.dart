import 'package:flutter/material.dart';
import 'dart:math' show pi;

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rotating Box Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  String axis = 'Z';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0.0, end: pi * 2).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Matrix4 getAxisTransform(String axis) {
    switch (axis) {
      case "X":
        return Matrix4.identity()..rotateX(_animation.value);
      case "Y":
        return Matrix4.identity()..rotateY(_animation.value);
      case "Z":
        return Matrix4.identity()..rotateZ(_animation.value);
      default:
        return Matrix4.identity()..rotateZ(_animation.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: getAxisTransform(axis),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Colors.blueGrey,
        animatedIcon: AnimatedIcons.menu_close,
        overlayColor: Colors.black12,
        spaceBetweenChildren: 12,
        children: [
          SpeedDialChild(
            backgroundColor: Colors.deepPurple,
            label: 'Z Axis',
            labelBackgroundColor: Colors.blueGrey,
            child: const Icon(Icons.rotate_right_rounded),
            onTap: () {
              setState(() {
                axis = 'Z';
              });
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.deepPurple,
            child: const Icon(Icons.keyboard_double_arrow_right_rounded),
            label: 'Y Axis',
            labelBackgroundColor: Colors.blueGrey,
            onTap: () {
              setState(() {
                axis = 'Y';
              });
            },
          ),
          SpeedDialChild(
            backgroundColor: Colors.deepPurple,
            label: 'X Axis',
            labelBackgroundColor: Colors.blueGrey,
            child: const Icon(Icons.keyboard_double_arrow_down_rounded),
            onTap: () {
              setState(() {
                axis = 'X';
              });
            },
          ),
        ],
      ),
    );
  }
}
