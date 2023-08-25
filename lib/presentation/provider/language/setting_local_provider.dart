import 'dart:async';

import 'package:brapa/data/repository/language_repository.dart';
import 'package:brapa/gen/injection/injection.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingLocalNotifier extends StateNotifier<Locale> {
  final LanguageRepository languageRepository;
  SettingLocalNotifier(this.languageRepository) : super(const Locale("en")) {
    init();
  }
  void init() async {
    var result = await languageRepository.getLocale();
    state = Locale(result ?? "en");
  }

  Future<void> changeLocal(String locale) async {
    await languageRepository.setLocale(locale);
    state = Locale(locale);
  }
}

final settingLocalProvider = AutoDisposeStateNotifierProvider<SettingLocalNotifier, Locale>(
    (ref) => SettingLocalNotifier(getIt<LanguageRepository>()));
