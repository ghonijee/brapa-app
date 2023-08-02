import 'package:app_ui/app_ui.dart';
import 'package:app_ui/molecules/account_chip.dart';
import 'package:app_ui/molecules/category_chip.dart';
import 'package:app_ui/token/figma_token.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:how_much/domain/category.dart';
import 'package:how_much/presentation/provider/category/get_list_category_provider.dart';
import 'package:how_much/presentation/provider/transaction/create_record_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../provider/account/get_list_account_provider.dart';
import 'widgets/show_all_accounts_sheet.dart';
import 'widgets/show_all_categories_sheet.dart';

@RoutePage()
class RecordPage extends HookConsumerWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = ref.watch(createRecordProvider);
    var getListCategory = ref.watch(getListCategoryProvider);
    final listAccount = ref.watch(getListAccountProvider);
    final listCategoryScroll = ItemScrollController();
    final listAccountScroll = ItemScrollController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: context.theme.appColors.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FreeSpaceUI.vertical(8.h),
              Center(
                child: SizedBox(
                  width: 70.w,
                  child: SegmentedControl(
                    groupValue: controller.segmentedControllerGroupValue,
                    children: [
                      SegmentedControlValue(label: "Expense"),
                      SegmentedControlValue(label: "Income"),
                    ],
                    onValueChanged: (index, value) {
                      controller.segmentedControllerGroupValue = index;
                      controller.notifyListeners();
                    },
                  ),
                ),
              ),
              Column(
                children: [
                  FreeSpaceUI.vertical(16.sp),
                  AmountInputField(
                    focusNode: controller.focusNode,
                    controller: controller.amountController,
                  ),
                  FreeSpaceUI.vertical(12.sp),
                  MemoInputField(memoController: controller.memoController),
                ],
              ),
              FreeSpaceUI.vertical(12.sp),
              SizedBox(
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
                            "Category",
                            color: context.colors.sky.dark,
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                enableDrag: true,
                                // isScrollControlled: true,
                                useRootNavigator: true,
                                backgroundColor: null,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                )),
                                builder: (context) {
                                  return ShowAllCategoryBottomSheet(
                                    getListCategory: getListCategory,
                                    controller: controller,
                                    onTap: (int index) {
                                      // listCategoryScroll.jumpTo(index: index);
                                      listCategoryScroll.scrollTo(
                                        index: index,
                                        duration: const Duration(milliseconds: 700),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: TextUI.tinyNoneRegular(
                              "Show more",
                              color: context.colors.primary.base,
                            ),
                          )
                        ],
                      ),
                    ),
                    FreeSpaceUI.vertical(16.sp),
                    Expanded(
                      child: getListCategory.maybeWhen(
                          loading: () => const Center(
                                child: CircularProgressIndicator(),
                              ),
                          data: (listCategory) {
                            var result = controller.segmentedControllerGroupValue == 1
                                ? listCategory.incomeList()
                                : listCategory.expenseList();
                            return ScrollablePositionedList.separated(
                              itemScrollController: listCategoryScroll,
                              separatorBuilder: (context, index) => FreeSpaceUI.horizontal(8),
                              shrinkWrap: true,
                              itemCount: result.length,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var item = result?[index];
                                return CategoryChip(
                                    alignment: Alignment.center,
                                    label: item!.name,
                                    isActive: item == ref.watch(createRecordProvider).categorySelected,
                                    onValueChanged: () {
                                      ref.watch(createRecordProvider).categorySelected = item;
                                      controller.notifyListeners();
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
              ),
              FreeSpaceUI.vertical(24),
              SizedBox(
                height: 72,
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
                            "Account",
                            color: context.colors.sky.dark,
                          ),
                          GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                enableDrag: true,
                                isScrollControlled: true,
                                useRootNavigator: true,
                                backgroundColor: null,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                ),
                                builder: (context) {
                                  return ShowAllAccountBottomSheet(
                                    onTap: (index) {
                                      listAccountScroll.scrollTo(
                                        index: index,
                                        duration: const Duration(milliseconds: 700),
                                        curve: Curves.fastLinearToSlowEaseIn,
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            child: TextUI.tinyNoneRegular(
                              "Show more",
                              color: context.colors.primary.base,
                            ),
                          )
                        ],
                      ),
                    ),
                    FreeSpaceUI.vertical(16.sp),
                    Expanded(
                      child: listAccount.maybeWhen(
                          orElse: () => const SizedBox(),
                          data: (data) => ScrollablePositionedList.separated(
                                itemScrollController: listAccountScroll,
                                separatorBuilder: (context, index) => FreeSpaceUI.horizontal(8),
                                addSemanticIndexes: true,
                                shrinkWrap: true,
                                itemCount: data!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var item = data[index];
                                  return AccountChip(
                                    alignment: Alignment.center,
                                    assetPath: item!.assets!,
                                    label: item.name,
                                    isActive: item == ref.watch(createRecordProvider).accountSelected,
                                    onValueChanged: () {
                                      ref.watch(createRecordProvider).accountSelected = item;
                                      controller.notifyListeners();
                                    },
                                  );
                                },
                              )),
                    )
                  ],
                ),
              ),
              // FreeSpaceUI.vertical(20),
              NumericKeyboard(
                onKeyboardTap: (value) {
                  var oldValue = controller.amountController.text;
                  var newValue = oldValue + value;
                  controller.amountController.text = newValue.currency(prefix: '');
                },
                textStyle: FigmaTextStyles.largeNormalMedium,
                rightButtonFn: () async {
                  // On Submit
                  await controller.save();
                  ref.refresh(getListAccountProvider);
                },
                rightIcon: const Icon(
                  Icons.check,
                ),
                leftButtonFn: () {
                  controller.amountController.text = controller.amountController.text
                      .substring(0, controller.amountController.text.length - 1)
                      .currency(prefix: "");
                },
                leftIcon: const Icon(
                  Icons.backspace,
                ),
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              )
            ],
          ),
        ),
      ),
    );
  }
}
