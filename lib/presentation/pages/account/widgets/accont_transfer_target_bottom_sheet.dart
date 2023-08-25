import 'package:app_ui/app_ui.dart';
import 'package:app_ui/molecules/account_chip.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/gen/l10n.dart';
import 'package:brapa/presentation/pages/account/widgets/accont_transfer_value_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../domain/account.dart';
import '../../../provider/account/get_list_account_provider.dart';
import '../../../provider/account/transfer_account_provider.dart';

class TransferTargetBottomSheet extends ConsumerWidget {
  const TransferTargetBottomSheet({
    super.key,
    required this.account,
  });

  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listAccount = ref.watch(getListAccountProvider);
    final transferController = ref.watch(transferAccountProvider.notifier);

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextUI.regularNormalBold(S.of(context).transferTo),
              IconButton(
                onPressed: () {
                  context.router.popUntilRoot();
                },
                icon: Icon(
                  Icons.highlight_remove_rounded,
                  color: context.colors.sky.dark,
                ),
              )
            ],
          ),
          FreeSpaceUI.vertical(10),
          Divider(
            height: 1,
            color: context.colors.sky.dark,
          ),
          FreeSpaceUI.vertical(10),
          listAccount.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      runSpacing: 8,
                      spacing: 8,
                      children: listAccount.asData!.value.except(account).map((item) {
                        return AccountChip(
                          width: 150,
                          alignment: Alignment.centerLeft,
                          assetPath: item.assets!,
                          label: item.name,
                          isActive: false,
                          onValueChanged: () {
                            transferController.selectedTargetAccount(item);
                            context.router.popUntilRoot();

                            WidgetUI.showBottomSheet(
                              context,
                              isScrollControlled: true,
                              height: 40.h,
                              child: TransferValueBottomSheet(account: item),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
