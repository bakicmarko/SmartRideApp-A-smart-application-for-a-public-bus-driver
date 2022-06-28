// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RouteAdapter extends TypeAdapter<Route> {
  @override
  final int typeId = 1;

  @override
  Route read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Route(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
      fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Route obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.station1)
      ..writeByte(2)
      ..write(obj.station2)
      ..writeByte(3)
      ..write(obj.station3)
      ..writeByte(4)
      ..write(obj.station4)
      ..writeByte(5)
      ..write(obj.station5)
      ..writeByte(6)
      ..write(obj.station6)
      ..writeByte(7)
      ..write(obj.station7)
      ..writeByte(8)
      ..write(obj.currentStation);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RouteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Route _$RouteFromJson(Map<String, dynamic> json) => Route(
      json['id'] as String,
      json['station1'] as String,
      json['station2'] as String,
      json['station3'] as String,
      json['station4'] as String,
      json['station5'] as String,
      json['station6'] as String,
      json['station7'] as String,
      json['currentStation'] as String,
    );

Map<String, dynamic> _$RouteToJson(Route instance) => <String, dynamic>{
      'id': instance.id,
      'station1': instance.station1,
      'station2': instance.station2,
      'station3': instance.station3,
      'station4': instance.station4,
      'station5': instance.station5,
      'station6': instance.station6,
      'station7': instance.station7,
      'currentStation': instance.currentStation,
    };
