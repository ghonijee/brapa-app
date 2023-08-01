// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

import '../../domain/category.dart';

part 'category_model.g.dart';

@collection
class CategoryModel {
  Id? id;

  String? name;

  bool? isActive;

  int? order;

  CategoryModel({
    this.id,
    this.name,
    this.isActive,
    this.order,
  });
}

extension CategoryModelExt on List<CategoryModel> {
  toDomaiList() => map(
        (e) => Category(
          name: e.name!,
          id: e.id,
          isActive: e.isActive,
          order: e.order,
        ),
      ).toList();
}
