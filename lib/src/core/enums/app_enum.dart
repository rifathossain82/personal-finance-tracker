import 'package:personal_finance_tracker/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LocalStorageKey {
  userId,
  accessToken,
  expiryTime,
}

enum TransactionType{
  cashIn,
  cashOut,
}

enum PaymentMethod{
  cash,
  bkash,
  nagad,
  rocket,
  upay,
  bank,
}