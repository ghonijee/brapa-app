import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:brapa/data/repository/transaction_repository.dart';
import 'package:brapa/domain/account.dart';
import 'package:brapa/domain/transaction.dart';
import 'package:brapa/gen/injection/injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AsyncListHistoryTransaction extends AsyncNotifier<List<Transaction>> {
  final TransactionRepository repository = getIt<TransactionRepository>();
  Debouncer? debounce = Debouncer(milliseconds: 1100);

  @override
  FutureOr<List<Transaction>> build() async {
    return _getData();
  }

  Future<List<Transaction>> _getData() async {
    // state = const AsyncValue.loading();
    var result = await repository.getAll();
    return result.fold((left) {
      return <Transaction>[];
    }, (right) {
      return right;
    });
  }

  Future<void> find(String keyword) async {
    debounce!.run(() async {
      state = const AsyncValue.loading();
      var result = await repository.searchAll(keyword: keyword);
      result.fold((left) {
        // return <Transaction>[];
      }, (right) {
        state = AsyncValue.data(right);
      });
    });
  }

  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _getData();
    });
    print(state.asData?.value.first.account.name.toString());
  }
}

final asyncListHistory = AsyncNotifierProvider<AsyncListHistoryTransaction, List<Transaction>>(
  () => AsyncListHistoryTransaction(),
);




// final getListTransactionProvider = FutureProvider((ref) async {
//   final TransactionRepository repository = getIt<TransactionRepository>();
//   var result = await repository.getAll();
//   return result.fold((left) {
//     return <Transaction>[];
//   }, (right) {
//     return right;
//   });
// });