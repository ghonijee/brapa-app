// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:app_ui/app_ui.dart';
import 'package:brapa/data/repository/account_repository.dart';
import 'package:brapa/domain/account.dart';
import 'package:brapa/gen/injection/injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

class TransferAccountState {
  Account? from;
  Account? to;
  int amount;

  TransferAccountState({
    this.from,
    this.to,
    this.amount = 0,
  });

  TransferAccountState copyWith({
    Account? from,
    Account? to,
    int? amount,
  }) {
    return TransferAccountState(
      from: from ?? this.from,
      to: to ?? this.to,
      amount: amount ?? this.amount,
    );
  }
}

class TransferAccountNotifier extends StateNotifier<TransferAccountState> {
  final AccountRepository repository;
  TransferAccountNotifier(this.repository) : super(TransferAccountState());

  initTransfer(Account from) {
    state = state.copyWith(from: from);
    print(state.from!.name);
  }

  selectedTargetAccount(Account target) {
    state = state.copyWith(to: target);
    print(state.to!.name);
  }

  setAmount(String value) {
    state = state.copyWith(amount: value.toNumber());
  }

  Future<bool> transfer() async {
    // 1. Check Saldo From Account
    if (state.from!.balance! < state.amount) {
      return false;
    }

    try {
      state.from!.decrease(state.amount);
      await repository.update(state.from!);
      state.to!.increase(state.amount);
      await repository.update(state.to!);
    } catch (e) {
      return false;
    }
    return true;
  }
}

@injectable
final transferAccountProvider = StateNotifierProvider<TransferAccountNotifier, TransferAccountState>(
    (ref) => TransferAccountNotifier(getIt<AccountRepository>()));
