import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name, id; // Make id nullable

  const User({required this.name, required this.id});

  @override
  List<Object?> get props => [name, id];
}