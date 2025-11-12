class TransactionSummaryModel {
  num? cashInAmount;
  num? cashOutAmount;
  num? totalBalance;

  TransactionSummaryModel({
    this.cashInAmount,
    this.cashOutAmount,
    this.totalBalance,
  });

  factory TransactionSummaryModel.fromJson(Map<String, dynamic> json) =>
      TransactionSummaryModel(
        cashInAmount: json["cashInAmount"] ?? 0,
        cashOutAmount: json["cashOutAmount"] ?? 0,
        totalBalance: json["totalBalance"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "cashInAmount": cashInAmount,
        "cashOutAmount": cashOutAmount,
        "totalBalance": totalBalance,
      };
}
