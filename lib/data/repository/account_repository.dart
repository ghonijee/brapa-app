import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/account.dart';
import '../models/account_model.dart';
import '../source/account_local_source.dart';

@injectable
class AccountRepository {
  final AccountLocalSource localSource;
  AccountRepository(this.localSource);

  Future<Either<String, bool>> initialData() async {
    try {
      for (var data in initListAccount) {
        var item = AccountModel()
          ..name = data.name
          ..isActive = true
          ..balance = 0
          ..assets = data.assets
          ..order = data.order;

        localSource.store(item);
      }

      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Account>>> getAll({bool isActiveOnly = false}) async {
    try {
      var result = isActiveOnly ? await localSource.isActiveOnly() : await localSource.getAll();
      if (result.isEmpty) {
        await initialData();
        result = await localSource.getAll();
      }
      return Right(result.toDomaiList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> update(Account data) async {
    try {
      await localSource.update(AccountModel.fromDomain(data));
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Account>> store(Account data) async {
    try {
      var result = await localSource.store(AccountModel.fromDomain(data));
      return Right(result!.toDomain());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> destroy(Account data) async {
    try {
      await localSource.delete(AccountModel.fromDomain(data));
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
