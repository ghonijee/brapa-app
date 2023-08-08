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

class UpdateRecordNotifier extends ChangeNotifier {
  Account? accountSelected;
  Category? categorySelected;
  DateTime? dateSelected;
  late Transaction transaction;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController memoController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  int segmentedControllerGroupValue = 0;
  final FocusNode focusNode = FocusNode();

  final TransactionRepository repository;
  final AccountRepository accountRepository;

  UpdateRecordNotifier(
    this.repository,
    this.accountRepository,
  );

  void loadTransaction(Transaction item) {
    transaction = item;
    accountSelected = item.account;
    categorySelected = item.category;
    dateSelected = item.createdAt;
    dateController.text = DateFormat("dd MMMM yyyy").format(transaction.createdAt!);
    amountController.text = transaction.value.toThousandSeparator();
    memoController.text = transaction.memo ?? "";
    notifyListeners();
  }

  rollbackAccountBalance() async {
    if (transaction.type == TransactionType.exp) {
      transaction.account.increase(transaction.value);
    } else {
      transaction.account.decrease(transaction.value);
    }
    await accountRepository.update(transaction.account);
  }

  Future<void> save() async {
    try {
      await rollbackAccountBalance();

      transaction = transaction.copyWith(
        value: amountController.text.toNumber() ?? 0,
        category: categorySelected!,
        account: accountSelected!,
        memo: memoController.text,
        createdAt: dateSelected,
      );

      await repository.update(transaction).then((value) {
        if (transaction.type == TransactionType.exp) {
          accountSelected?.decrease(transaction.value);
        } else {
          accountSelected?.increase(transaction.value);
        }
        accountRepository.update(accountSelected!);
      });

      reset();
    } catch (e, s) {
      log("Error Save", error: e, stackTrace: s);
    }
  }

  void reset() {
    accountSelected = null;
    categorySelected = null;
    amountController.clear();
    memoController.clear();
    notifyListeners();
  }
}

@injectable
final updateRecordProvider = ChangeNotifierProvider((ref) => UpdateRecordNotifier(
      getIt<TransactionRepository>(),
      getIt<AccountRepository>(),
    ));
