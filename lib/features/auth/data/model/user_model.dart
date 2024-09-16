import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final String userId;
  final String email;
  final String? phoneNumber; // رقم الهاتف اختياري
  final String? address; // العنوان اختياري

  UserModel({
    required this.name,
    required this.userId,
    required this.email,
    this.phoneNumber,
    this.address,
  });

  Map<String, dynamic> toMap() => {
    'name': name,
    'userId': userId,
    'email': email,
    'phoneNumber': phoneNumber,
    'address': address,
  };

  factory UserModel.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    print('${doc.id} from testing docId');
    return UserModel(
      name: doc.data()?['name'] ?? '',
      userId: doc.id, // Use the document ID as the user ID
      email: doc.data()?['email'] ?? '',
      phoneNumber: doc.data()?['phoneNumber'],
      address: doc.data()?['address'],
    );
  }

  UserModel copyWith({
    String? name,
    String? userId,
    String? email,
    String? phoneNumber,
    String? address,
  }) {
    return UserModel(
      name: name ?? this.name,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
    );
  }

  @override
  String toString() {
    return 'UserModel{name: $name, id: $userId, email: $email, phoneNumber: $phoneNumber, address: $address}';
  }
}
