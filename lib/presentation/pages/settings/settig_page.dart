import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:brapa/domain/category.dart';
import 'package:brapa/presentation/router/app_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
                  // TextUI.largeNoneBold("Master Data"),
                  // FreeSpaceUI.vertical(16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      context.router.push(const ManageAccountsRoute());
                    },
                    leading: const Icon(
                      BoxIcons.bxl_pocket,
                      size: 28,
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      size: 28,
                    ),
                    title: const TextUI.regularTightRegular("Accounts"),
                  ),
                  FreeSpaceUI.vertical(8),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      context.router.push(ManageCategoriesRoute(label: "Expense Categories", type: CategoryType.exp));
                    },
                    leading: const Icon(
                      Icons.upload_rounded,
                      size: 28,
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      size: 28,
                    ),
                    title: const TextUI.regularTightRegular("Expense Categories"),
                  ),
                  FreeSpaceUI.vertical(8),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    onTap: () {
                      context.router.push(ManageCategoriesRoute(label: "Income Categories", type: CategoryType.inc));
                    },
                    leading: const Icon(
                      Icons.download_rounded,
                      size: 28,
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_rounded,
                      size: 28,
                    ),
                    title: const TextUI.regularTightRegular("Income Categories"),
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
