import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import '../../../../domain/account.dart';

class AccountCardWidget extends StatelessWidget {
  const AccountCardWidget({
    super.key,
    required this.item,
  });

  final Account item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: context.theme.appColors.sky.light,
            ),
            child: Image.asset(
              item.assets!,
              fit: BoxFit.fitWidth,
            ),
          ),
          FreeSpaceUI.vertical(20),
          TextUI.smallNoneBold(item.balance!.currency()),
          FreeSpaceUI.vertical(8),
          TextUI.smallNoneMedium(
            item.name,
            color: context.colors.sky.base,
          )
        ],
      ),
    );
  }
}
