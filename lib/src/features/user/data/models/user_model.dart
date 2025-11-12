import 'package:personal_finance_tracker/src/core/core.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? phone;
  final String? image;
  final String? email;
  final String? note;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.image,
    this.email,
    this.note,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? image,
    String? email,
    String? note,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      email: email ?? this.email,
      note: note ?? this.note,
    );
  }


  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      image: map['image'],
      email: map['email'],
      note: map['note'],
    );
  }

  Map<String, dynamic> toJsonForAdd() {
    return {
      'name': name,
      'phone': phone,
      'image': image,
      'email': email,
      'note': note,
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      'name': name,
      'phone': phone,
      'image': image,
      'note': note,
    };
  }

  Map<String, dynamic> toJsonForDataEntry() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
