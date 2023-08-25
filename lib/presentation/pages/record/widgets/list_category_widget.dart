import 'package:app_ui/app_ui.dart';
import 'package:app_ui/molecules/category_chip.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/gen/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../domain/category.dart';
import '../../../provider/category/get_list_category_provider.dart';
import '../../../provider/transaction/create_record_provider.dart';

class ListCategoryWidget extends ConsumerWidget {
  const ListCategoryWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = ref.watch(createRecordProvider);
    var listCategory = ref.watch(getListCategoryProvider);
    final listCategoryScrollItem = ItemScrollController();

    return SizedBox(
      height: 64,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUI.smallNoneRegular(
                  S.of(context).category,
                  color: context.colors.sky.dark,
                ),
                GestureDetector(
                  onTap: () {
                    var listDataShowMore = controller.segmentedControllerGroupValue == 0
                        ? listCategory.asData?.value.expenseList()
                        : listCategory.asData?.value.incomeList();
                    if (listDataShowMore == null) return;

                    WidgetUI.showBottomSheet(context,
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: ShowMoreBottomSheet<Category>(
                          label: S.of(context).allCategory,
                          itemBuilder: listDataShowMore.map((item) {
                            return CategoryChip(
                                label: item.name,
                                isActive: item == ref.watch(createRecordProvider).categorySelected,
                                onValueChanged: () {
                                  var index = listDataShowMore.indexOf(item);
                                  controller.selectedCategory(item);
                                  listCategoryScrollItem.scrollTo(
                                    index: index < listDataShowMore.length - 2 && index > 1 ? index - 2 : index,
                                    duration: const Duration(milliseconds: 700),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                  );
                                  context.router.pop();
                                });
                          }).toList(),
                        ));
                  },
                  child: TextUI.tinyNoneRegular(
                    S.of(context).showMore,
                    color: context.colors.primary.base,
                  ),
                )
              ],
            ),
          ),
          FreeSpaceUI.vertical(16.sp),
          Expanded(
            child: listCategory.maybeWhen(
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                data: (listCategory) {
                  var result = controller.segmentedControllerGroupValue == 1
                      ? listCategory.incomeList()
                      : listCategory.expenseList();
                  return ScrollablePositionedList.separated(
                    itemScrollController: listCategoryScrollItem,
                    separatorBuilder: (context, index) => FreeSpaceUI.horizontal(8),
                    shrinkWrap: true,
                    itemCount: result.length,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var item = result[index];
                      return CategoryChip(
                          alignment: Alignment.center,
                          label: item.name,
                          isActive: item == ref.watch(createRecordProvider).categorySelected,
                          onValueChanged: () {
                            controller.selectedCategory(item);
                          });
                    },
                  );
                },
                orElse: () {
                  return const SizedBox();
                }),
          ),
        ],
      ),
    );
  }
}
