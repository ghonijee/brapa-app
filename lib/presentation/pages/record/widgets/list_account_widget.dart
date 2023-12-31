import 'package:app_ui/app_ui.dart';
import 'package:app_ui/molecules/account_chip.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/gen/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brapa/domain/account.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../provider/account/get_list_account_provider.dart';
import '../../../provider/transaction/create_record_provider.dart';

class ListAccountWidget extends ConsumerWidget {
  const ListAccountWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = ref.watch(createRecordProvider);
    final listAccount = ref.watch(getListAccountProvider);
    final listAccountScroll = ItemScrollController();
    return SizedBox(
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
                            isActive: item == ref.watch(createRecordProvider).accountSelected,
                            onValueChanged: () {
                              var index = listDataShowMore.indexOf(item);
                              controller.selectedAccount(item);
                              listAccountScroll.scrollTo(
                                index: index < listDataShowMore.length - 2 && index > 0 ? index - 1 : index,
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
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        var item = data[index];
                        return AccountChip(
                          alignment: Alignment.center,
                          assetPath: item.assets!,
                          label: item.name,
                          isActive: item == ref.watch(createRecordProvider).accountSelected,
                          onValueChanged: () {
                            controller.selectedAccount(item);
                          },
                        );
                      },
                    )),
          )
        ],
      ),
    );
  }
}
