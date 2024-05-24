import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers.dart';
import 'widgets/counter_text.dart';
import 'widgets/my_floating_action_button.dart';

// final titleProvider = Provider((ref) {
//   return "Material App Title";
// });

// final numberProvider = StateProvider<int>((ref) => 0);

// final futureProvider = FutureProvider((ref) async {
//   return 5;
// });

// final streamProvider = StreamProvider((ref) {
//   return Stream.value(5);
// });

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    debugPrint("HomePage build");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Consumer(builder: ((context, ref, child) {
          String metin = ref.watch(titleProvider);
          return Text(metin);
        })),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            CounterText(),
          ],
        ),
      ),
      floatingActionButton: MyFloatingActionButton(),
    );
  }
}
