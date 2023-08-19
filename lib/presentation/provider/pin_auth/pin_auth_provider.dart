import 'package:brapa/data/repository/security_repository.dart';
import 'package:brapa/domain/security_setting.dart';
import 'package:brapa/gen/injection/injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

@injectable
class PinAuthSecurityNotifier extends StateNotifier<SecuritySetting> {
  final SecurityRepository repository;
  bool? deviceSupportBiometrik = false;

  PinAuthSecurityNotifier(this.repository) : super(SecuritySetting()) {
    init();
  }

  init() async {
    var securAppValue = await repository.getSecureApp();
    var pinSecurityValue = await repository.getPIN();
    var useBiometrikValue = await repository.getUseBiometrik();
    final LocalAuthentication localAuth = LocalAuthentication();
    deviceSupportBiometrik = await localAuth.canCheckBiometrics;
    // deviceSupportBiometrik = false;

    if (!mounted) return;

    state = state.copyWith(
      pin: pinSecurityValue,
      secureAppActive: securAppValue,
      useBiometriLock: useBiometrikValue,
    );
  }
}

@injectable
final pinAuthProvider = AutoDisposeStateNotifierProvider<PinAuthSecurityNotifier, SecuritySetting>(
    (ref) => PinAuthSecurityNotifier(getIt<SecurityRepository>()));
