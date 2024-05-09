import 'package:animations_demo/page/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// AnimationController
/// Ticker
/// Animation

class BasicAnimationPage extends StatefulWidget {
  BasicAnimationPage({super.key});

  @override
  State<BasicAnimationPage> createState() => _BasicAnimationPageState();
}

class _BasicAnimationPageState extends State<BasicAnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: Duration(seconds: 1),
    );

    animationController.forward();

    animationController.addListener(() {
      debugPrint("Animasyon değeri: ${animationController.value}");

      if (animationController.status == AnimationStatus.completed) {
        animationController.reverse();
      } else if (animationController.status == AnimationStatus.dismissed) {
        animationController.forward();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animasyonlar"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(left: animationController.value*32),
              child: Opacity(
                opacity: animationController.value,
                child: Container(
                  height: (animationController.value*100) +100,
                  width: (animationController.value*100) +100,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 48),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SecondPage(),
                    ),
                  );
                },
                child: Text("İkinci sayfaya git")),
            const Hero(
              tag: "flutter_logo",
              child: FlutterLogo(
                size: 256,
                textColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
