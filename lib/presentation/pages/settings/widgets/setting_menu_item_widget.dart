import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SettingMenuItem extends StatelessWidget {
  const SettingMenuItem({
    super.key,
    required this.label,
    required this.iconData,
    required this.onTapPushPage,
  });

  final String label;
  final IconData iconData;
  final PageRouteInfo onTapPushPage;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () {
        context.router.push(onTapPushPage);
      },
      leading: Icon(
        iconData,
        size: 24,
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        size: 28,
      ),
      title: TextUI.regularTightRegular(label),
    );
  }
}
