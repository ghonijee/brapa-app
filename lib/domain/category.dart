class Category {
  final int? id;
  final String name;

  final CategoryType categoryType;

  final bool? isActive;

  final int? order;

  Category(
      {required this.name,
      required this.categoryType,
      this.id,
      this.isActive,
      this.order});

  bool isExpense() => categoryType == CategoryType.exp;
  bool isIncome() => categoryType == CategoryType.inc;
}

enum CategoryType { exp, inc }

extension CategoryExtension on List<Category> {
  List<Category> expenseList() => where((e) => e.isExpense()).toList();
  List<Category> incomeList() => where((e) => e.isIncome()).toList();
}

List<Category> initListCategory = [
  Category(
      categoryType: CategoryType.exp,
      name: "Housing",
      isActive: true,
      order: 1),
  Category(
      categoryType: CategoryType.exp, name: "Bill", isActive: true, order: 2),
  Category(
      categoryType: CategoryType.exp,
      name: "Transport",
      isActive: true,
      order: 3),
  Category(
      categoryType: CategoryType.exp,
      name: "Supplies",
      isActive: true,
      order: 4),
  Category(
      categoryType: CategoryType.exp,
      name: "Entertainment",
      isActive: true,
      order: 5),
  Category(
      categoryType: CategoryType.exp,
      name: "Health Care",
      isActive: true,
      order: 6),
  Category(
      categoryType: CategoryType.exp,
      name: "Personal Care",
      isActive: true,
      order: 7),
  Category(
      categoryType: CategoryType.exp, name: "Gift", isActive: true, order: 8),
  Category(
      categoryType: CategoryType.exp,
      name: "Donation",
      isActive: true,
      order: 9),
  Category(
      categoryType: CategoryType.exp,
      name: "Food & Drinks",
      isActive: true,
      order: 10),
  Category(
      categoryType: CategoryType.exp, name: "Other", isActive: true, order: 11),
  Category(
      name: "Salary", categoryType: CategoryType.inc, isActive: true, order: 1),
  Category(
      name: "Commissions",
      categoryType: CategoryType.inc,
      isActive: true,
      order: 1),
  Category(
      name: "Gift", categoryType: CategoryType.inc, isActive: true, order: 1),
  Category(
      name: "Sell", categoryType: CategoryType.inc, isActive: true, order: 1),
  Category(
      name: "Investment",
      categoryType: CategoryType.inc,
      isActive: true,
      order: 1),
];
