// ignore: file_names
import 'package:hive/hive.dart';
// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;

part 'User.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class User {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String firstName;
  @HiveField(3)
  final String surName;
  @HiveField(5)
  final String phoneNumber;
  @HiveField(4)
  double rating;
  @HiveField(6)
  final String location;
  @HiveField(7)
  final String password;

  User(this.id, this.email, this.firstName, this.surName, this.phoneNumber, this.rating, this.location, this.password) {
    if (rating > 5.0) {
      double newValue = double.parse((rating % 5 + 1).toStringAsFixed(1));
      // debugPrint(newValue.toString());
      if (newValue > 5.0) {
        rating = 5.0;
      } else {
        rating = newValue;
      }
    }
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
