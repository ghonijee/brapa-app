import 'package:brapa/data/models/category_model.dart';
import 'package:brapa/data/source/base_local_source.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@injectable
class CategoryLocalSource implements BaseLocalSource<CategoryModel> {
  final Isar isar;
  CategoryLocalSource(this.isar);

  Future<void> clearAll() {
    return isar.categoryModels.clear();
  }

  @override
  Future<List<CategoryModel>> getAll() {
    return isar.categoryModels.where().sortByOrder().findAll();
  }

  @override
  Future<CategoryModel?> store(CategoryModel data) async {
    late int id;
    await isar.writeTxn(() async {
      id = await isar.categoryModels.put(data);
    });
    return isar.categoryModels.get(id);
  }

  @override
  Future<CategoryModel?> update(CategoryModel data) async {
    late int id;

    await isar.writeTxn(() async {
      id = await isar.categoryModels.put(data);
    });
    return isar.categoryModels.get(id);
  }

  @override
  Future<void> delete(CategoryModel data) async {
    await isar.writeTxn(() async {
      isar.categoryModels.filter().idEqualTo(data.id!).deleteFirst();
    });
  }

  Future<List<CategoryModel>> isActiveOnly() {
    return isar.categoryModels.filter().isActiveEqualTo(true).sortByOrder().findAll();
  }
}
