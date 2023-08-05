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

class ListAccountNotifierProvider extends AsyncNotifier<List<Account>> {
  final AccountRepository repository;

  ListAccountNotifierProvider(this.repository);

  @override
  FutureOr<List<Account>> build() async {
    return await fetchData();
  }

  Future<List<Account>> fetchData() async {
    var result = await repository.getAll();
    return result.fold((left) {
      return <Account>[];
    }, (right) => right);
  }
}

final listAccountProvider = AsyncNotifierProvider<ListAccountNotifierProvider, List<Account>>(
  () => ListAccountNotifierProvider(getIt<AccountRepository>()),
);
