// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    SettingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingPage(),
      );
    },
    RecordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const RecordPage(),
      );
    },
    ChangePINRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChangePINPage(),
      );
    },
    SecurityRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SecurityPage(),
      );
    },
    DetailCategoryRoute.name: (routeData) {
      final args = routeData.argsAs<DetailCategoryRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailCategoryPage(
          key: args.key,
          data: args.data,
          formMode: args.formMode,
          label: args.label,
          type: args.type,
        ),
      );
    },
    ManageCategoriesRoute.name: (routeData) {
      final args = routeData.argsAs<ManageCategoriesRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ManageCategoriesPage(
          key: args.key,
          label: args.label,
          type: args.type,
        ),
      );
    },
    HistoryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HistoryPage(),
      );
    },
    RecordDetailRoute.name: (routeData) {
      final args = routeData.argsAs<RecordDetailRouteArgs>(
          orElse: () => const RecordDetailRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RecordDetailPage(
          key: args.key,
          transaction: args.transaction,
        ),
      );
    },
    AccountRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AccountPage(),
      );
    },
    ManageAccountsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ManageAccountsPage(),
      );
    },
    DetailAccountRoute.name: (routeData) {
      final args = routeData.argsAs<DetailAccountRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DetailAccountPage(
          key: args.key,
          data: args.data,
          formMode: args.formMode,
        ),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    PinAuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PinAuthPage(),
      );
    },
    SplashRouteRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreenPage(),
      );
    },
  };
}

/// generated route for
/// [SettingPage]
class SettingRoute extends PageRouteInfo<void> {
  const SettingRoute({List<PageRouteInfo>? children})
      : super(
          SettingRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RecordPage]
class RecordRoute extends PageRouteInfo<void> {
  const RecordRoute({List<PageRouteInfo>? children})
      : super(
          RecordRoute.name,
          initialChildren: children,
        );

  static const String name = 'RecordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChangePINPage]
class ChangePINRoute extends PageRouteInfo<void> {
  const ChangePINRoute({List<PageRouteInfo>? children})
      : super(
          ChangePINRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChangePINRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SecurityPage]
class SecurityRoute extends PageRouteInfo<void> {
  const SecurityRoute({List<PageRouteInfo>? children})
      : super(
          SecurityRoute.name,
          initialChildren: children,
        );

  static const String name = 'SecurityRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DetailCategoryPage]
class DetailCategoryRoute extends PageRouteInfo<DetailCategoryRouteArgs> {
  DetailCategoryRoute({
    Key? key,
    Category? data,
    required FormCategoryType formMode,
    String? label,
    required CategoryType type,
    List<PageRouteInfo>? children,
  }) : super(
          DetailCategoryRoute.name,
          args: DetailCategoryRouteArgs(
            key: key,
            data: data,
            formMode: formMode,
            label: label,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailCategoryRoute';

  static const PageInfo<DetailCategoryRouteArgs> page =
      PageInfo<DetailCategoryRouteArgs>(name);
}

class DetailCategoryRouteArgs {
  const DetailCategoryRouteArgs({
    this.key,
    this.data,
    required this.formMode,
    this.label,
    required this.type,
  });

  final Key? key;

  final Category? data;

  final FormCategoryType formMode;

  final String? label;

  final CategoryType type;

  @override
  String toString() {
    return 'DetailCategoryRouteArgs{key: $key, data: $data, formMode: $formMode, label: $label, type: $type}';
  }
}

/// generated route for
/// [ManageCategoriesPage]
class ManageCategoriesRoute extends PageRouteInfo<ManageCategoriesRouteArgs> {
  ManageCategoriesRoute({
    Key? key,
    required String label,
    required CategoryType type,
    List<PageRouteInfo>? children,
  }) : super(
          ManageCategoriesRoute.name,
          args: ManageCategoriesRouteArgs(
            key: key,
            label: label,
            type: type,
          ),
          initialChildren: children,
        );

  static const String name = 'ManageCategoriesRoute';

  static const PageInfo<ManageCategoriesRouteArgs> page =
      PageInfo<ManageCategoriesRouteArgs>(name);
}

class ManageCategoriesRouteArgs {
  const ManageCategoriesRouteArgs({
    this.key,
    required this.label,
    required this.type,
  });

  final Key? key;

  final String label;

  final CategoryType type;

  @override
  String toString() {
    return 'ManageCategoriesRouteArgs{key: $key, label: $label, type: $type}';
  }
}

/// generated route for
/// [HistoryPage]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RecordDetailPage]
class RecordDetailRoute extends PageRouteInfo<RecordDetailRouteArgs> {
  RecordDetailRoute({
    Key? key,
    Transaction? transaction,
    List<PageRouteInfo>? children,
  }) : super(
          RecordDetailRoute.name,
          args: RecordDetailRouteArgs(
            key: key,
            transaction: transaction,
          ),
          initialChildren: children,
        );

  static const String name = 'RecordDetailRoute';

  static const PageInfo<RecordDetailRouteArgs> page =
      PageInfo<RecordDetailRouteArgs>(name);
}

class RecordDetailRouteArgs {
  const RecordDetailRouteArgs({
    this.key,
    this.transaction,
  });

  final Key? key;

  final Transaction? transaction;

  @override
  String toString() {
    return 'RecordDetailRouteArgs{key: $key, transaction: $transaction}';
  }
}

/// generated route for
/// [AccountPage]
class AccountRoute extends PageRouteInfo<void> {
  const AccountRoute({List<PageRouteInfo>? children})
      : super(
          AccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'AccountRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ManageAccountsPage]
class ManageAccountsRoute extends PageRouteInfo<void> {
  const ManageAccountsRoute({List<PageRouteInfo>? children})
      : super(
          ManageAccountsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ManageAccountsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DetailAccountPage]
class DetailAccountRoute extends PageRouteInfo<DetailAccountRouteArgs> {
  DetailAccountRoute({
    Key? key,
    Account? data,
    required FormAccountType formMode,
    List<PageRouteInfo>? children,
  }) : super(
          DetailAccountRoute.name,
          args: DetailAccountRouteArgs(
            key: key,
            data: data,
            formMode: formMode,
          ),
          initialChildren: children,
        );

  static const String name = 'DetailAccountRoute';

  static const PageInfo<DetailAccountRouteArgs> page =
      PageInfo<DetailAccountRouteArgs>(name);
}

class DetailAccountRouteArgs {
  const DetailAccountRouteArgs({
    this.key,
    this.data,
    required this.formMode,
  });

  final Key? key;

  final Account? data;

  final FormAccountType formMode;

  @override
  String toString() {
    return 'DetailAccountRouteArgs{key: $key, data: $data, formMode: $formMode}';
  }
}

/// generated route for
/// [MainPage]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PinAuthPage]
class PinAuthRoute extends PageRouteInfo<void> {
  const PinAuthRoute({List<PageRouteInfo>? children})
      : super(
          PinAuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'PinAuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreenPage]
class SplashRouteRoute extends PageRouteInfo<void> {
  const SplashRouteRoute({List<PageRouteInfo>? children})
      : super(
          SplashRouteRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRouteRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
