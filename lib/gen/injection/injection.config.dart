// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i4;

import '../../data/repository/account_repository.dart' as _i12;
import '../../data/repository/category_repository.dart' as _i14;
import '../../data/repository/language_repository.dart' as _i15;
import '../../data/repository/security_repository.dart' as _i6;
import '../../data/repository/transaction_repository.dart' as _i8;
import '../../data/repository/transfer_log_repository.dart' as _i10;
import '../../data/services/secure_storage_service.dart' as _i5;
import '../../data/source/account_local_source.dart' as _i11;
import '../../data/source/category_local_source.dart' as _i13;
import '../../data/source/transaction_local_source.dart' as _i7;
import '../../data/source/transfer_log_local_source.dart' as _i9;
import '../../presentation/provider/pin_auth/pin_auth_provider.dart' as _i16;
import '../../presentation/router/app_router.dart' as _i17;
import 'injection.dart' as _i18;

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
    await gh.factoryAsync<_i4.Isar>(
      () => registerModule.isar,
      preResolve: true,
    );
    gh.singleton<_i5.SecureStorageService>(
        _i5.SecureStorageService(gh<_i3.FlutterSecureStorage>()));
    gh.factory<_i6.SecurityRepository>(
        () => _i6.SecurityRepository(gh<_i5.SecureStorageService>()));
    gh.factory<String>(
      () => registerModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.factory<_i7.TransactionLocalSource>(
        () => _i7.TransactionLocalSource(gh<_i4.Isar>()));
    gh.factory<_i8.TransactionRepository>(
        () => _i8.TransactionRepository(gh<_i7.TransactionLocalSource>()));
    gh.factory<_i9.TransferLogLocalSource>(
        () => _i9.TransferLogLocalSource(gh<_i4.Isar>()));
    gh.factory<_i10.TransferLogRepository>(
        () => _i10.TransferLogRepository(gh<_i9.TransferLogLocalSource>()));
    gh.factory<_i11.AccountLocalSource>(
        () => _i11.AccountLocalSource(gh<_i4.Isar>()));
    gh.factory<_i12.AccountRepository>(
        () => _i12.AccountRepository(gh<_i11.AccountLocalSource>()));
    gh.factory<_i13.CategoryLocalSource>(
        () => _i13.CategoryLocalSource(gh<_i4.Isar>()));
    gh.factory<_i14.CategoryRepository>(
        () => _i14.CategoryRepository(gh<_i13.CategoryLocalSource>()));
    gh.factory<_i15.LanguageRepository>(
        () => _i15.LanguageRepository(gh<_i5.SecureStorageService>()));
    gh.factory<_i16.PinAuthSecurityNotifier>(
        () => _i16.PinAuthSecurityNotifier(gh<_i6.SecurityRepository>()));
    gh.factory<_i17.SecureAppIsActive>(
        () => _i17.SecureAppIsActive(gh<_i6.SecurityRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i18.RegisterModule {}
