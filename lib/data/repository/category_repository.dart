import 'package:fpdart/fpdart.dart';
import 'package:how_much/data/models/category_model.dart';
import 'package:how_much/data/source/category_local_source.dart';
import 'package:how_much/domain/category.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoryRepository {
  final CategoryLocalSource localSource;
  CategoryRepository(this.localSource);

  Future<Either<String, bool>> initialData() async {
    try {
      for (var data in initListCategory) {
        var item = CategoryModel.fromDomain(data);
        localSource.store(item);
      }

      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Category>>> getAll({bool isActiveOnly = false}) async {
    try {
      var result = isActiveOnly ? await localSource.isActiveOnly() : await localSource.getAll();
      if (result.isEmpty) {
        await initialData();
        result = await localSource.getAll();
      }
      return Right(result.toDomaiList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> update(Category data) async {
    try {
      var account = await localSource.update(CategoryModel.fromDomain(data));
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, Category>> store(Category data) async {
    try {
      var result = await localSource.store(CategoryModel.fromDomain(data));
      print(result?.name);
      return Right(result!.toDomain());
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> destroy(Category data) async {
    try {
      var result = await localSource.delete(CategoryModel.fromDomain(data));
      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
