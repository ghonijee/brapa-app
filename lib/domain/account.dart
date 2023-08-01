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
  Account(name: "BCA", assets: Assets.bank.bcaPng.path),
  Account(name: "BRI", assets: Assets.bank.briPng.path),
  Account(name: "Mandiri", assets: Assets.bank.mandiriPng.path),
  Account(name: "BNI", assets: Assets.bank.bniPng.path),
  Account(name: "BSI", assets: Assets.bank.bankSyariahIndonesiaPng.path),
  Account(name: "Jago", assets: Assets.bank.jagoPng.path),
  Account(name: "SeaBank", assets: Assets.bank.otherAcountAlt.path),
  Account(name: "GoPay", assets: Assets.ewallet.gopayPng.path),
  Account(name: "OVO", assets: Assets.ewallet.ovoPng.path),
  Account(name: "Dana", assets: Assets.ewallet.danaPng.path),
  Account(name: "ShopeePay", assets: Assets.ewallet.shopeepayPng.path),
  Account(name: "BTN", assets: Assets.bank.btnPng.path),
];
