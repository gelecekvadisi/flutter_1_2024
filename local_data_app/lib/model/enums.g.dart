// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enums.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SehirAdapter extends TypeAdapter<Sehir> {
  @override
  final int typeId = 2;

  @override
  Sehir read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Sehir.Ankara;
      case 1:
        return Sehir.Istanbul;
      case 2:
        return Sehir.Bursa;
      case 3:
        return Sehir.Izmir;
      case 4:
        return Sehir.Konya;
      case 5:
        return Sehir.Kocaeli;
      default:
        return Sehir.Ankara;
    }
  }

  @override
  void write(BinaryWriter writer, Sehir obj) {
    switch (obj) {
      case Sehir.Ankara:
        writer.writeByte(0);
        break;
      case Sehir.Istanbul:
        writer.writeByte(1);
        break;
      case Sehir.Bursa:
        writer.writeByte(2);
        break;
      case Sehir.Izmir:
        writer.writeByte(3);
        break;
      case Sehir.Konya:
        writer.writeByte(4);
        break;
      case Sehir.Kocaeli:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SehirAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
