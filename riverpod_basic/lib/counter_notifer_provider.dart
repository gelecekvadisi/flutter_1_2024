import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_basic/counter_model.dart';

class CounterNotifer extends StateNotifier<CounterModel> {
  CounterNotifer(super.state);
  
  arttir() {
    state = CounterModel(state.value +3);
  }
}