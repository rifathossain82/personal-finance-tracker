import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_finance_tracker/src/core/core.dart';

class TransactionModel {
  final String? id;
  final String? userId;
  final TransactionType? type;
  final PaymentMethod? paymentMethod;
  final num? amount;
  final String? category;
  final String? description;
  final DateTime? date;
  final DateTime? createdAt;

  TransactionModel({
    this.id,
    this.userId,
    this.type,
    this.paymentMethod,
    this.amount,
    this.category,
    this.description,
    this.date,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // Convert to Json for Firestore
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'type': type != null ? type!.name : '',
      'paymentMethod': paymentMethod != null ? paymentMethod!.name : '',
      'amount': amount,
      'category': category,
      'description': description,
      'date': Timestamp.fromDate(date!),
      'createdAt': Timestamp.fromDate(createdAt!),
    };
  }

  // Create from Firestore document
  factory TransactionModel.fromJson(Map<String, dynamic> map, String id) {
    return TransactionModel(
      id: id,
      userId: map['userId'] ?? '',
      type: map['type'] == 'cashIn' ? TransactionType.cashIn : TransactionType.cashOut,
      paymentMethod: map['paymentMethod'] == 'cash' ? PaymentMethod.cash : PaymentMethod.bkash,
      amount: (map['amount'] ?? 0).toDouble(),
      category: map['category'] ?? '',
      description: map['description'],
      date: (map['date'] as Timestamp).toDate(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  // Create a copy with updated fields
  TransactionModel copyWith({
    String? id,
    String? userId,
    TransactionType? type,
    PaymentMethod? paymentMethod,
    num? amount,
    String? category,
    String? description,
    DateTime? date,
    DateTime? createdAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      amount: amount ?? this.amount,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}