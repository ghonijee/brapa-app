import 'package:app_ui/token/figma_token.dart';
import 'package:app_ui/utils/theme_extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:how_much/presentation/router/app_router.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: const [
        RecordRoute(),
        AccountRoute(),
        HistoryRoute(),
        SettingRoute(),
      ],
      builder: (context, child, controller) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          backgroundColor: context.theme.appColors.background,
          body: child,
          bottomNavigationBar: SizedBox(
            height: 64,
            child: BottomNavigationBar(
              elevation: 12,
              backgroundColor: context.theme.appColors.ink.darkest,
              iconSize: 24,
              selectedLabelStyle: FigmaTextStyles.tinyNoneRegular
                  .copyWith(color: context.theme.appColors.onBackground),
              unselectedLabelStyle: FigmaTextStyles.tinyNoneRegular
                  .copyWith(color: context.theme.appColors.sky.dark),
              showUnselectedLabels: true,
              currentIndex: tabsRouter.activeIndex,
              onTap: tabsRouter.setActiveIndex,
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
                    label: 'Account',
                    icon: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.wallet_outlined),
                    )),
                BottomNavigationBarItem(
                    label: 'History',
                    icon: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(Icons.bar_chart_outlined),
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
