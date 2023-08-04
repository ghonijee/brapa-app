import 'dart:developer';

import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:how_much/domain/transaction.dart';
import 'package:how_much/presentation/router/app_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../provider/transaction/get_list_transaction_provider.dart';
import '../../provider/transaction/update_record_provider.dart';

@RoutePage()
class HistoryPage extends HookConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listHistory = ref.watch(asyncListHistory);
    var historyView = useState(0);
    var searchMode = useState(false);
    TextEditingController findController = useTextEditingController();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: context.colors.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FreeSpaceUI.vertical(8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TextUI.titleRegular("History"),
                  GestureDetector(
                    onTap: () => searchMode.value = !searchMode.value,
                    child:
                        searchMode.value ? const TextUI.smallNormalRegular('Cancel') : const Icon(Icons.search_rounded),
                  )
                ],
              ),
              FreeSpaceUI.vertical(20),
              WidgetUI.visibility(
                visibility: searchMode.value,
                child: TextFormField(
                  controller: findController,
                  onTap: () {
                    searchMode.value = true;
                  },
                  onChanged: (value) {
                    ref.watch(asyncListHistory.notifier).find(value);
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    filled: true,
                    fillColor: context.colors.ink.darker,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              WidgetUI.visibility(
                visibility: !searchMode.value,
                child: Center(
                  child: SizedBox(
                    // width: 70.w,
                    child: SegmentedControl(
                      groupValue: historyView.value,
                      children: [
                        SegmentedControlValue(label: "Daily"),
                        SegmentedControlValue(label: "Monthly"),
                      ],
                      onValueChanged: (index, value) {
                        historyView.value = index;
                      },
                    ),
                  ),
                ),
              ),
              FreeSpaceUI.vertical(20),
              listHistory.when(
                error: (error, stackTrace) {
                  return SizedBox(
                    child: TextUI.titleRegular(
                      "Not found",
                      color: context.colors.sky.light,
                    ),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                data: (data) {
                  final listData = historyView.value == 0 ? data.groupDaily() : data.groupMonthly();
                  return Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                      itemCount: listData.length,
                      itemBuilder: (context, index) {
                        var groupItem = listData[index];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: context.colors.surface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextUI.smallNoneBold(
                                    groupItem.label,
                                    color: context.colors.sky.light,
                                  ),
                                  TextUI.smallNormalBold(
                                    groupItem.amount.currency(),
                                    color: context.colors.sky.lighter,
                                  )
                                ],
                              ),
                              FreeSpaceUI.vertical(16),
                              ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: groupItem.transactions.length,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  var transactionItem = groupItem.transactions[index];
                                  return ListTile(
                                    onTap: () {
                                      // WidgetUI.showBottomSheet(context, TransactionEditBottomSheet());
                                      ref.watch(updateRecordProvider).loadTransaction(transactionItem);

                                      context.router.push(RecordDetailRoute(transaction: transactionItem));
                                    },
                                    contentPadding: EdgeInsets.zero,
                                    leading: HistoryIconItemWidget(
                                      type: transactionItem.type,
                                    ),
                                    trailing: TextUI.smallNoneRegular(
                                      transactionItem.isExpense()
                                          ? "- ${transactionItem.value.toThousandSeparator()}"
                                          : transactionItem.value.toThousandSeparator(),
                                      color: context.colors.sky.lighter,
                                    ),
                                    title: TextUI.smallNormalMedium(transactionItem.category.name),
                                    subtitle: TextUI.smallNoneRegular(
                                      transactionItem.subtitle(),
                                      color: context.colors.sky.base,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HistoryIconItemWidget extends StatelessWidget {
  const HistoryIconItemWidget({super.key, required this.type});
  final TransactionType type;

  @override
  Widget build(BuildContext context) {
    return type == TransactionType.exp
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
