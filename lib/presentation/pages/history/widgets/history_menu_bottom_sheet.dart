import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/gen/l10n.dart';
import 'package:brapa/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryMenuBottomSheet extends ConsumerWidget {
  const HistoryMenuBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextUI.regularTightBold(S.of(context).otherMenu),
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
                title: TextUI.smallNormalRegular(S.of(context).createTransactionTitle),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: context.colors.sky.dark,
                  size: 32,
                ),
                onTap: () {
                  context.router.pop();
                  context.router.push(const RecordFormRoute());
                },
                subtitle: TextUI.tinyNoneRegular(
                  S.of(context).createTransactionSubtitle,
                  color: context.colors.sky.dark,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: TextUI.smallNormalRegular(S.of(context).createTransferitle),
                trailing: Icon(
                  Icons.chevron_right_rounded,
                  color: context.colors.sky.dark,
                  size: 32,
                ),
                onTap: () {
                  context.router.pop();
                  context.router.push(const TransferFormRoute());
                },
                subtitle: TextUI.tinyNoneRegular(
                  S.of(context).createTransferSubtitle,
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
