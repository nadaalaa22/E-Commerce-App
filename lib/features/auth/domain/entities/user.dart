import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name, id; // Make id nullable

  String? phone,address;
  int? age;

  User({
    required this.name,
    required this.id,
    this.phone,
    this.address, 
    this.age
  });

  @override
  List<Object?> get props => [name, id];
}