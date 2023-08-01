class Category {
  final int? id;
  final String name;

  final bool? isActive;

  final int? order;

  Category({required this.name, this.id, this.isActive, this.order});
}

List<Category> initListCategory = [
  Category(name: "Housing", isActive: true, order: 1),
  Category(name: "Bill", isActive: true, order: 2),
  Category(name: "Transport", isActive: true, order: 3),
  Category(name: "Supplies", isActive: true, order: 4),
  Category(name: "Entertainment", isActive: true, order: 5),
  Category(name: "Health Care", isActive: true, order: 6),
  Category(name: "Personal Care", isActive: true, order: 7),
  Category(name: "Gift", isActive: true, order: 8),
  Category(name: "Donation", isActive: true, order: 9),
  Category(name: "Food & Drinks", isActive: true, order: 10),
  Category(name: "Other", isActive: true, order: 11),
];
