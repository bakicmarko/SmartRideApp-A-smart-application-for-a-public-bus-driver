// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_forcast.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WeatherForcastAdapter extends TypeAdapter<WeatherForcast> {
  @override
  final int typeId = 1;

  @override
  WeatherForcast read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WeatherForcast(
      fields[0] as String,
      fields[1] as int,
      fields[2] as int,
      fields[3] as int,
      fields[4] as int,
      fields[5] as int,
    )..wind = fields[6] as int;
  }

  @override
  void write(BinaryWriter writer, WeatherForcast obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.temperature)
      ..writeByte(2)
      ..write(obj.weather)
      ..writeByte(3)
      ..write(obj.pressure)
      ..writeByte(4)
      ..write(obj.humidity)
      ..writeByte(5)
      ..write(obj.precipitation)
      ..writeByte(6)
      ..write(obj.wind);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeatherForcastAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherForcast _$WeatherForcastFromJson(Map<String, dynamic> json) =>
    WeatherForcast(
      json['id'] as String,
      json['temperature'] as int,
      json['weather'] as int,
      json['pressure'] as int,
      json['humidity'] as int,
      json['precipitation'] as int,
    )..wind = json['wind'] as int;

Map<String, dynamic> _$WeatherForcastToJson(WeatherForcast instance) =>
    <String, dynamic>{
      'id': instance.id,
      'temperature': instance.temperature,
      'weather': instance.weather,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'precipitation': instance.precipitation,
      'wind': instance.wind,
    };
