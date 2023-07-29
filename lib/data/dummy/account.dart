// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  Account(name: "Cash"),
  Account(name: "BCA"),
  Account(name: "BRI"),
  Account(name: "Mandiri"),
  Account(name: "BNI"),
  Account(name: "BSI"),
  Account(name: "Jago"),
  Account(name: "SeaBank"),
  Account(name: "GoPay"),
  Account(name: "OVO"),
  Account(name: "Dana"),
  Account(name: "ShopeePay"),
  Account(name: "BTN"),
];
