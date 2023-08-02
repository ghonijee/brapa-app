import 'dart:developer';

import 'package:app_ui/app_ui.dart';
import 'package:app_ui/atom/text_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:how_much/domain/category.dart';
import 'package:how_much/domain/transaction.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../provider/transaction/get_list_transaction_provider.dart';

@RoutePage()
class HistoryPage extends HookConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listHistory = ref.watch(getListTransactionProvider);
    var historyView = useState(0);
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
              const TextUI.titleRegular("History"),
              FreeSpaceUI.vertical(20),
              Center(
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
                  var listData = historyView.value == 0
                      ? data.groupDaily()
                      : data.groupMonthly();
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                  var transactionItem =
                                      groupItem.transactions[index];
                                  return ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: HistoryIconItemWidget(
                                      type: transactionItem.type,
                                    ),
                                    trailing: TextUI.smallNoneRegular(
                                      transactionItem.isExpense()
                                          ? "- ${transactionItem.value.toThousandSeparator()}"
                                          : transactionItem.value
                                              .toThousandSeparator(),
                                      color: context.colors.sky.lighter,
                                    ),
                                    title: TextUI.smallNormalMedium(
                                        transactionItem.category.name),
                                    subtitle: TextUI.smallNoneRegular(
                                      transactionItem.account.name ?? "...",
                                      color: context.colors.sky.base,
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
              )
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
