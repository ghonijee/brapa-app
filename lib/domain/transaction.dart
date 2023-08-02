// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_ui/app_ui.dart';
import 'package:fpdart/fpdart.dart';
import 'package:how_much/domain/category.dart';
import 'package:intl/intl.dart';
import 'package:moment_dart/moment_dart.dart';

import 'account.dart';
import 'history.dart';

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

  bool isExpense() => type == TransactionType.exp;
  bool isIncome() => type == TransactionType.inc;
}

extension TransactionExtension on List<Transaction> {
  List<History> groupDaily() {
    var group = <History>[];
    for (var item in this) {
      var indexGroup = group.indexWhere(
          (element) => element.date.eqvYearMonthDay(item.createdAt!));
      if (indexGroup < 0) {
        var historyItem = History(
            label: item.createdAt!.isToday()
                ? "Today"
                : DateFormat("dd MMMM yy").format(item.createdAt!),
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

  groupMonthly() {
    var group = <History>[];
    for (var item in this) {
      var indexGroup = group.indexWhere((element) =>
          element.date.eqvMonth(item.createdAt!) &&
          element.date.eqvYear(item.createdAt!));
      if (indexGroup < 0) {
        group.add(History(
            label: DateFormat.yMMMM().format(item.createdAt!),
            date: item.createdAt!,
            amount: item.value,
            transactions: [item]));
      } else {
        var itemGroup = group[indexGroup];
        group[indexGroup].amount = itemGroup.amount + item.value;
        group[indexGroup].transactions.add(item);
      }
    }

    return group;
  }
}

enum TransactionType { exp, inc }
