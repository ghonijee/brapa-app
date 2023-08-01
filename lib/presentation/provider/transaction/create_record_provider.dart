import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_much/data/repository/account_repository.dart';
import 'package:how_much/data/repository/transaction_repository.dart';
import 'package:how_much/domain/category.dart';

import '../../../domain/account.dart';
import '../../../domain/transaction.dart';
import '../../../gen/injection/injection.dart';

class CreateRecordNotifier extends ChangeNotifier {
  Account? accountSelected;
  Category? categorySelected;
  late Transaction transaction;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController memoController = TextEditingController();
  int segmentedControllerGroupValue = 0;
  final FocusNode focusNode = FocusNode();

  final TransactionRepository repository;
  final AccountRepository accountRepository;

  CreateRecordNotifier(
    this.repository,
    this.accountRepository,
  );

  Future<void> save() async {
    try {
      var transaction = Transaction(
        type: segmentedControllerGroupValue == 0
            ? TransactionType.exp
            : TransactionType.inc,
        value: amountController.text.toNumber() ?? 0,
        memo: memoController.text,
        category: categorySelected!,
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

final createRecordProvider =
    ChangeNotifierProvider((ref) => CreateRecordNotifier(
          getIt<TransactionRepository>(),
          getIt<AccountRepository>(),
        ));
