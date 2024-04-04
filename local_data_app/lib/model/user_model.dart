import 'package:hive_flutter/hive_flutter.dart';

import 'enums.dart';

part "user_model.g.dart";

@HiveType(typeId: 1)
class UserModel {
  UserModel({
    required this.name,
    required this.renk,
    required this.sehirler,
    required this.mezunMu,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  String renk;

  @HiveField(2, defaultValue: [])
  List<Sehir> sehirler;

  @HiveField(3)
  bool mezunMu;

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "renk": renk,
      "sehirler": sehirler.map((e) => e.name).toList(),
      "mezunMu": mezunMu,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json["name"],
      renk: json["renk"],
      sehirler: json["sehirler"]
          .map<Sehir>(
            (sehirString) => Sehir.values.firstWhere(
              (sehir) => sehir.name == sehirString.toString(),
            ),
          )
          .toList(),
      mezunMu: json["mezunMu"],
    );
  }

  @override
  String toString() {
    return "name: $name  |  renk: $renk  |  sehirler: $sehirler  |  mezunMu: $mezunMu";
  }
}
