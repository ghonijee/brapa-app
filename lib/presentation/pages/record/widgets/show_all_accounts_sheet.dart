import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../provider/account/get_list_account_provider.dart';
import '../../../provider/transaction/create_record_provider.dart';

class ShowAllAccountBottomSheet extends ConsumerWidget {
  const ShowAllAccountBottomSheet({super.key, this.onTap});
  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var getListData = ref.watch(getListAccountProvider);
    final CreateRecordNotifier controller = ref.watch(createRecordProvider.notifier);
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
      height: 70.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colors.ink.darker,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextUI.largeNormalBold("All Accounts"),
          FreeSpaceUI.vertical(20),
          getListData.maybeWhen(
            orElse: () => const Center(
              child: TextUI.largeTightMedium(
                "Data not found",
              ),
            ),
            data: (result) {
              return Expanded(
                child: Wrap(
                    runSpacing: 16,
                    spacing: 16,
                    children: result
                        .map((item) => GestureDetector(
                              onTap: () {
                                ref.watch(createRecordProvider).accountSelected = item;
                                controller.notifyListeners();
                                onTap?.call(result.indexOf(item));
                                context.router.pop();
                              },
                              child: Container(
                                width: 150,
                                decoration: BoxDecoration(
                                  color: context.theme.appColors.ink.dark,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(45),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextUI.smallNoneRegular(item.name),
                                    FreeSpaceUI.horizontal(12),
                                    Container(
                                      width: 28,
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: context.theme.appColors.red.lightest,
                                      ),
                                      child: Image.asset(
                                        item.assets!,
                                        width: 20,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                        .toList()),
              );
            },
          )
        ],
      ),
    );
  }
}
