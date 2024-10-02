import 'dart:typed_data';

class UserModel {
  int? id;
  String name;
  String password;

  UserModel({required this.name, this.id, required this.password});

  factory UserModel.fromMap({required Map<String, dynamic> data}) {
    return UserModel(
        id: data['id'], name: data['name'], password: data['password']);
  }
}
