import 'enums.dart';

class UserModel {
  UserModel({
    required this.name,
    required this.renk,
    required this.sehirler,
    required this.mezunMu,
  });

  String name;
  String renk;
  List<Sehir> sehirler;
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
}
