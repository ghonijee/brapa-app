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
        var item = CategoryModel()
          ..name = data.name
          ..isActive = true
          ..order = data.order;
        localSource.store(item);
      }

      return const Right(true);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<Category>>> getAll() async {
    try {
      var result = await localSource.getAll();
      return Right(result.toDomaiList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  update() {
    //
  }

  store() {
    //
  }

  destroy() {
    //
  }
}
