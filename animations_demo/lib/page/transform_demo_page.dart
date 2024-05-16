import 'package:flutter/material.dart';
import 'dart:math' as math;

class TransformDemoPage extends StatefulWidget {
  const TransformDemoPage({super.key});

  @override
  State<TransformDemoPage> createState() => TransformDemoPageState();
}

class TransformDemoPageState extends State<TransformDemoPage> {
  double angle = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transform Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Slider(
              value: angle,
              min: 0.0,
              max: 2.0,
              onChanged: (value) {
                setState(() {
                  angle = value;
                });
              },
            ),
            Transform.rotate(
              angle: math.pi * angle,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: Text("Hello World!"),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Transform.scale(
              scale: angle,
              origin: Offset(50, -50),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: Text("Hello World!"),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Transform.translate(
              offset: Offset(angle * 50, 0),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: Text("Hello World!"),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Transform.flip(
              flipX: true,
              flipY: true,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: Text("Hello World!"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
