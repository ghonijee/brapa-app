import 'package:how_much/data/source/base_local_source.dart';
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

  @override
  Future<List<TransactionModel>> getAll() {
    return isar.transactionModels.where().findAll();
  }

  @override
  Future<TransactionModel?> store(TransactionModel data) async {
    late int id;
    await isar.writeTxn(() async {
      id = await isar.transactionModels.put(data);
    });

    return isar.transactionModels.get(id);
  }

  @override
  Future<void> update(TransactionModel data) async {
    isar.writeTxn(() async {
      await isar.transactionModels.put(data);
    });
  }
}
