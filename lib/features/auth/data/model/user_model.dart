import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.name, required super.id});

  Map<String, dynamic> toMap() => {
    'name': name,
  };

  factory UserModel.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return UserModel(
      name: doc.data()['name'],
      id: doc.id,
    );
  }
}