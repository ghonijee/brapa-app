// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fpdart/fpdart.dart';
import 'package:brapa/domain/category.dart';
import 'package:intl/intl.dart';

import 'package:app_ui/app_ui.dart';

import 'account.dart';
import 'history.dart';

class Transaction {
  final int? id;

  final TransactionType type;

  final int value;

  final String? memo;

  final DateTime? createdAt;

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

  String subtitle() {
    var value = account.name;
    if (memo != null && memo!.isNotEmpty) {
      value += " - ${memo!.trim()}";
    }
    return value;
  }

  bool isExpense() => type == TransactionType.exp || type == TransactionType.transferOut;
  bool isIncome() => type == TransactionType.inc || type == TransactionType.transferIn;

  Transaction copyWith({
    int? id,
    TransactionType? type,
    int? value,
    String? memo,
    DateTime? createdAt,
    Category? category,
    Account? account,
  }) {
    return Transaction(
      id: id ?? this.id,
      type: type ?? this.type,
      value: value ?? this.value,
      memo: memo ?? this.memo,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
      account: account ?? this.account,
    );
  }
}

extension TransactionExtension on List<Transaction> {
  List<History> groupDaily() {
    var group = <History>[];
    for (var item in this) {
      var indexGroup = group.indexWhere((element) => element.date.eqvYearMonthDay(item.createdAt!));
      if (indexGroup < 0) {
        var historyItem = History(
            label: item.createdAt!.isToday() ? "Today" : DateFormat("dd MMMM yy").format(item.createdAt!),
            date: item.createdAt!,
            amount: 0,
            transactions: [item]);
        historyItem.calculate(item);
        group.add(historyItem);
      } else {
        group[indexGroup].calculate(item);
        group[indexGroup].transactions.add(item);
      }
    }

    return group;
  }

  List<History> groupMonthly() {
    var group = <History>[];
    for (var item in this) {
      var indexGroup = group
          .indexWhere((element) => element.date.eqvMonth(item.createdAt!) && element.date.eqvYear(item.createdAt!));
      if (indexGroup < 0) {
        var historyItem = History(
            label: DateFormat("MMMM yyyy").format(item.createdAt!),
            date: item.createdAt!,
            amount: 0,
            transactions: [item]);
        historyItem.calculate(item);
        group.add(historyItem);
      } else {
        group[indexGroup].calculate(item);
        group[indexGroup].transactions.add(item);
      }
    }

    return group;
  }

  List<History> groupAll() {
    var historyItem = History(label: "Result", date: DateTime.now(), amount: 0, transactions: []);
    for (var item in this) {
      historyItem.calculate(item);
      historyItem.transactions.add(item);
    }

    var group = <History>[historyItem];
    return group;
  }
}

enum TransactionType { exp, inc, transferIn, transferOut }
