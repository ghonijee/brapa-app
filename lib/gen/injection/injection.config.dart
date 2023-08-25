// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i4;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i5;

import '../../data/repository/account_repository.dart' as _i13;
import '../../data/repository/category_repository.dart' as _i15;
import '../../data/repository/language_repository.dart' as _i16;
import '../../data/repository/security_repository.dart' as _i7;
import '../../data/repository/transaction_repository.dart' as _i9;
import '../../data/repository/transfer_log_repository.dart' as _i11;
import '../../data/services/secure_storage_service.dart' as _i6;
import '../../data/source/account_local_source.dart' as _i12;
import '../../data/source/category_local_source.dart' as _i14;
import '../../data/source/transaction_local_source.dart' as _i8;
import '../../data/source/transfer_log_local_source.dart' as _i10;
import '../../presentation/provider/pin_auth/pin_auth_provider.dart' as _i17;
import '../../presentation/router/app_router.dart' as _i18;
import 'injection.dart' as _i19;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.factory<_i3.FlutterSecureStorage>(() => registerModule.secureStorage);
    gh.factory<_i4.GlobalKey<_i4.NavigatorState>>(
        () => registerModule.globalKey);
    await gh.factoryAsync<_i5.Isar>(
      () => registerModule.isar,
      preResolve: true,
    );
    gh.singleton<_i6.SecureStorageService>(
        _i6.SecureStorageService(gh<_i3.FlutterSecureStorage>()));
    gh.factory<_i7.SecurityRepository>(
        () => _i7.SecurityRepository(gh<_i6.SecureStorageService>()));
    gh.factory<String>(
      () => registerModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.factory<_i8.TransactionLocalSource>(
        () => _i8.TransactionLocalSource(gh<_i5.Isar>()));
    gh.factory<_i9.TransactionRepository>(
        () => _i9.TransactionRepository(gh<_i8.TransactionLocalSource>()));
    gh.factory<_i10.TransferLogLocalSource>(
        () => _i10.TransferLogLocalSource(gh<_i5.Isar>()));
    gh.factory<_i11.TransferLogRepository>(
        () => _i11.TransferLogRepository(gh<_i10.TransferLogLocalSource>()));
    gh.factory<_i12.AccountLocalSource>(
        () => _i12.AccountLocalSource(gh<_i5.Isar>()));
    gh.factory<_i13.AccountRepository>(
        () => _i13.AccountRepository(gh<_i12.AccountLocalSource>()));
    gh.factory<_i14.CategoryLocalSource>(
        () => _i14.CategoryLocalSource(gh<_i5.Isar>()));
    gh.factory<_i15.CategoryRepository>(
        () => _i15.CategoryRepository(gh<_i14.CategoryLocalSource>()));
    gh.factory<_i16.LanguageRepository>(
        () => _i16.LanguageRepository(gh<_i6.SecureStorageService>()));
    gh.factory<_i17.PinAuthSecurityNotifier>(
        () => _i17.PinAuthSecurityNotifier(gh<_i7.SecurityRepository>()));
    gh.factory<_i18.SecureAppIsActive>(
        () => _i18.SecureAppIsActive(gh<_i7.SecurityRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i19.RegisterModule {}
