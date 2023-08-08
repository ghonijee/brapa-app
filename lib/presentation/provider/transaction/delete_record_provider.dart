import 'dart:developer';

import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brapa/data/repository/account_repository.dart';
import 'package:brapa/data/repository/transaction_repository.dart';
import 'package:brapa/domain/category.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../../domain/account.dart';
import '../../../domain/transaction.dart';
import '../../../gen/injection/injection.dart';

class DeleteRecordNotifier extends ChangeNotifier {
  final TransactionRepository repository;
  final AccountRepository accountRepository;
  late Transaction transaction;

  DeleteRecordNotifier(
    this.repository,
    this.accountRepository,
  );

  rollbackAccountBalance() async {
    if (transaction.type == TransactionType.exp) {
      transaction.account.increase(transaction.value);
    } else {
      transaction.account.decrease(transaction.value);
    }
    await accountRepository.update(transaction.account);
  }

  Future<void> delete(Transaction item) async {
    transaction = item;
    try {
      await rollbackAccountBalance();
      await repository.destroy(item);
    } catch (e, s) {
      log("Error Save", error: e, stackTrace: s);
    }
  }
}

@injectable
final deleteRecordProvider = ChangeNotifierProvider(
  (ref) => DeleteRecordNotifier(
    getIt<TransactionRepository>(),
    getIt<AccountRepository>(),
  ),
);
