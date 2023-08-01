import 'package:how_much/data/source/base_local_source.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import '../models/account_model.dart';

@injectable
class AccountLocalSource implements BaseLocalSource<AccountModel> {
  final Isar isar;
  AccountLocalSource(this.isar);

  @override
  Future<void> delete(AccountModel data) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<AccountModel>> getAll() {
    return isar.accountModels.where().findAll();
  }

  @override
  Future<AccountModel?> store(AccountModel data) async {
    late int id;
    await isar.writeTxn(() async {
      id = await isar.accountModels.put(data);
    });

    return isar.accountModels.get(id);
  }

  @override
  Future<void> update(AccountModel data) async {
    late int id;

    await isar.writeTxn(() async {
      id = await isar.accountModels.put(data);
    });
  }
}
