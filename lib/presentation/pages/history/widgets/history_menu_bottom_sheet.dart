import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
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
              const TextUI.regularTightBold("Actions"),
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
                title: const TextUI.smallNormalRegular("Create Transaction"),
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
                  "Record new transaction with form",
                  color: context.colors.sky.dark,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const TextUI.smallNormalRegular("Create Transfer"),
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
                  "Send to other account with form",
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
