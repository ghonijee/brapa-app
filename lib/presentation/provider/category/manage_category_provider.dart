import 'dart:developer';

import 'package:app_ui/app_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brapa/data/repository/account_repository.dart';
import 'package:brapa/domain/account.dart';
import 'package:brapa/domain/category.dart';
import 'package:brapa/gen/injection/injection.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repository/category_repository.dart';
import 'get_list_category_provider.dart';

class ManageCategoryNotifier extends StateNotifier<Category> {
  final CategoryRepository repository;
  final List<Category> listData;

  ManageCategoryNotifier(this.repository, this.listData) : super(Category(categoryType: CategoryType.exp, name: ''));

  show(Category data) {
    state = data;
    print(state.order);
  }

  saveUpdate({
    required String name,
    required bool isActive,
    required CategoryType type,
  }) async {
    state = state.copyWith(
      name: name,
      isActive: isActive,
      categoryType: type,
    );

    await repository.update(state);
  }

  store({
    required String name,
    required bool isActive,
    required CategoryType type,
  }) async {
    var lastOrder = type == CategoryType.inc ? listData.incomeList().length : listData.expenseList().length;
    state = Category(name: name, isActive: isActive, categoryType: type, order: lastOrder + 1);
    await repository.store(state);
  }

  delete() async {
    await repository.destroy(state);
  }
}

@injectable
final manageCategoryProvider = StateNotifierProvider((ref) {
  final data = ref.watch(listCategoriesProvider);

  return ManageCategoryNotifier(getIt<CategoryRepository>(), data.asData!.value);
});
