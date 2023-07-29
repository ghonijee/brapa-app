// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:how_much/gen/assets.gen.dart';

class Account {
  final String name;
  final String? assets;
  final int? balance;
  bool? isActive;
  Account({
    required this.name,
    this.assets,
    this.balance = 0,
    this.isActive = true,
  });
}

List<Account> listAccount = [
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
