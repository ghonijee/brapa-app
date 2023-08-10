// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:brapa/gen/assets.gen.dart';

class Account {
  final int? id;
  final String name;
  final String? assets;
  int balance;
  final int? order;
  bool? isActive;
  Account({
    this.id,
    required this.name,
    this.assets,
    this.balance = 0,
    this.order,
    this.isActive = true,
  });

  decrease(int value) {
    balance = balance - value;
  }

  increase(int value) {
    balance = balance + value;
  }

  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.assets == assets &&
        other.balance == balance &&
        other.order == order &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        assets.hashCode ^
        balance.hashCode ^
        order.hashCode ^
        isActive.hashCode;
  }

  Account copyWith({
    int? id,
    String? name,
    String? assets,
    int? balance,
    int? order,
    bool? isActive,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      assets: assets ?? this.assets,
      balance: balance ?? this.balance,
      order: order ?? this.order,
      isActive: isActive ?? this.isActive,
    );
  }
}

extension AccountExtension on List<Account> {
  num? countValue() {
    num sum = 0;
    for (var item in this) {
      sum += item.balance;
    }
    return sum;
  }

  List<Account> except(Account item) {
    return where((element) => element.id != item.id).toList();
  }
}

List<Account> initListAccount = [
  Account(name: "Cash", assets: Assets.accounts.walletAltGreen.path),
  Account(name: "BCA", assets: Assets.accounts.bankBlue.path),
  Account(name: "BRI", assets: Assets.accounts.bankBlue.path),
  Account(name: "Mandiri", assets: Assets.accounts.bankPrimary.path),
];
