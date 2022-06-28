import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;

part 'route.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Route {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String station1;
  @HiveField(2)
  final String station2;
  @HiveField(3)
  final String station3;
  @HiveField(4)
  final String station4;
  @HiveField(5)
  final String station5;
  @HiveField(6)
  final String station6;
  @HiveField(7)
  final String station7;
  @HiveField(8)
  final String currentStation;

  Route(this.id, this.station1, this.station2, this.station3, this.station4, this.station5, this.station6,
      this.station7, this.currentStation);

  factory Route.fromJson(Map<String, dynamic> json) => _$RouteFromJson(json);

  Map<String, dynamic> toJson() => _$RouteToJson(this);
}
