// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequestAdapter extends TypeAdapter<Request> {
  @override
  final int typeId = 1;

  @override
  Request read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Request(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as double,
      fields[7] as String,
      fields[8] as String,
      fields[6] as int,
      fields[10] as int,
      fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Request obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.surName)
      ..writeByte(4)
      ..write(obj.phoneNumber)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.accepted)
      ..writeByte(7)
      ..write(obj.start)
      ..writeByte(8)
      ..write(obj.destination)
      ..writeByte(9)
      ..write(obj.travelTime)
      ..writeByte(10)
      ..write(obj.travelDistance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Request _$RequestFromJson(Map<String, dynamic> json) => Request(
      json['id'] as String,
      json['email'] as String,
      json['firstName'] as String,
      json['surName'] as String,
      json['phoneNumber'] as String,
      (json['rating'] as num).toDouble(),
      json['start'] as String,
      json['destination'] as String,
      json['accepted'] as int,
      json['travelDistance'] as int,
      json['travelTime'] as int,
    );

Map<String, dynamic> _$RequestToJson(Request instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'surName': instance.surName,
      'phoneNumber': instance.phoneNumber,
      'rating': instance.rating,
      'accepted': instance.accepted,
      'start': instance.start,
      'destination': instance.destination,
      'travelTime': instance.travelTime,
      'travelDistance': instance.travelDistance,
    };
