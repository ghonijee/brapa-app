import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_much/data/repository/account_repository.dart';
import 'package:how_much/data/repository/transaction_repository.dart';
import 'package:how_much/domain/category.dart';

import '../../../domain/account.dart';
import '../../../domain/transaction.dart';
import '../../../gen/injection/injection.dart';

class UpdateRecordNotifier extends ChangeNotifier {
  Account? accountSelected;
  Category? categorySelected;
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
  }

  Future<void> save() async {
    try {
      transaction = transaction.copyWith(
        value: amountController.text.toNumber() ?? 0,
        memo: memoController.text,
        category: categorySelected!,
        createdAt: DateTime.now(),
        account: accountSelected!,
      );

      await repository.store(transaction).then((value) {
        if (transaction.type == TransactionType.exp) {
          accountSelected?.decrease(transaction.value);
        } else {
          accountSelected?.increase(transaction.value);
        }
        accountRepository.update(accountSelected!);
      });

      reset();
    } catch (e) {
      //
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

final updateRecordProvider = ChangeNotifierProvider((ref) => UpdateRecordNotifier(
      getIt<TransactionRepository>(),
      getIt<AccountRepository>(),
    ));
