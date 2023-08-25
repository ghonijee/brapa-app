import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/gen/l10n.dart';
import 'package:brapa/presentation/pages/history/widgets/history_menu_bottom_sheet.dart';
import 'package:brapa/presentation/provider/account/update_transfer_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:brapa/domain/transaction.dart';
import 'package:brapa/gen/assets.gen.dart';
import 'package:brapa/presentation/router/app_router.dart';
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
                  TextUI.titleRegular(S.of(context).histories),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => searchMode.value = !searchMode.value,
                        child: searchMode.value
                            ? TextUI.smallNormalRegular(S.of(context).cancel)
                            : const Icon(Icons.search_rounded),
                      ),
                      FreeSpaceUI.horizontal(16),
                      GestureDetector(
                        onTap: () {
                          WidgetUI.showBottomSheet(context, height: 40.h, child: const HistoryMenuBottomSheet());
                        },
                        child: const Icon(Icons.more_vert_rounded),
                      ),
                    ],
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
                        SegmentedControlValue(label: S.of(context).daily),
                        SegmentedControlValue(label: S.of(context).monthly),
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
                  final listData =
                      historyView.value == 0 ? data.groupDaily(todaylabel: S.of(context).today) : data.groupMonthly();
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
                                      if ([TransactionType.transferIn, TransactionType.transferOut]
                                          .contains(transactionItem.type)) {
                                        ref.watch(updateTransferProvider.notifier).loadTransfer(transactionItem);
                                        context.router.push(TransferDetailRoute(transaction: transactionItem));
                                      } else {
                                        ref.watch(updateRecordProvider).loadTransaction(transactionItem);

                                        context.router.push(RecordDetailRoute(transaction: transactionItem));
                                      }
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
    switch (type) {
      case TransactionType.exp:
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Assets.category.outcome4.image(width: 45, fit: BoxFit.fitHeight),
        );
      case TransactionType.inc:
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Assets.category.income4.image(width: 45, fit: BoxFit.fitHeight),
        );
      case TransactionType.transferOut:
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Assets.category.transferOut4.image(width: 45, fit: BoxFit.fitHeight),
        );
      case TransactionType.transferIn:
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Assets.category.transferIn4.image(width: 45, fit: BoxFit.fitHeight),
        );
      default:
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: const SizedBox(
            width: 45,
            height: 45,
          ),
        );
    }
  }
}
