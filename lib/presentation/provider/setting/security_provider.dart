import 'package:brapa/data/repository/security_repository.dart';
import 'package:brapa/domain/security_setting.dart';
import 'package:brapa/gen/injection/injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

class SecuritySettingNotifier extends StateNotifier<SecuritySetting> {
  final SecurityRepository repository;
  bool? deviceSupportBiometrik;
  SecuritySettingNotifier(this.repository) : super(SecuritySetting()) {
    init();
  }

  init() async {
    var securAppValue = await repository.getSecureApp();
    var pinSecurityValue = await repository.getPIN();
    var useBiometrikValue = await repository.getUseBiometrik();
    final LocalAuthentication localAuth = LocalAuthentication();
    deviceSupportBiometrik = await localAuth.canCheckBiometrics;

    state = state.copyWith(
      pin: pinSecurityValue,
      secureAppActive: securAppValue,
      useBiometriLock: useBiometrikValue,
    );
  }

  switchSecureApp() async {
    state = state.copyWith(secureAppActive: !state.secureAppActive);
    // state.toggleSecureActive();
    await repository.setSecureApp(state.secureAppActive);
  }

  switchUseBiometrik() async {
    state = state.copyWith(useBiometriLock: !state.useBiometriLock);
    await repository.setUseBiometrik(state.useBiometriLock);
  }

  Future<void> storePin(String value) async {
    state.pin = value;
    await repository.setPIN(value);
  }
}

final securitySettingProvider = AutoDisposeStateNotifierProvider<SecuritySettingNotifier, SecuritySetting>(
    (ref) => SecuritySettingNotifier(getIt<SecurityRepository>()));
