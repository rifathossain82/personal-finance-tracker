import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class CategoryModel {
  final String? id;
  final String? userId;
  final TransactionType? type;
  final String? name;
  final DateTime? createdAt;

  CategoryModel({
    this.id,
    this.userId,
    this.type,
    this.name,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert to Json for Firestore
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'type': type != null ? type!.name : '',
      'name': name,
      'createdAt': Timestamp.fromDate(createdAt!),
    };
  }

  // Create from Firestore document
  factory CategoryModel.fromJson(Map<String, dynamic> map, String id) {
    return CategoryModel(
      id: id,
      userId: map['userId'] ?? '',
      type: map['type'] == 'cashIn'
          ? TransactionType.cashIn
          : TransactionType.cashOut,
      name: map['name'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  // Create a copy with updated fields
  CategoryModel copyWith({
    String? id,
    String? userId,
    TransactionType? type,
    String? name,
    DateTime? createdAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
