import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimationPage extends StatefulWidget {
  AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController sizeController;
  late Animation sizeAnimation;
  late Animation<Color?> colorAnimation;
  late Animation<AlignmentGeometry?> alignmentAnimation;

  @override
  void dispose() {
    sizeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    sizeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    sizeAnimation = Tween(
      begin: 100.0,
      end: 300.0,
    ).animate(
      CurvedAnimation(
        parent: sizeController,
        curve: Curves.easeInOutExpo,
      ),
    );

    colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.yellow,
    ).animate(sizeController);

    alignmentAnimation = AlignmentTween(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ).animate(CurvedAnimation(parent: sizeController, curve: Curves.easeInOutExpo));

    sizeController.forward();

    sizeController.addListener(() {
      debugPrint("Animasyon değeri: ${sizeController.value}");

      if (sizeController.status == AnimationStatus.completed) {
        sizeController.reverse();
      } else if (sizeController.status == AnimationStatus.dismissed) {
        sizeController.forward();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation Page"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: colorAnimation.value,
              width: sizeAnimation.value,
              height: sizeAnimation.value,
            ),
            Spacer(),
            Container(
              width: 300,
              height: 300,
              color: Colors.blueAccent,
              alignment: alignmentAnimation.value,
              child: Text("Flutter"),
            ),
          ],
        ),
      ),
    );
  }
}
