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
}
