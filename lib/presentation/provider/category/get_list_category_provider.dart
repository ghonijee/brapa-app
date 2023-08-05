import 'package:how_much/data/repository/category_repository.dart';
import 'package:how_much/domain/category.dart';
import 'package:how_much/gen/injection/injection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final getListCategoryProvider = FutureProvider((ref) async {
  final CategoryRepository repository = getIt<CategoryRepository>();
  var result = await repository.getAll(isActiveOnly: true);
  return result.fold((left) {
    return <Category>[];
  }, (right) => right);
});

class ListCategoryNotifierProvider extends AsyncNotifier<List<Category>> {
  final CategoryRepository repository;

  ListCategoryNotifierProvider(this.repository);

  @override
  FutureOr<List<Category>> build() async {
    return await fetchData();
  }

  Future<List<Category>> fetchData() async {
    var result = await repository.getAll();
    return result.fold((left) {
      return <Category>[];
    }, (right) => right);
  }

  Future<void> reload() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await fetchData();
    });
  }
}

final listCategoriesProvider = AsyncNotifierProvider<ListCategoryNotifierProvider, List<Category>>(
  () => ListCategoryNotifierProvider(getIt<CategoryRepository>()),
);
