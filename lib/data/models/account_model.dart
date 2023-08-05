// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brapa/domain/account.dart';
import 'package:isar/isar.dart';

part 'account_model.g.dart';

@collection
class AccountModel {
  Id? id;
  String? name;
  String? assets;
  int? balance;
  int? order;
  bool? isActive;

  AccountModel({
    this.id,
    this.name,
    this.assets,
    this.balance,
    this.order,
    this.isActive,
  });

  factory AccountModel.fromDomain(Account data) => AccountModel(
        id: data.id,
        name: data.name,
        balance: data.balance,
        isActive: data.isActive,
        order: data.order,
        assets: data.assets,
      );

  Account toDomain() => Account(
        name: name!,
        id: id,
        balance: balance,
        order: order,
        isActive: isActive,
        assets: assets,
      );
}

extension AccountModelExt on List<AccountModel> {
  toDomaiList() => map(
        (e) => Account(
          name: e.name!,
          id: e.id,
          isActive: e.isActive,
          order: e.order,
          assets: e.assets,
          balance: e.balance,
        ),
      ).toList();
}
