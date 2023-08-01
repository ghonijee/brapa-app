// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:how_much/data/models/account_model.dart';
import 'package:how_much/data/models/category_model.dart';
import 'package:isar/isar.dart';

import '../../domain/transaction.dart';

part 'transaction_model.g.dart';

@collection
class TransactionModel {
  Id? id;

  @enumerated
  late TransactionType type;

  int? value;

  String? memo;

  DateTime? createdAt;
  final category = IsarLink<CategoryModel>();

  final account = IsarLink<AccountModel>();

  TransactionModel();

  factory TransactionModel.fromDomain(Transaction data) => TransactionModel()
    ..id = data.id
    ..type = data.type
    ..value = data.value
    ..memo = data.memo
    ..createdAt = data.createdAt
    ..account.value = AccountModel.fromDomain(data.account)
    ..category.value = CategoryModel.fromDomain(data.category);

  Transaction toDomain() => Transaction(
        id: id,
        type: type,
        value: value ?? 0,
        memo: memo,
        createdAt: createdAt,
        account: account.value!.toDomain(),
        category: category.value!.toDomain(),
      );
}

extension TransactionModelExt on List<TransactionModel> {
  toDomaiList() => map((e) => e.toDomain()).toList();
}
