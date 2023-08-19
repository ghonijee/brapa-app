import 'package:brapa/data/commons/data_contanst.dart';
import 'package:brapa/data/models/account_model.dart';
import 'package:brapa/data/models/transaction_model.dart';
import 'package:brapa/data/models/transfer_log_model.dart';
import 'package:brapa/data/services/secure_storage_service.dart';
import 'package:brapa/domain/transaction.dart';
import 'package:brapa/gen/injection/injection.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/category_model.dart';

class IsarService {
  static Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [
        CategoryModelSchema,
        AccountModelSchema,
        TransactionModelSchema,
        TransferLogModelSchema,
      ],
      directory: dir.path,
    );

    await perfomMigration(isar);
    return isar;
  }

  static Future perfomMigration(Isar isar) async {
    final storage = SecureStorageService(getIt<FlutterSecureStorage>());
    final currentDBVersion = await storage.get(DataConstant.dbVersion) ?? "1";
    switch (currentDBVersion) {
      case "1":
        IsarService().migrateTransactionDataV1(isar);
        break;
      default:
        break;
    }

    await storage.set(DataConstant.dbVersion, "2");
  }

  migrateTransactionDataV1(Isar isar) async {
    final countData = await isar.transactionModels.count();
    for (var i = 0; i < countData; i += 50) {
      final transactions = await isar.transactionModels.where().offset(i).limit(50).findAll();
      for (var transaction in transactions) {
        if (transaction.memo!.contains("Transfer from")) {
          transaction.type = TransactionType.transferIn;
        } else if (transaction.memo!.contains("Transfer to")) {
          transaction.type = TransactionType.transferOut;
        }
        await isar.writeTxn(() async {
          await isar.transactionModels.put(transaction);
        });
      }
    }
  }
}
