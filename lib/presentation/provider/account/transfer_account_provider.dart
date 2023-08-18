// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:brapa/data/repository/account_repository.dart';
import 'package:brapa/data/repository/transaction_repository.dart';
import 'package:brapa/data/repository/transfer_log_repository.dart';
import 'package:brapa/domain/account.dart';
import 'package:brapa/domain/category.dart';
import 'package:brapa/domain/transaction.dart';
import 'package:brapa/domain/transfer_log.dart';
import 'package:brapa/gen/injection/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

class TransferAccountState {
  Account? from;
  Account? to;
  int amount;

  TransferAccountState({
    this.from,
    this.to,
    this.amount = 0,
  });

  TransferAccountState copyWith({
    Account? from,
    Account? to,
    int? amount,
  }) {
    return TransferAccountState(
      from: from ?? this.from,
      to: to ?? this.to,
      amount: amount ?? this.amount,
    );
  }
}

class TransferAccountNotifier extends StateNotifier<TransferLog> {
  final AccountRepository repository;
  final TransactionRepository transactionRepository;
  final TransferLogRepository transferLogRepository;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController createdAtController = TextEditingController();
  DateTime? dateSelected;
  TransferAccountNotifier(this.repository, this.transactionRepository, this.transferLogRepository)
      : super(TransferLog());

  initTransfer(Account from) {
    state = state.copyWith(fromAccount: from);
  }

  selectedTargetAccount(Account target) {
    state = state.copyWith(toAccount: target);
  }

  void changeDateTransaction(DateTime date) {
    dateSelected = date;
    createdAtController.text = DateFormat("dd MMMM yyyy").format(date);
    state = state.copyWith(createdAt: dateSelected);
  }

  setAmount(String value) {
    state = state.copyWith(amount: value.toNumber());
  }

  Future<bool> transfer() async {
    // 1. Check Saldo From Account
    if (state.fromAccount!.balance < state.amount!) {
      return false;
    }

    try {
      // From
      state.fromAccount!.decrease(state.amount!);
      await repository.update(state.fromAccount!);
      var expTransaction = Transaction(
        type: TransactionType.transferOut,
        value: state.amount!,
        category: Category.transferOut(),
        account: state.fromAccount!,
        createdAt: dateSelected ?? DateTime.now(),
        memo: "Transfer to ${state.toAccount!.name}",
      );

      // To
      state.toAccount!.increase(state.amount!);
      await repository.update(state.toAccount!);
      var incTransaction = Transaction(
        type: TransactionType.transferIn,
        value: state.amount ?? 0,
        category: Category.transferIn(),
        account: state.toAccount!,
        createdAt: dateSelected ?? DateTime.now(),
        memo: "Transfer from ${state.fromAccount!.name}",
      );

      state = state.copyWith(
        transactionFrom: expTransaction,
        fromId: expTransaction.id,
        toId: incTransaction.id,
        transactionTo: incTransaction,
        createdAt: DateTime.now(),
      );

      await transferLogRepository.store(state);
      reset();
    } catch (e) {
      return false;
    }
    return true;
  }

  void reset() {
    amountController.clear();
    createdAtController.clear();
    state = TransferLog();
  }
}

@injectable
final transferAccountProvider = StateNotifierProvider<TransferAccountNotifier, TransferLog>(
  (ref) => TransferAccountNotifier(
    getIt<AccountRepository>(),
    getIt<TransactionRepository>(),
    getIt<TransferLogRepository>(),
  ),
);
