import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:brapa/presentation/app.dart';
import '../../domain/account.dart';
import '../../domain/category.dart';
import '../../domain/transaction.dart';
import '../pages/pages.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: MainRoute.page,
          initial: true,
          children: [
            AutoRoute(page: RecordRoute.page, maintainState: true),
            AutoRoute(page: AccountRoute.page),
            AutoRoute(page: HistoryRoute.page),
            AutoRoute(page: SettingRoute.page),
          ],
        ),
        AutoRoute(page: RecordDetailRoute.page),
        AutoRoute(page: ManageAccountsRoute.page),
        AutoRoute(page: DetailAccountRoute.page),
        AutoRoute(page: ManageCategoriesRoute.page),
        AutoRoute(page: DetailCategoryRoute.page),
        AutoRoute(page: SecurityRoute.page),
        AutoRoute(page: ChangePINRoute.page),
        AutoRoute(page: PinAuthRoute.page),
      ];
}
