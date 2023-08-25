import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:brapa/data/services/isar_service.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  // You can register named preemptive types like follows
  @Named("BaseUrl")
  String get baseUrl => 'My base url';

  @preResolve
  Future<Isar> get isar => IsarService.init();

  FlutterSecureStorage get secureStorage =>
      const FlutterSecureStorage(aOptions: AndroidOptions(encryptedSharedPreferences: true));

  GlobalKey<NavigatorState> get globalKey => GlobalKey<NavigatorState>();
  // url here will be injected
  // @lazySingleton
  // Dio dio(@Named('BaseUrl') String url) => Dio(BaseOptions(baseUrl: url));

  // same thing works for instances that's gotten asynchronous.
  // all you need to do is wrap your instance with a future and tell injectable how
  // to initialize it
  // @preResolve // if you need to pre resolve the value
  // Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  // Also, make sure you await for your configure function before running the App.
}
