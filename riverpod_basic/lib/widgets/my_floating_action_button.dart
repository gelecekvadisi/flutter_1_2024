import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class MyFloatingActionButton extends StatelessWidget {
  MyFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint("FAB build");
    return Consumer(builder: (context, ref, child) {
      return FloatingActionButton(
        onPressed: () {
          ref.read(counterProvider.notifier).state++;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      );
    });
  }
}