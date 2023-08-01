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

import '../../data/repository/category_repository.dart' as _i5;
import '../../data/source/category_local_source.dart' as _i4;
import 'injection.dart' as _i6;

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
    gh.factory<_i4.CategoryLocalSource>(
        () => _i4.CategoryLocalSource(gh<_i3.Isar>()));
    gh.factory<_i5.CategoryRepository>(
        () => _i5.CategoryRepository(gh<_i4.CategoryLocalSource>()));
    return this;
  }
}

class _$RegisterModule extends _i6.RegisterModule {}
