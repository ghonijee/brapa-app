import 'dart:developer';

import 'package:app_ui/app_ui.dart';
import 'package:app_ui/molecules/account_chip.dart';
import 'package:app_ui/molecules/category_chip.dart';
import 'package:app_ui/token/figma_token.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:how_much/domain/category.dart';
import 'package:how_much/presentation/provider/category/get_list_category_provider.dart';
import 'package:how_much/presentation/provider/transaction/create_record_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../provider/account/get_list_account_provider.dart';

@RoutePage()
class RecordPage extends ConsumerWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = ref.watch(createRecordProvider);
    // var listCategory = controller.segmentedControllerGroupValue == 0
    //     ? ref.watch(expCategoriesProvider)
    //     : ref.watch(incomeCategoriesProvider);
    var getListCategory = ref.watch(getListCategoryProvider);

    final listAccount = ref.watch(getListAccountProvider);
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
                          TextUI.tinyNoneRegular(
                            "Show more",
                            color: context.colors.primary.base,
                          )
                        ],
                      ),
                    ),
                    FreeSpaceUI.vertical(16.sp),
                    getListCategory.maybeWhen(
                        loading: () => Center(
                              child: CircularProgressIndicator(),
                            ),
                        data: (listCategory) {
                          var result =
                              controller.segmentedControllerGroupValue == 1
                                  ? listCategory!.incomeList()
                                  : listCategory!.expenseList();
                          return SizedBox.fromSize(
                            size: Size.fromHeight(48.px),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: result.length,
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var item = result?[index];
                                return CategoryChip(
                                    // icon: "Icons.home_filled",
                                    label: item!.name,
                                    isActive: item ==
                                        ref
                                            .watch(createRecordProvider)
                                            .categorySelected,
                                    onValueChanged: () {
                                      ref
                                          .watch(createRecordProvider)
                                          .categorySelected = item;
                                      controller.notifyListeners();
                                    });
                              },
                            ),
                          );
                        },
                        orElse: () {
                          return SizedBox();
                        }),
                  ],
                ),
              ),
              FreeSpaceUI.vertical(24),
              SizedBox(
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
                          TextUI.tinyNoneRegular(
                            "Show more",
                            color: context.colors.primary.base,
                          )
                        ],
                      ),
                    ),
                    FreeSpaceUI.vertical(16.sp),
                    listAccount.isLoading
                        ? SizedBox()
                        : SizedBox.fromSize(
                            size: Size.fromHeight(48.px),
                            child: ListView.builder(
                              addSemanticIndexes: true,
                              shrinkWrap: true,
                              itemCount: listAccount.value?.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var item = listAccount.value?[index];
                                return AccountChip(
                                  assetPath: item!.assets!,
                                  label: item.name,
                                  isActive: item ==
                                      ref
                                          .watch(createRecordProvider)
                                          .accountSelected,
                                  onValueChanged: () {
                                    ref
                                        .watch(createRecordProvider)
                                        .accountSelected = item;
                                    controller.notifyListeners();
                                  },
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
              // FreeSpaceUI.vertical(20),
              NumericKeyboard(
                onKeyboardTap: (value) {
                  var oldValue = controller.amountController.text;
                  var newValue = oldValue + value;
                  controller.amountController.text =
                      newValue.currency(prefix: '');
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
                  controller.amountController.text = controller
                      .amountController.text
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
