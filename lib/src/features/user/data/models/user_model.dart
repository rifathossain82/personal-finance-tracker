import 'package:personal_finance_tracker/src/core/core.dart';

class UserModel {
  final String? id;
  final String? name;
  final String? phone;
  final String? image;
  final String? email;
  final bool? isAdmin;
  final String? status;
  final String? note;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.image,
    this.email,
    this.isAdmin,
    this.status,
    this.note,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? image,
    String? email,
    bool? isAdmin,
    String? status,
    String? note,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      image: image ?? this.image,
      email: email ?? this.email,
      isAdmin: isAdmin ?? this.isAdmin,
      status: status ?? this.status,
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
      isAdmin: map['is-admin'],
      status: map['status'],
      note: map['note'],
    );
  }

  Map<String, dynamic> toJsonForAdd() {
    return {
      'name': name,
      'phone': phone,
      'image': image,
      'email': email,
      'is-admin': false,
      'status': UserStatus.active.key,
      'note': note,
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      'name': name,
      'phone': phone,
      'image': image,
      'is-admin': isAdmin,
      'status': status,
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
