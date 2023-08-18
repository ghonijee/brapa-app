import 'package:auto_route/auto_route.dart';
import 'package:brapa/data/repository/security_repository.dart';
import 'package:flutter/material.dart';
import 'package:brapa/presentation/app.dart';
import 'package:injectable/injectable.dart';
import '../../domain/account.dart';
import '../../domain/category.dart';
import '../../domain/transaction.dart';
import '../pages/pages.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(initial: true, page: SplashRouteRoute.page),
        AutoRoute(
          page: MainRoute.page,
          children: [
            AutoRoute(page: RecordRoute.page),
            AutoRoute(page: AccountRoute.page),
            AutoRoute(page: HistoryRoute.page),
            AutoRoute(page: SettingRoute.page),
          ],
        ),
        AutoRoute(page: RecordDetailRoute.page),
        AutoRoute(page: RecordFormRoute.page),
        AutoRoute(page: TransferFormRoute.page),
        AutoRoute(page: TransferDetailRoute.page),
        AutoRoute(page: ManageAccountsRoute.page),
        AutoRoute(page: DetailAccountRoute.page),
        AutoRoute(page: ManageCategoriesRoute.page),
        AutoRoute(page: DetailCategoryRoute.page),
        AutoRoute(page: SecurityRoute.page),
        AutoRoute(page: ChangePINRoute.page),
        AutoRoute(page: PinAuthRoute.page),
      ];
}

@injectable
class SecureAppIsActive extends AutoRouteGuard {
  final SecurityRepository securityRepository;

  SecureAppIsActive(this.securityRepository);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    var securAppValue = await securityRepository.getSecureApp();
    if (securAppValue) {
      router.push(const PinAuthRoute());
      return;
    }

    resolver.next(true);
  }
}
