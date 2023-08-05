import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_much/domain/category.dart';
import 'package:how_much/presentation/pages/pages.dart';
import 'package:how_much/presentation/provider/account/manage_account_provider.dart';
import 'package:how_much/presentation/router/app_router.dart';

import '../../provider/category/get_list_category_provider.dart';
import '../../provider/category/manage_category_provider.dart';

@RoutePage()
class ManageCategoriesPage extends ConsumerWidget {
  const ManageCategoriesPage({super.key, required this.label, required this.type});

  final String label;
  final CategoryType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listCategories = ref.watch(listCategoriesProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: TextUI.largeNoneBold(label),
          backgroundColor: context.colors.background,
          actions: [
            GestureDetector(
              onTap: () =>
                  context.router.push(DetailCategoryRoute(formMode: FormCategoryType.create, type: type, label: label)),
              child: Icon(
                Icons.add_circle_outline,
                color: context.colors.onBackground,
              ),
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
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var item = data[index];
                    return ListTile(
                      onTap: () {
                        ref.watch(manageCategoryProvider.notifier).show(item);
                        context.router.push(DetailCategoryRoute(
                            data: item, formMode: FormCategoryType.update, type: type, label: label));
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: CategoryIconItemWidget(
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
  const CategoryIconItemWidget({super.key, required this.type});
  final CategoryType type;

  @override
  Widget build(BuildContext context) {
    return type == CategoryType.exp
        ? Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.theme.appColors.red.darkest,
            ),
            child: Icon(
              Icons.outbox,
              size: 24,
              color: context.theme.appColors.red.lightest,
            ),
          )
        : Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.theme.appColors.green.darkest,
            ),
            child: Icon(
              Icons.inbox,
              size: 24,
              color: context.theme.appColors.green.lightest,
            ),
          );
  }
}
