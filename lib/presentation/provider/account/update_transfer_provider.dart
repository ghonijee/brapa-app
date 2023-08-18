import 'dart:developer';

import 'package:app_ui/app_ui.dart';
import 'package:brapa/data/repository/transfer_log_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brapa/data/repository/account_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../../domain/account.dart';
import '../../../domain/transaction.dart';
import '../../../domain/transfer_log.dart';
import '../../../gen/injection/injection.dart';

class UpdateTransferNotifier extends AutoDisposeNotifier<TransferLog> {
  Account? accountFromSelected;
  Account? accountToSelected;
  DateTime? dateSelected;
  TransferLog? oldTransferLog;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  int segmentedControllerGroupValue = 0;
  final FocusNode focusNode = FocusNode();

  final AccountRepository accountRepository;
  final TransferLogRepository transferLogRepository;

  UpdateTransferNotifier(
    this.accountRepository,
    this.transferLogRepository,
  );

  void changeDateTransaction(DateTime date) {
    dateSelected = date;
    dateController.text = DateFormat("dd MMMM yyyy").format(date);
    state = state.copyWith(createdAt: dateSelected);
  }

  setAccountFrom(Account from) {
    state = state.copyWith(fromAccount: from);
  }

  setAccountTo(Account to) {
    state = state.copyWith(toAccount: to);
  }

  setAmount(String value) {
    state = state.copyWith(amount: value.toNumber());
  }

  Future<void> loadTransfer(Transaction item) async {
    var result = await transferLogRepository.findByTransactionId(id: item.id!);
    state = result.fold((error) => TransferLog(), (item) => item);
    oldTransferLog = state;

    accountFromSelected = state.fromAccount;
    accountToSelected = state.toAccount;
    dateController.text = DateFormat("dd MMMM yyyy").format(state.createdAt ?? DateTime.now());
    amountController.text = state.amount!.toThousandSeparator();
  }

  rollbackAccountBalance() async {
    //  Rollback from Account
    state.fromAccount!.increase(oldTransferLog!.amount ?? 0);
    await accountRepository.update(oldTransferLog!.fromAccount!);
    //  Rollback target Account
    state.toAccount!.decrease(oldTransferLog!.amount ?? 0);
    await accountRepository.update(oldTransferLog!.toAccount!);
  }

  Future<bool> transfer() async {
    // 1. Check Saldo From Account
    if (state.fromAccount!.balance < state.amount!) {
      return false;
    }

    try {
      // From
      state.fromAccount!.decrease(state.amount!);
      await accountRepository.update(state.fromAccount!);
      var expTransaction = state.transactionFrom!.copyWith(
        value: amountController.text.toNumber(),
        createdAt: dateSelected,
      );

      // To
      state.toAccount!.increase(state.amount!);
      await accountRepository.update(state.toAccount!);
      var incTransaction = state.transactionTo!.copyWith(
        value: amountController.text.toNumber(),
        createdAt: dateSelected,
      );

      state = state.copyWith(
        transactionFrom: expTransaction,
        fromId: expTransaction.id,
        transactionTo: incTransaction,
        toId: incTransaction.id,
      );
    } catch (e) {
      return false;
    }
    return true;
  }

  Future<void> save() async {
    try {
      await rollbackAccountBalance();

      await transfer();

      await transferLogRepository.update(state);

      reset();
    } catch (e, s) {
      log("Error Save", error: e, stackTrace: s);
    }
  }

  Future<void> delete() async {
    try {
      await rollbackAccountBalance();
      await transferLogRepository.destroy(state);
    } catch (e, s) {
      log("Error Save", error: e, stackTrace: s);
    }
  }

  void reset() {
    amountController.clear();
    dateController.clear();
    accountFromSelected = null;
    accountToSelected = null;
  }

  @override
  TransferLog build() {
    return TransferLog();
  }
}

@injectable
final updateTransferProvider =
    AutoDisposeNotifierProvider<UpdateTransferNotifier, TransferLog>(() => UpdateTransferNotifier(
          getIt<AccountRepository>(),
          getIt<TransferLogRepository>(),
        ));
