import 'package:how_much/data/repository/transaction_repository.dart';
import 'package:how_much/domain/transaction.dart';
import 'package:how_much/gen/injection/injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final getListTransactionProvider = FutureProvider((ref) async {
  final TransactionRepository repository = getIt<TransactionRepository>();
  var result = await repository.getAll();
  return result.fold((left) {
    return <Transaction>[];
  }, (right) {
    return right;
  });
});
