import 'package:animations_demo/page/animation_page.dart';
import 'package:animations_demo/page/staggered_animation_page.dart';
import 'package:animations_demo/page/transform_demo_page.dart';
import 'package:flutter/material.dart';

import 'page/basic_animation_page.dart';
import 'page/sample_animation_widgets_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: TransformDemoPage(),
    );
  }
}