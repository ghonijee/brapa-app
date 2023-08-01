// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:isar/isar.dart' as _i3;

import '../../data/repository/account_repository.dart' as _i7;
import '../../data/repository/category_repository.dart' as _i9;
import '../../data/repository/transaction_repository.dart' as _i5;
import '../../data/source/account_local_source.dart' as _i6;
import '../../data/source/category_local_source.dart' as _i8;
import '../../data/source/transaction_local_source.dart' as _i4;
import 'injection.dart' as _i10;

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
    await gh.factoryAsync<_i3.Isar>(
      () => registerModule.isar,
      preResolve: true,
    );
    gh.factory<String>(
      () => registerModule.baseUrl,
      instanceName: 'BaseUrl',
    );
    gh.factory<_i4.TransactionLocalSource>(
        () => _i4.TransactionLocalSource(gh<_i3.Isar>()));
    gh.factory<_i5.TransactionRepository>(
        () => _i5.TransactionRepository(gh<_i4.TransactionLocalSource>()));
    gh.factory<_i6.AccountLocalSource>(
        () => _i6.AccountLocalSource(gh<_i3.Isar>()));
    gh.factory<_i7.AccountRepository>(
        () => _i7.AccountRepository(gh<_i6.AccountLocalSource>()));
    gh.factory<_i8.CategoryLocalSource>(
        () => _i8.CategoryLocalSource(gh<_i3.Isar>()));
    gh.factory<_i9.CategoryRepository>(
        () => _i9.CategoryRepository(gh<_i8.CategoryLocalSource>()));
    return this;
  }
}

class _$RegisterModule extends _i10.RegisterModule {}
