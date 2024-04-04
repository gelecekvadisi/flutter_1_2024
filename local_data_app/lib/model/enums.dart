import 'package:hive_flutter/hive_flutter.dart';

part "enums.g.dart";

@HiveType(typeId: 2)
enum Sehir {
  @HiveField(0)
  Ankara,

  @HiveField(1)
  Istanbul,
  
  @HiveField(2)
  Bursa,
  
  @HiveField(3)
  Izmir,
  
  @HiveField(4)
  Konya,
  
  @HiveField(5)
  Kocaeli,
}
