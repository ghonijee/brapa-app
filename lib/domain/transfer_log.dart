// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brapa/domain/transaction.dart';

import 'account.dart';

class TransferLog {
  final int? id;
  final Transaction? transactionFrom;
  final Transaction? transactionTo;
  final int? fromId;
  final int? toId;
  final DateTime? createdAt;
  final Account? fromAccount;
  final Account? toAccount;
  final int? amount;

  TransferLog({
    this.id,
    this.transactionFrom,
    this.transactionTo,
    this.fromId,
    this.toId,
    this.createdAt,
    this.fromAccount,
    this.toAccount,
    this.amount,
  });

  TransferLog copyWith({
    int? id,
    Transaction? transactionFrom,
    Transaction? transactionTo,
    int? fromId,
    int? toId,
    DateTime? createdAt,
    Account? fromAccount,
    Account? toAccount,
    int? amount,
  }) {
    return TransferLog(
      id: id ?? this.id,
      transactionFrom: transactionFrom ?? this.transactionFrom,
      transactionTo: transactionTo ?? this.transactionTo,
      fromId: fromId ?? this.fromId,
      toId: toId ?? this.toId,
      createdAt: createdAt ?? this.createdAt,
      fromAccount: fromAccount ?? this.fromAccount,
      toAccount: toAccount ?? this.toAccount,
      amount: amount ?? this.amount,
    );
  }
}
