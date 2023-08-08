import 'package:app_ui/token/figma_token.dart';
import 'package:app_ui/utils/theme_extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brapa/presentation/provider/account/get_list_account_provider.dart';
import 'package:brapa/presentation/provider/transaction/get_list_transaction_provider.dart';
import 'package:brapa/presentation/router/app_router.dart';

import 'provider/category/get_list_category_provider.dart';

@RoutePage()
class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsRouter.tabBar(
      physics: const NeverScrollableScrollPhysics(),
      routes: const [
        RecordRoute(),
        HistoryRoute(),
        AccountRoute(),
        SettingRoute(),
      ],
      builder: (context, child, controller) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          backgroundColor: context.theme.appColors.background,
          body: child,
          bottomNavigationBar: SizedBox(
            // height: 64,
            child: BottomNavigationBar(
              elevation: 12,
              backgroundColor: context.theme.appColors.ink.darkest,
              iconSize: 24,
              selectedLabelStyle: FigmaTextStyles.tinyNoneRegular.copyWith(color: context.theme.appColors.onBackground),
              unselectedLabelStyle: FigmaTextStyles.tinyNoneRegular.copyWith(color: context.theme.appColors.sky.dark),
              showUnselectedLabels: true,
              currentIndex: tabsRouter.activeIndex,
              onTap: (value) {
                switch (value) {
                  case 0:
                    ref.invalidate(getListAccountProvider);
                    ref.invalidate(getListCategoryProvider);
                  case 1:
                    ref.invalidate(asyncListHistory);
                    break;
                  case 2:
                    ref.invalidate(getListAccountProvider);
                    break;
                  default:
                }
                tabsRouter.setActiveIndex(value);
              },
              selectedItemColor: context.theme.appColors.sky.light,
              unselectedItemColor: context.theme.appColors.sky.dark,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    label: 'Record',
                    icon: Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(Icons.add_box_outlined),
                    )),
                BottomNavigationBarItem(
                    label: 'History',
                    icon: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.bar_chart_outlined),
                    )),
                BottomNavigationBarItem(
                    label: 'Account',
                    icon: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.wallet_outlined),
                    )),
                BottomNavigationBarItem(
                    label: 'Settings',
                    icon: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.settings_outlined),
                    )),
              ],
            ),
          ),
        );
      },
    );
  }
}
