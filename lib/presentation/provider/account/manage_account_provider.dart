import 'dart:developer';

import 'package:app_ui/app_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_much/data/repository/account_repository.dart';
import 'package:how_much/domain/account.dart';
import 'package:how_much/gen/injection/injection.dart';

class ManageAccountNotifier extends StateNotifier<Account> {
  final AccountRepository repository;

  ManageAccountNotifier(this.repository) : super(Account(name: ""));

  showAccount(Account data) {
    state = data;
  }

  saveUpdate({
    required String name,
    required String balance,
    required bool isActive,
    required String assetsPath,
  }) async {
    state = state.copyWith(name: name, balance: balance.toNumber(), isActive: isActive, assets: assetsPath);

    await repository.update(state);
  }

  store({
    required String name,
    required String balance,
    required bool isActive,
    required String assetsPath,
  }) async {
    state = Account(name: name, balance: balance.toNumber(), isActive: isActive, assets: assetsPath);

    await repository.store(state);
  }

  delete() async {
    await repository.destroy(state);
  }
}

final manageAccountProvider = StateNotifierProvider((ref) => ManageAccountNotifier(getIt<AccountRepository>()));
