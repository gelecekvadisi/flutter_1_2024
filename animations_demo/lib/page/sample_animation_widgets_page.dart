import 'package:flutter/material.dart';

class SampleAnimaionWidgetsPage extends StatefulWidget {
  const SampleAnimaionWidgetsPage({super.key});

  @override
  State<SampleAnimaionWidgetsPage> createState() =>
      _SampleAnimaionWidgetsPageState();
}

class _SampleAnimaionWidgetsPageState extends State<SampleAnimaionWidgetsPage> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample Animation Widgets"),
      ),
      body: Column(
        children: [
          // AnimatedContainer(
          //   duration: Duration(seconds: 3),
          //   width: isSelected ? 200 : 180,
          //   height: isSelected ? 200 : 180,
          //   decoration: BoxDecoration(
          //     color: isSelected ? Colors.red : Colors.blue,
          //     boxShadow: isSelected
          //         ? [
          //             if (isSelected)
          //               BoxShadow(
          //                   color: Colors.black38,
          //                   offset: Offset(10, 15),
          //                   blurRadius: 20),
          //           ]
          //         : null,
          //   ),
          // ),
          SizedBox(
            height: 64,
          ),
          AnimatedCrossFade(
            alignment: Alignment.center,
            firstChild: Container(
              child: Text("First Child"),
            ),
            secondChild: Container(
              child: Text("Second Child. Second Child. Second Child. Second Child. Second Child. "),
            ),
            crossFadeState: isSelected
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(seconds: 2),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isSelected = !isSelected;
              });
            },
            child: Text(isSelected ? "İptal" : "Seç"),
          ),
        ],
      ),
    );
  }
}
