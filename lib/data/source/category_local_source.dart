import 'package:how_much/data/models/category_model.dart';
import 'package:how_much/data/source/base_local_source.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

@injectable
class CategoryLocalSource implements BaseLocalSource<CategoryModel> {
  final Isar isar;
  CategoryLocalSource(this.isar);

  @override
  Future<void> delete(CategoryModel data) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> clearAll() {
    return isar.categoryModels.clear();
  }

  @override
  Future<List<CategoryModel>> getAll() {
    return isar.categoryModels.where().sortByOrder().findAll();
  }

  @override
  Future<void> store(CategoryModel data) async {
    isar.writeTxn(() async {
      await isar.categoryModels.put(data);
    });
  }

  @override
  Future<void> update(CategoryModel data) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
