import 'package:brapa/data/models/account_model.dart';
import 'package:brapa/data/models/transaction_model.dart';
import 'package:brapa/domain/transfer_log.dart';
import 'package:isar/isar.dart';

part 'transfer_log_model.g.dart';

@collection
class TransferLogModel {
  Id? id;
  int? fromId;
  int? toId;
  DateTime? createdAt;
  int? amount;

  final fromAccount = IsarLink<AccountModel>();
  final toAccount = IsarLink<AccountModel>();
  final transactionFrom = IsarLink<TransactionModel>();
  final transactionTo = IsarLink<TransactionModel>();

  TransferLogModel();

  factory TransferLogModel.fromDomain(TransferLog data) => TransferLogModel()
    ..id = data.id
    ..fromId = data.fromId
    ..toId = data.toId
    ..createdAt = data.createdAt
    ..amount = data.amount
    ..fromAccount.value = AccountModel.fromDomain(data.fromAccount!)
    ..toAccount.value = AccountModel.fromDomain(data.toAccount!)
    ..transactionFrom.value = TransactionModel.fromDomain(data.transactionFrom!)
    ..transactionTo.value = TransactionModel.fromDomain(data.transactionTo!);

  TransferLog toDomain() => TransferLog(
        id: id,
        createdAt: createdAt,
        fromId: fromId,
        toId: toId,
        amount: amount!,
        fromAccount: fromAccount.value!.toDomain(),
        toAccount: toAccount.value!.toDomain(),
        transactionFrom: transactionFrom.value!.toDomain(),
        transactionTo: transactionTo.value!.toDomain(),
      );
}

extension TransferLogModelExt on List<TransferLogModel> {
  List<TransferLog> toDomaiList() => map((e) => e.toDomain()).toList();
}
