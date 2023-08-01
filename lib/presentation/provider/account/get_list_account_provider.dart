import 'package:how_much/data/repository/account_repository.dart';
import 'package:how_much/domain/account.dart';
import 'package:how_much/gen/injection/injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final getListAccountProvider = FutureProvider((ref) async {
  final AccountRepository repository = getIt<AccountRepository>();
  var result = await repository.getAll();
  return result.fold((left) {
    return <Account>[];
  }, (right) => right);
});
