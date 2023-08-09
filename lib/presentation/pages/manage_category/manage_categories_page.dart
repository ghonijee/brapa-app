import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:brapa/domain/category.dart';
import 'package:brapa/presentation/pages/pages.dart';
import 'package:brapa/presentation/router/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../gen/assets.gen.dart';
import '../../provider/category/get_list_category_provider.dart';
import '../../provider/category/manage_category_provider.dart';

@RoutePage()
class ManageCategoriesPage extends HookConsumerWidget {
  const ManageCategoriesPage({super.key, required this.label, required this.type});

  final String label;
  final CategoryType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listCategories = ref.watch(listCategoriesProvider);
    var listCategoriesController = ref.watch(listCategoriesProvider.notifier);
    var reorderListActive = useState(false);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: reorderListActive.value ? TextUI.largeNoneBold("Reorder $label") : TextUI.largeNoneBold(label),
          backgroundColor: context.colors.background,
          actions: [
            reorderListActive.value
                ? GestureDetector(
                    onTap: () async {
                      await listCategoriesController.saveReorder();
                      reorderListActive.value = false;
                    },
                    child: Icon(
                      Icons.check_rounded,
                      color: context.colors.onBackground,
                    ),
                  )
                : Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          WidgetUI.showBottomSheet(context,
                              height: 20.h,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const TextUI.regularNormalBold("Manage Tips"),
                                    FreeSpaceUI.vertical(20),
                                    const TextUI.smallNoneRegular(
                                        "Press and hold the item to active reoder list feature"),
                                  ],
                                ),
                              ));
                        },
                        child: Icon(
                          Icons.help_outline_rounded,
                          color: context.colors.onBackground,
                        ),
                      ),
                      FreeSpaceUI.horizontal(16),
                      GestureDetector(
                        onTap: () => context.router
                            .push(DetailCategoryRoute(formMode: FormCategoryType.create, type: type, label: label)),
                        child: Icon(
                          Icons.add_circle_outline,
                          color: context.colors.onBackground,
                        ),
                      ),
                    ],
                  ),
            FreeSpaceUI.horizontal(24),
          ],
        ),
        backgroundColor: context.colors.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FreeSpaceUI.vertical(12),
              Expanded(
                  child: listCategories.when(data: (listCategory) {
                var data = CategoryType.inc == type ? listCategory.incomeList() : listCategory.expenseList();

                if (reorderListActive.value) {
                  return ReorderableListView.builder(
                    itemBuilder: (context, index) {
                      var item = data[index];
                      return ListTile(
                        key: Key(item.id.toString()),
                        contentPadding: EdgeInsets.zero,
                        leading: CategoryIconItemWidget(
                          isActive: item.isActive ?? true,
                          type: item.categoryType,
                        ),
                        title: TextUI.regularTightRegular(
                          item.name,
                          color: item.isActive! ? context.colors.onBackground : context.colors.ink.light,
                        ),
                      );
                    },
                    itemCount: data.length,
                    onReorder: (oldIndex, newIndex) {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final tempItem = data.removeAt(oldIndex);
                      data.insert(newIndex, tempItem);
                      listCategoriesController.reorderData(data);
                    },
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var item = data[index];
                    return ListTile(
                      key: Key(item.id.toString()),
                      onLongPress: () => reorderListActive.value = true,
                      onTap: () {
                        ref.watch(manageCategoryProvider.notifier).show(item);
                        context.router.push(DetailCategoryRoute(
                            data: item, formMode: FormCategoryType.update, type: type, label: label));
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: CategoryIconItemWidget(
                        isActive: item.isActive ?? true,
                        type: item.categoryType,
                      ),
                      title: TextUI.regularTightRegular(
                        item.name,
                        color: item.isActive! ? context.colors.onBackground : context.colors.ink.light,
                      ),
                    );
                  },
                );
              }, error: (e, s) {
                return const SizedBox(
                  child: TextUI.regularNoneRegular("Something wrong, please try later!"),
                );
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })),
              // Body COntent
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryIconItemWidget extends StatelessWidget {
  const CategoryIconItemWidget({super.key, required this.type, required this.isActive});
  final CategoryType type;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return type == CategoryType.exp
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Assets.category.outcome1.image(
              width: 45,
              fit: BoxFit.fitHeight,
              color: isActive ? null : context.colors.ink.dark,
              colorBlendMode: BlendMode.color,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Assets.category.income1.image(
              width: 45,
              fit: BoxFit.fitHeight,
              color: isActive ? null : context.colors.ink.dark,
              colorBlendMode: BlendMode.color,
            ),
          );
  }
}
