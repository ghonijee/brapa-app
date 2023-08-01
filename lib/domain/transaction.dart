// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:how_much/domain/category.dart';

import 'account.dart';

class Transaction {
  int? id;

  final TransactionType type;

  final int value;

  String? memo;

  DateTime? createdAt;

  final Category category;

  final Account account;

  Transaction({
    this.id,
    required this.type,
    required this.value,
    this.memo,
    this.createdAt,
    required this.category,
    required this.account,
  });

  @override
  String toString() {
    return 'Transaction(id: $id, type: $type, value: $value, memo: $memo, createdAt: $createdAt, category: $category, account: $account)';
  }
}

enum TransactionType { exp, inc }
