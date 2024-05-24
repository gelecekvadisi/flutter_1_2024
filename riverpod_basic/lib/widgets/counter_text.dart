import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

class CounterText extends ConsumerWidget {
  const CounterText({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint("CounterText build");
    int number = ref.watch(counterProvider);
    return Column(
      children: [
        Text(
          number.toString(),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          "Notifer değeri: ${ref.watch(counterNotifierProvider).value}",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          "Fark: ${ref.watch(sayiFarkiProvider)}",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
