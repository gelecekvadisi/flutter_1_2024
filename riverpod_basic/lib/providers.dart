import 'package:flutter_riverpod/flutter_riverpod.dart';

final titleProvider = Provider<String>((ref) => "Riverpod Demo");
final counterProvider = StateProvider<int>((ref) => 0);