import 'package:brapa/data/repository/category_repository.dart';
import 'package:brapa/domain/category.dart';
import 'package:brapa/gen/injection/injection.dart';
import 'package:injectable/injectable.dart';
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

  void reorderData(List<Category> data) {
    state = AsyncValue.data(data);
  }

  Future<void> saveReorder() async {
    for (var (index, item) in state.asData!.value.indexed) {
      await repository.update(item.copyWith(order: index + 1));
    }
    reload();
  }
}

@injectable
final listCategoriesProvider = AsyncNotifierProvider<ListCategoryNotifierProvider, List<Category>>(
  () => ListCategoryNotifierProvider(getIt<CategoryRepository>()),
);
