import 'package:app_ui/app_ui.dart';
import 'package:app_ui/molecules/account_chip.dart';
import 'package:app_ui/molecules/category_chip.dart';
import 'package:app_ui/token/figma_token.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:how_much/domain/category.dart';
import 'package:how_much/domain/transaction.dart';
import 'package:how_much/presentation/provider/transaction/delete_record_provider.dart';
import 'package:how_much/presentation/provider/transaction/update_record_provider.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../provider/account/get_list_account_provider.dart';
import '../../provider/category/get_list_category_provider.dart';
import '../../provider/transaction/get_list_transaction_provider.dart';

@RoutePage()
class RecordDetailPage extends HookConsumerWidget {
  const RecordDetailPage({super.key, this.transaction});

  final Transaction? transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = ref.watch(updateRecordProvider);

    var getListCategory = ref.watch(getListCategoryProvider);
    final listAccount = ref.watch(getListAccountProvider);
    final listCategoryScroll = ItemScrollController();
    final listAccountScroll = ItemScrollController();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: context.colors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBarAction
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => context.router.pop(),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: context.colors.onBackground,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDeleteItemUI(onConfirm: () {
                                ref.watch(deleteRecordProvider).delete(controller.transaction).then<void>((value) {
                                  ref.watch(asyncListHistory.notifier).reload();
                                  context.router.popForced();
                                  context.router.pop();
                                });
                              }, onCancel: () {
                                context.router.pop();
                              });
                            });
                      },
                      icon: const Icon(Icons.delete_rounded),
                      color: context.colors.onBackground,
                    ),
                  ],
                ),
                // Body COntent
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FreeSpaceUI.vertical(20),
                        const TextUI.titleRegular("Record Details"),
                        FreeSpaceUI.vertical(32),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextUI.smallTightRegular(
                              "Amount value",
                              color: context.colors.sky.dark,
                            ),
                            FreeSpaceUI.vertical(16),
                            TextFormField(
                              controller: controller.amountController,
                              style: FigmaTextStyles.smallNormalRegular,
                              keyboardType: TextInputType.number,
                              keyboardAppearance: Brightness.dark,
                              inputFormatters: [
                                ThousandsFormatter(),
                              ],
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: context.colors.surface,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                              ),
                            )
                          ],
                        ),
                        FreeSpaceUI.vertical(20),
                        SizedBox(
                          height: 64,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextUI.smallNoneRegular(
                                    "Category",
                                    color: context.colors.sky.dark,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: TextUI.tinyNoneRegular(
                                      "Show more",
                                      color: context.colors.primary.base,
                                    ),
                                  )
                                ],
                              ),
                              FreeSpaceUI.vertical(16),
                              Expanded(
                                child: getListCategory.maybeWhen(
                                    loading: () => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    data: (listCategory) {
                                      var result = transaction!.type == TransactionType.exp
                                          ? listCategory.expenseList()
                                          : listCategory.incomeList();

                                      return ScrollablePositionedList.separated(
                                        itemScrollController: listCategoryScroll,
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
                                              isActive: item == controller.categorySelected,
                                              onValueChanged: () {
                                                controller.categorySelected = item;
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
                        FreeSpaceUI.vertical(32),
                        SizedBox(
                          height: 72,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextUI.smallNoneRegular(
                                    "Account",
                                    color: context.colors.sky.dark,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: TextUI.tinyNoneRegular(
                                      "Show more",
                                      color: context.colors.primary.base,
                                    ),
                                  )
                                ],
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
                                          itemCount: data.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            var item = data[index];

                                            return AccountChip(
                                              alignment: Alignment.center,
                                              assetPath: item.assets!,
                                              label: item.name,
                                              isActive: item.id == controller.accountSelected?.id,
                                              onValueChanged: () {
                                                controller.accountSelected = item;
                                                controller.notifyListeners();
                                              },
                                            );
                                          },
                                        )),
                              )
                            ],
                          ),
                        ),
                        FreeSpaceUI.vertical(32),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextUI.smallTightRegular(
                              "Memo",
                              color: context.colors.sky.dark,
                            ),
                            FreeSpaceUI.vertical(16),
                            TextFormField(
                              style: FigmaTextStyles.smallNormalRegular,
                              controller: controller.memoController,
                              maxLines: 2,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: context.colors.surface,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                              ),
                            )
                          ],
                        ),
                        FreeSpaceUI.vertical(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextUI.smallTightRegular(
                              "Date",
                              color: context.colors.sky.dark,
                            ),
                            FreeSpaceUI.vertical(16),
                            GestureDetector(
                              onTap: () async {
                                var results = await showCalendarDatePicker2Dialog(
                                  context: context,
                                  config: CalendarDatePicker2WithActionButtonsConfig(),
                                  dialogSize: const Size(325, 400),
                                  borderRadius: BorderRadius.circular(15),
                                );
                              },
                              child: TextFormField(
                                style: FigmaTextStyles.smallNormalRegular.copyWith(color: context.colors.onSurface),
                                enabled: false,
                                controller: controller.dateController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.calendar_month_rounded),
                                  prefixIconColor: context.colors.onSurface,
                                  filled: true,
                                  fillColor: context.colors.surface,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                                ),
                              ),
                            )
                          ],
                        ),
                        FreeSpaceUI.vertical(42),
                        ElevatedButton(
                          onPressed: () async {
                            controller.save().then((value) {
                              ref.watch(asyncListHistory.notifier).reload();
                              context.router.pop();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(48.px),
                            backgroundColor: context.colors.primary.base,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const TextUI.regularNoneRegular("Save"),
                        ),
                        FreeSpaceUI.vertical(42),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
