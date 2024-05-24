import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basic/counter_notifer_provider.dart';
import 'package:riverpod_basic/counter_model.dart';

final titleProvider = Provider<String>((ref) => "Riverpod Demo");
final counterProvider = StateProvider<int>((ref) => 0);

final counterNotifierProvider =
    StateNotifierProvider<CounterNotifer, CounterModel>(
  (ref) => CounterNotifer(CounterModel(0)),
);

final sayiFarkiProvider = Provider<int>((ref) {
  int counterValue = ref.watch(counterProvider);
  int counterNotifierValue = ref.watch(counterNotifierProvider).value;

  return counterNotifierValue - counterValue;
});
