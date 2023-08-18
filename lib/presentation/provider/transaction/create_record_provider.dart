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

class CreateRecordNotifier extends ChangeNotifier {
  Account? accountSelected;
  Category? categorySelected;
  late Transaction transaction;
  DateTime? createdAt;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController memoController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  int segmentedControllerGroupValue = 0;
  final FocusNode focusNode = FocusNode();

  final TransactionRepository repository;
  final AccountRepository accountRepository;

  CreateRecordNotifier(
    this.repository,
    this.accountRepository,
  );

  void selectedAccount(Account item) {
    accountSelected = item;
    notifyListeners();
  }

  void selectedCategory(Category item) {
    categorySelected = item;
    notifyListeners();
  }

  void changeDateTransaction(DateTime date) {
    createdAt = date;
    dateController.text = DateFormat("dd MMMM yyyy").format(date);
    notifyListeners();
  }

  void changeSegmentedControlValue(int value) {
    segmentedControllerGroupValue = value;
    notifyListeners();
  }

  Future<void> save() async {
    try {
      var transaction = Transaction(
        type: segmentedControllerGroupValue == 0 ? TransactionType.exp : TransactionType.inc,
        value: amountController.text.toNumber() ?? 0,
        memo: memoController.text,
        category: categorySelected!,
        createdAt: createdAt ?? DateTime.now(),
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
    dateController.clear();
    notifyListeners();
  }
}

@injectable
final createRecordProvider = ChangeNotifierProvider((ref) => CreateRecordNotifier(
      getIt<TransactionRepository>(),
      getIt<AccountRepository>(),
    ));
