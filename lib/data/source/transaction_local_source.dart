import 'package:brapa/data/models/account_model.dart';
import 'package:brapa/data/models/category_model.dart';
import 'package:brapa/data/source/base_local_source.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import '../models/transaction_model.dart';

@injectable
class TransactionLocalSource implements BaseLocalSource<TransactionModel> {
  final Isar isar;
  TransactionLocalSource(this.isar);

  @override
  Future<void> delete(TransactionModel data) async {
    await isar.writeTxn(() async {
      isar.transactionModels.filter().idEqualTo(data.id!).deleteFirst();
    });
  }

  Future<void> clearAll() async {
    await isar.writeTxn(() async {
      isar.transactionModels.clear();
    });
  }

  Future<List<TransactionModel>> findAll({String keyword = ''}) {
    var query = isar.transactionModels
        .filter()
        .memoContains(keyword, caseSensitive: false)
        .or()
        .category((q) => q.nameContains(keyword, caseSensitive: false))
        .or()
        .account((q) => q.nameContains(keyword, caseSensitive: false))
        .findAll();
    return query;
  }

  @override
  Future<List<TransactionModel>> getAll() {
    return isar.transactionModels.where().sortByCreatedAtDesc().findAll();
  }

  @override
  Future<TransactionModel?> store(TransactionModel data) async {
    late int id;
    isar.writeTxnSync(() {
      id = isar.transactionModels.putSync(data);
      data.account.save();
      data.category.save();
    });
    return isar.transactionModels.get(id);
  }

  @override
  Future<void> update(TransactionModel data) async {
    await isar.writeTxn(() async {
      await isar.transactionModels.put(data);
      await data.account.save();
      await data.category.save();
    });
  }
}
