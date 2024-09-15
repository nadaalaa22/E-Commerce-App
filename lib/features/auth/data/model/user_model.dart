import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.name,
    required super.id,
    super.address,
    super.age,
    super.phone,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'address': address,
    'age' : age,
    'phone' : phone,
  };

  factory UserModel.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    return UserModel(
      name: doc.data()['name'],
      address: doc.data()['address'],
      age: doc.data()['age'],
      phone: doc.data()['phone'],
      id: doc.id,
    );
  }
}