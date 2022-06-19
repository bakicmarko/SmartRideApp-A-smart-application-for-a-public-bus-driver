import 'dart:math';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_forcast.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class WeatherForcast {
  @HiveField(0)
  final String id;
  @HiveField(1)
  int temperature;
  @HiveField(2)
  int weather;
  @HiveField(3)
  int pressure;
  @HiveField(5)
  int humidity;
  @HiveField(4)
  int precipitation;

  WeatherForcast(this.id, this.temperature, this.weather, this.pressure, this.humidity, this.precipitation) {
    var rng = Random();
    if (temperature > 35) {
      temperature = rng.nextInt(20) + 10;
    }
    if (pressure < 500 || pressure > 1200) {
      pressure = rng.nextInt(700) + 500;
    }
    if (humidity > 100) {
      humidity = rng.nextInt(80) + 20;
    }
    if (precipitation > 100) {
      precipitation = rng.nextInt(80) + 20;
    }

    if (weather % 6 == 0) {
      weather = 6;
    } else if (weather % 4 == 0) {
      weather = 4;
    } else if (weather % 5 == 0) {
      weather = 5;
    } else if (weather % 3 == 0) {
      weather = 3;
    } else {
      weather = 7;
    }
  }

  factory WeatherForcast.fromJson(Map<String, dynamic> json) => _$WeatherForcastFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherForcastToJson(this);
}
