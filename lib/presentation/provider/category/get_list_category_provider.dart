import 'package:how_much/data/repository/category_repository.dart';
import 'package:how_much/gen/injection/injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final getListCategoryProvider = FutureProvider((ref) async {
  final CategoryRepository repository = getIt<CategoryRepository>();
  var result = await repository.getAll();
  result.fold((left) {
    //
  }, (right) async {
    if (right.isEmpty) {
      repository.initialData();
      result = await repository.getAll();
    }
  });
  return result.getRight().toNullable();
});
