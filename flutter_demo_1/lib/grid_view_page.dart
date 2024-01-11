import 'package:flutter/material.dart';

class GridViewPage extends StatelessWidget {
  const GridViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gird View Page"),
      ),
      body: GridView.builder(
        // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 300),
        scrollDirection: Axis.vertical,
        reverse: false,
        // childAspectRatio: 2 / 3,
        itemCount: 9,
        itemBuilder: (context, index) {
          return Container(color: Colors.orange[(index+1)*100],);
        },
        /* children: [
          Container(
            color: Colors.orange.shade300,
          ),
          Container(
            color: Colors.orange.shade400,
          ),
          Container(
            color: Colors.orange.shade500,
          ),
          Container(
            color: Colors.orange.shade600,
          ),
          Container(
            color: Colors.orange.shade700,
          ),
          Container(
            color: Colors.orange.shade800,
          ),
          Container(
            color: Colors.orange.shade900,
          ),
          Container(
            color: Colors.orange.shade300,
          ),
          Container(
            color: Colors.orange.shade400,
          ),
          Container(
            color: Colors.orange.shade500,
          ),
          Container(
            color: Colors.orange.shade600,
          ),
          Container(
            color: Colors.orange.shade700,
          ),
          Container(
            color: Colors.orange.shade800,
          ),
          Container(
            color: Colors.orange.shade900,
          ),
        ], */
      ),
    );
  }
}
