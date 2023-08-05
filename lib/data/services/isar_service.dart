import 'package:brapa/data/models/account_model.dart';
import 'package:brapa/data/models/transaction_model.dart';
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
      ],
      directory: dir.path,
    );
    return isar;
  }
}
