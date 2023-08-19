import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:brapa/domain/category.dart';
import 'package:brapa/presentation/router/app_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'widgets/setting_menu_item_widget.dart';

@RoutePage()
class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              const TextUI.titleRegular("Settings"),
              FreeSpaceUI.vertical(20.sp),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SettingMenuItem(
                    label: "Accounts",
                    iconData: BoxIcons.bxl_pocket,
                    onTapPushPage: ManageAccountsRoute(),
                  ),
                  FreeSpaceUI.vertical(8),
                  SettingMenuItem(
                    label: "Expense Categories",
                    iconData: Icons.upload_rounded,
                    onTapPushPage: ManageCategoriesRoute(label: "Expense Categories", type: CategoryType.exp),
                  ),
                  FreeSpaceUI.vertical(8),
                  SettingMenuItem(
                    label: "Income Categories",
                    iconData: Icons.download_rounded,
                    onTapPushPage: ManageCategoriesRoute(label: "Income Categories", type: CategoryType.inc),
                  ),
                  FreeSpaceUI.vertical(8),
                  const SettingMenuItem(
                    label: "Security",
                    iconData: BoxIcons.bxs_lock_alt,
                    onTapPushPage: SecurityRoute(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
