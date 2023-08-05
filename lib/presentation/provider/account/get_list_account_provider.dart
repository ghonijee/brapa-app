import 'package:brapa/data/repository/account_repository.dart';
import 'package:brapa/domain/account.dart';
import 'package:brapa/gen/injection/injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final getListAccountProvider = FutureProvider((ref) async {
  final AccountRepository repository = getIt<AccountRepository>();
  var result = await repository.getAll(isActiveOnly: true);
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

  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await fetchData();
    });
  }
}

final listAccountProvider = AsyncNotifierProvider<ListAccountNotifierProvider, List<Account>>(
  () => ListAccountNotifierProvider(getIt<AccountRepository>()),
);
