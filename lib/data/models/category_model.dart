// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

import '../../domain/category.dart';

part 'category_model.g.dart';

@collection
class CategoryModel {
  Id? id;

  String? name;

  @enumerated
  final CategoryType categoryType;

  bool? isActive;

  int? order;

  CategoryModel({
    this.id,
    this.name,
    required this.categoryType,
    this.isActive,
    this.order,
  });

  factory CategoryModel.fromDomain(Category data) => CategoryModel(
        id: data.id,
        name: data.name,
        categoryType: data.categoryType,
        isActive: data.isActive,
        order: data.order,
      );

  toDomain() => Category(
        id: id,
        name: name!,
        categoryType: categoryType,
        isActive: isActive,
        order: order,
      );
}

extension CategoryModelExt on List<CategoryModel> {
  toDomaiList() => map(
        (e) => Category(
          categoryType: e.categoryType,
          name: e.name!,
          id: e.id,
          isActive: e.isActive,
          order: e.order,
        ),
      ).toList();
}
