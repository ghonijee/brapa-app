import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/presentation/provider/account/transfer_account_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../domain/account.dart';
import 'accont_transfer_target_bottom_sheet.dart';

class AccountMenuBottomSheet extends ConsumerWidget {
  const AccountMenuBottomSheet({
    super.key,
    required this.item,
  });

  final Account item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transferController = ref.watch(transferAccountProvider.notifier);

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextUI.titleRegular(item.name),
              IconButton(
                onPressed: () {
                  context.router.pop();
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
          ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const TextUI.regularTightRegular("Transfer"),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: context.colors.sky.dark,
                  size: 32,
                ),
                onTap: () {
                  transferController.initTransfer(item);
                  WidgetUI.showBottomSheet(
                    context,
                    isScrollControlled: true,
                    height: 50.h,
                    child: TransferTargetBottomSheet(account: item),
                  );
                },
                subtitle: TextUI.smallTightRegular(
                  "Send balance to other account",
                  color: context.colors.sky.dark,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
