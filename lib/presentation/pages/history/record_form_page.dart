import 'package:app_ui/app_ui.dart';
import 'package:app_ui/molecules/account_chip.dart';
import 'package:app_ui/molecules/category_chip.dart';
import 'package:app_ui/token/figma_token.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/gen/l10n.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:brapa/domain/category.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../domain/account.dart';
import '../../provider/account/get_list_account_provider.dart';
import '../../provider/category/get_list_category_provider.dart';
import '../../provider/transaction/create_record_provider.dart';
import '../../provider/transaction/get_list_transaction_provider.dart';

@RoutePage()
class RecordFormPage extends HookConsumerWidget {
  const RecordFormPage({super.key});

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
        backgroundColor: context.colors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBarAction
                GestureDetector(
                  onTap: () => context.router.pop(),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: context.colors.onBackground,
                  ),
                ),
                // Body COntent
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FreeSpaceUI.vertical(20),
                        TextUI.titleRegular(S.of(context).createTransactionTitle),
                        FreeSpaceUI.vertical(32),
                        Center(
                          child: SegmentedControl(
                            groupValue: controller.segmentedControllerGroupValue,
                            children: [
                              SegmentedControlValue(
                                  label: S.of(context).expense,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.arrow_circle_up_rounded,
                                        color: context.colors.red.base,
                                        size: 20,
                                      ),
                                      FreeSpaceUI.horizontal(8),
                                      TextUI.tinyNoneBold(S.of(context).expense),
                                    ],
                                  )),
                              SegmentedControlValue(
                                  label: S.of(context).income,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextUI.tinyNoneBold(S.of(context).income),
                                      FreeSpaceUI.horizontal(8),
                                      Icon(
                                        Icons.arrow_circle_down_rounded,
                                        color: context.colors.green.base,
                                        size: 20,
                                      ),
                                    ],
                                  )),
                              // SegmentedControlValue(label: "Income"),
                            ],
                            onValueChanged: (index, value) {
                              controller.changeSegmentedControlValue(index);
                            },
                          ),
                        ),
                        FreeSpaceUI.vertical(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextUI.smallTightRegular(
                              S.of(context).amountValue,
                              color: context.colors.sky.dark,
                            ),
                            FreeSpaceUI.vertical(16),
                            TextFormField(
                              controller: controller.amountController,
                              style: FigmaTextStyles.smallNormalRegular,
                              keyboardType: TextInputType.number,
                              keyboardAppearance: Brightness.dark,
                              onChanged: (value) {
                                controller.onChangeAmountValue(value);
                              },
                              inputFormatters: [
                                ThousandsFormatter(),
                              ],
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: context.colors.surface,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                                hintText: "0",
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
                                    S.of(context).category,
                                    color: context.colors.sky.dark,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      var listDataShowMore = controller.segmentedControllerGroupValue == 0
                                          ? getListCategory.asData?.value.expenseList()
                                          : getListCategory.asData?.value.incomeList();
                                      if (listDataShowMore == null) return;

                                      WidgetUI.showBottomSheet(context,
                                          height: MediaQuery.of(context).size.height * 0.7,
                                          child: ShowMoreBottomSheet<Category>(
                                            label: S.of(context).allCategory,
                                            itemBuilder: listDataShowMore.map((item) {
                                              return CategoryChip(
                                                  label: item.name,
                                                  isActive: item == controller.categorySelected,
                                                  onValueChanged: () {
                                                    var index = listDataShowMore.indexOf(item);
                                                    controller.selectedCategory(item);
                                                    listCategoryScroll.scrollTo(
                                                      index: index < listDataShowMore.length - 2 && index > 1
                                                          ? index - 2
                                                          : index,
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
                              FreeSpaceUI.vertical(16),
                              Expanded(
                                child: getListCategory.maybeWhen(
                                    loading: () => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    data: (listCategory) {
                                      var result = controller.segmentedControllerGroupValue == 0
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
                                    S.of(context).account,
                                    color: context.colors.sky.dark,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      var listDataShowMore = listAccount.asData?.value;

                                      if (listDataShowMore == null) return;

                                      WidgetUI.showBottomSheet(
                                        context,
                                        height: MediaQuery.of(context).size.height * 0.7,
                                        child: ShowMoreBottomSheet<Account>(
                                          label: S.of(context).allAccount,
                                          itemBuilder: listDataShowMore.map((item) {
                                            return AccountChip(
                                              width: 150,
                                              alignment: Alignment.center,
                                              assetPath: item.assets!,
                                              label: item.name,
                                              isActive: item == controller.accountSelected,
                                              onValueChanged: () {
                                                var index = listDataShowMore.indexOf(item);
                                                controller.selectedAccount(item);
                                                listAccountScroll.scrollTo(
                                                  index: index < listDataShowMore.length - 2 && index > 0
                                                      ? index - 1
                                                      : index,
                                                  duration: const Duration(milliseconds: 700),
                                                  curve: Curves.fastLinearToSlowEaseIn,
                                                );
                                                context.router.pop();
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      );
                                    },
                                    child: TextUI.tinyNoneRegular(
                                      S.of(context).showMore,
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
                                                controller.selectedAccount(item);
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
                              S.of(context).memo,
                              color: context.colors.sky.dark,
                            ),
                            FreeSpaceUI.vertical(16),
                            TextFormField(
                              style: FigmaTextStyles.smallNormalRegular,
                              controller: controller.memoController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: context.colors.surface,
                                hintText: S.of(context).memoHint,
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
                              S.of(context).date,
                              color: context.colors.sky.dark,
                            ),
                            FreeSpaceUI.vertical(16),
                            GestureDetector(
                              onTap: () async {
                                var datePickerResult = await showCalendarDatePicker2Dialog(
                                  context: context,
                                  config: CalendarDatePicker2WithActionButtonsConfig(
                                    calendarType: CalendarDatePicker2Type.single,
                                    currentDate: controller.createdAt,
                                  ),
                                  dialogSize: const Size(325, 400),
                                  borderRadius: BorderRadius.circular(15),
                                );
                                if (datePickerResult != null) {
                                  controller.changeDateTransaction(datePickerResult.first!);
                                }
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
                          onPressed: controller.validate()
                              ? () async {
                                  controller.save().then((value) {
                                    ref.watch(asyncListHistory.notifier).reload();
                                    context.router.pop();
                                    Fluttertoast.showToast(
                                      msg: S.of(context).saveRecordSuccess,
                                      backgroundColor: context.colors.green.darkest,
                                      textColor: context.colors.sky.base,
                                    );
                                  });
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(48.px),
                            backgroundColor: context.colors.primary.base,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: TextUI.regularNoneRegular(S.of(context).save),
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
