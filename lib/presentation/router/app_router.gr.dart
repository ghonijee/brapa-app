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
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MainPage(),
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
        ),
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
    required Account data,
    List<PageRouteInfo>? children,
  }) : super(
          DetailAccountRoute.name,
          args: DetailAccountRouteArgs(
            key: key,
            data: data,
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
    required this.data,
  });

  final Key? key;

  final Account data;

  @override
  String toString() {
    return 'DetailAccountRouteArgs{key: $key, data: $data}';
  }
}
