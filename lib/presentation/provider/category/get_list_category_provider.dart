import 'package:how_much/data/repository/category_repository.dart';
import 'package:how_much/domain/category.dart';
import 'package:how_much/gen/injection/injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final getListCategoryProvider = FutureProvider((ref) async {
  final CategoryRepository repository = getIt<CategoryRepository>();
  var result = await repository.getAll();
  return result.fold((left) {
    return <Category>[];
  }, (right) => right);
});

// final expCategoriesProvider = Provider<List<Category>>((ref) {
//   final categoriesProvider = ref.watch(getListCategoryProvider);
//   return categoriesProvider.isLoading
//       ? List<Category>
//       : categoriesProvider.value?.expenseList();
// });

// final incomeCategoriesProvider = Provider<List<Category>>((ref) {
//   final categoriesProvider = ref.watch(getListCategoryProvider);
//   return categoriesProvider.isLoading
//       ? List<Category>
//       : categoriesProvider.value?.incomeList();
// });
