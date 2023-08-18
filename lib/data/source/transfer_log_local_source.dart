import 'package:brapa/data/models/transaction_model.dart';
import 'package:brapa/data/source/base_local_source.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import '../models/transfer_log_model.dart';

@injectable
class TransferLogLocalSource implements BaseLocalSource<TransferLogModel> {
  final Isar isar;
  TransferLogLocalSource(this.isar);

  @override
  Future<void> delete(TransferLogModel data) async {
    await isar.writeTxn(() async {
      isar.transferLogModels.filter().idEqualTo(data.id!).deleteFirst();
      isar.transactionModels.deleteAll([data.transactionFrom.value!.id!, data.transactionTo.value!.id!]);
      // data.transactionFrom
    });
  }

  Future<void> clearAll() async {
    await isar.writeTxn(() async {
      isar.transferLogModels.clear();
    });
  }

  Future<TransferLogModel?> find({required int id}) async {
    var query = await isar.transferLogModels
        .filter()
        .transactionFrom((q) => q.idEqualTo(id))
        .or()
        .transactionTo((q) => q.idEqualTo(id))
        .findFirst();
    return query;
  }

  @override
  Future<List<TransferLogModel>> getAll() {
    return isar.transferLogModels.where().sortByCreatedAtDesc().findAll();
  }

  @override
  Future<TransferLogModel?> store(TransferLogModel data) async {
    late int id;
    isar.writeTxnSync(() {
      id = isar.transferLogModels.putSync(data);
      data.transactionFrom.save();
      data.transactionTo.save();
    });
    return isar.transferLogModels.get(id);
  }

  @override
  Future<void> update(TransferLogModel data) async {
    await isar.writeTxn(() async {
      await isar.transferLogModels.put(data);
      await isar.transactionModels.putAll([data.transactionFrom.value!, data.transactionTo.value!]);
    });
  }
}
