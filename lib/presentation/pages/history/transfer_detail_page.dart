import 'package:app_ui/app_ui.dart';
import 'package:app_ui/molecules/account_chip.dart';
import 'package:app_ui/token/figma_token.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/presentation/provider/account/update_transfer_provider.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:brapa/domain/transaction.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../domain/account.dart';
import '../../provider/account/get_list_account_provider.dart';
import '../../provider/transaction/get_list_transaction_provider.dart';

@RoutePage()
class TransferDetailPage extends HookConsumerWidget {
  const TransferDetailPage({super.key, this.transaction});

  final Transaction? transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = ref.watch(updateTransferProvider.notifier);
    var state = ref.watch(updateTransferProvider);

    final listAccount = ref.watch(getListAccountProvider);
    final listAccountFromScroll = ItemScrollController();
    final listAccountToScroll = ItemScrollController();

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
                                controller.delete().then<void>((value) {
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
                        const TextUI.titleRegular("Transfer Details"),
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
                                    "Account Source",
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
                                          label: "All Accounts",
                                          itemBuilder: listDataShowMore.map((item) {
                                            return AccountChip(
                                              width: 150,
                                              alignment: Alignment.center,
                                              assetPath: item.assets!,
                                              label: item.name,
                                              isActive: item.id == state.fromAccount?.id,
                                              onValueChanged: () {
                                                var index = listDataShowMore.indexOf(item);
                                                controller.setAccountFrom(item);

                                                listAccountFromScroll.scrollTo(
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
                                          itemScrollController: listAccountFromScroll,
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
                                              isActive: item.id == state.fromAccount?.id,
                                              onValueChanged: () {
                                                controller.setAccountFrom(item);
                                              },
                                            );
                                          },
                                        )),
                              )
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
                                    "Account Target",
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
                                          label: "All Accounts",
                                          itemBuilder: listDataShowMore.map((item) {
                                            return AccountChip(
                                              width: 150,
                                              alignment: Alignment.center,
                                              assetPath: item.assets!,
                                              label: item.name,
                                              isActive: item.id == state.toAccount?.id,
                                              onValueChanged: () {
                                                var index = listDataShowMore.indexOf(item);
                                                controller.setAccountTo(item);

                                                listAccountToScroll.scrollTo(
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
                                          itemScrollController: listAccountToScroll,
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
                                              isActive: item.id == state.toAccount?.id,
                                              onValueChanged: () {
                                                controller.setAccountTo(item);
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
                              "Amount value",
                              color: context.colors.sky.dark,
                            ),
                            FreeSpaceUI.vertical(16),
                            TextFormField(
                              controller: controller.amountController,
                              style: FigmaTextStyles.smallNormalRegular,
                              keyboardType: TextInputType.number,
                              keyboardAppearance: Brightness.dark,
                              onChanged: (value) {
                                controller.setAmount(value);
                              },
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
                                var datePickerResult = await showCalendarDatePicker2Dialog(
                                  context: context,
                                  config: CalendarDatePicker2WithActionButtonsConfig(
                                    calendarType: CalendarDatePicker2Type.single,
                                    currentDate: state.createdAt,
                                  ),
                                  dialogSize: const Size(325, 400),
                                  borderRadius: BorderRadius.circular(15),
                                );
                                controller.changeDateTransaction(datePickerResult!.first!);
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
