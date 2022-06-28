import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;

part 'request.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Request {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String firstName;
  @HiveField(3)
  final String surName;
  @HiveField(4)
  final String phoneNumber;
  @HiveField(5)
  double rating;
  @HiveField(6)
  int accepted;
  @HiveField(7)
  final String start;
  @HiveField(8)
  final String destination;
  @HiveField(9)
  int travelTime;
  @HiveField(10)
  int travelDistance;

  Request(this.id, this.email, this.firstName, this.surName, this.phoneNumber, this.rating, this.start,
      this.destination, this.accepted, this.travelDistance, this.travelTime) {
    if (rating > 5.0) {
      double newValue = double.parse((rating % 5 + 1).toStringAsFixed(1));
      // debugPrint(newValue.toString());
      if (newValue > 5.0) {
        rating = 5.0;
      } else {
        rating = newValue;
      }
    }
    accepted = accepted % 2;
    travelTime = travelTime % 30 + 15;
    travelDistance = travelDistance % 30 + 15;
  }

  factory Request.fromJson(Map<String, dynamic> json) => _$RequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestToJson(this);
}
