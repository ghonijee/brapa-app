// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:how_much/gen/assets.gen.dart';

class Account {
  final int? id;
  final String name;
  final String? assets;
  int? balance;
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
    balance = balance! - value;
  }

  increase(int value) {
    balance = balance! + value;
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
    return id.hashCode ^ name.hashCode ^ assets.hashCode ^ balance.hashCode ^ order.hashCode ^ isActive.hashCode;
  }
}

extension AccountExtension on List<Account> {
  num? countValue() {
    num sum = 0;
    for (var item in this) {
      sum += item.balance ?? 0;
    }
    return sum;
  }
}

List<Account> initListAccount = [
  Account(name: "Cash", assets: Assets.bank.otherAcount.path),
  Account(name: "BCA", assets: Assets.bank.bca.path),
  Account(name: "BRI", assets: Assets.bank.bri.path),
  Account(name: "Mandiri", assets: Assets.bank.mandiri.path),
  Account(name: "BNI", assets: Assets.bank.bni.path),
  Account(name: "BSI", assets: Assets.bank.bankSyariahIndonesia.path),
  Account(name: "Jago", assets: Assets.bank.jago.path),
  Account(name: "SeaBank", assets: Assets.bank.otherAcountAlt.path),
  Account(name: "GoPay", assets: Assets.ewallet.gopayPng.path),
  Account(name: "OVO", assets: Assets.ewallet.ovoPng.path),
  Account(name: "Dana", assets: Assets.ewallet.danaPng.path),
  Account(name: "ShopeePay", assets: Assets.ewallet.shopeepayPng.path),
  Account(name: "BTN", assets: Assets.bank.btn.path),
];
