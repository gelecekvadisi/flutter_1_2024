import 'package:flutter/material.dart';

class StaggeredAnimationPage extends StatefulWidget {
  StaggeredAnimationPage({super.key});

  @override
  State<StaggeredAnimationPage> createState() => _StaggeredAnimationPageState();
}

class _StaggeredAnimationPageState extends State<StaggeredAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation opacityAnimation;
  late Animation widthAnimation;
  late Animation heightAnimation;
  late Animation radiusAnimation;
  late Animation colorAnimation;
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 2));
    opacityAnimation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.0, 0.2, curve: Curves.easeIn),
      ),
    );
    widthAnimation = Tween(
      begin: 30.0,
      end: 100.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.2, 0.4),
      ),
    );
    heightAnimation = Tween(
      begin: 30.0,
      end: 100.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.4, 0.6),
      ),
    );
    radiusAnimation = Tween(
      begin: 0.0,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.6, 0.8),
      ),
    );
    colorAnimation = ColorTween(
      begin: Colors.blue.shade300,
      end: Colors.purple,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.6, 1.0),
      ),
    );
  
    animationController.forward().then((value) => animationController.reverse());
  }

  @override
  void dispose() {
    animationController.dispose();
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Senkronize Animasyonlar"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, child) {
            return Container(
              padding: EdgeInsets.all(80),
              decoration: BoxDecoration(border: Border.all()),
              child: Opacity(
                opacity: opacityAnimation.value,
                child: Container(
                  width: widthAnimation.value,
                  height: heightAnimation.value,
                  decoration: BoxDecoration(
                    color: colorAnimation.value,
                    borderRadius: BorderRadius.circular(radiusAnimation.value),
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
