import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';

class AccountDetailBottomSheet extends StatelessWidget {
  const AccountDetailBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 48),
      width: double.infinity,
      height: 500,
      decoration: BoxDecoration(
        color: context.colors.ink.darker,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FreeSpaceUI.vertical(20),
          const TextUI.largeNormalBold("Account Detail"),
          FreeSpaceUI.vertical(32),
        ],
      ),
    );
  }
}
