import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LocalStorageKey {
  userId,
  accessToken,
  expiryTime,
}

enum MessageStatus {
  active(key: 'active', value: 'Active', color: successColor),
  resolved(key: 'resolved', value: 'Resolved', color: kTextButtonColor),
  closed(key: 'closed', value: 'Closed', color: kGrey),
  expired(key: 'expired', value: 'Expired', color: failedColor);

  final String key;
  final String value;
  final Color color;

  const MessageStatus({
    required this.key,
    required this.value,
    required this.color,
  });

  /// Static method to get color from status key
  static Color getColor(String status) {
    return MessageStatus.values
        .firstWhere((e) => e.key == status, orElse: () => MessageStatus.expired)
        .color;
  }

  /// Optional: get MessageStatus from key
  static MessageStatus fromKey(String key) {
    return MessageStatus.values
        .firstWhere((e) => e.key == key, orElse: () => MessageStatus.expired);
  }
}

enum UserStatus {
  active(key: 'active', value: 'Active', color: successColor),
  banned(key: 'banned', value: 'Banned', color: failedColor);

  final String key;
  final String value;
  final Color color;

  const UserStatus({
    required this.key,
    required this.value,
    required this.color,
  });

  /// Static method to get color from status key
  static Color getColor(String? status) {
    return UserStatus.values
        .firstWhereOrNull((e) => e.key == status)?.color ?? failedColor;
  }

  /// Optional: get UserStatus from key
  static UserStatus fromKey(String? key) {
    return UserStatus.values
        .firstWhereOrNull((e) => e.key == key) ?? UserStatus.banned;
  }
}

