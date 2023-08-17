import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/presentation/provider/setting/security_provider.dart';
import 'package:brapa/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:local_auth/local_auth.dart';

@RoutePage()
class SecurityPage extends HookConsumerWidget {
  const SecurityPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(securitySettingProvider);
    var controller = ref.read(securitySettingProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const TextUI.largeNoneBold("Security"),
        backgroundColor: context.colors.background,
      ),
      backgroundColor: context.colors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const TextUI.regularNoneRegular("Secure App"),
              trailing: Switch.adaptive(
                value: state.secureAppActive,
                activeColor: context.colors.primary.light,
                onChanged: (value) {
                  if (value && !state.pinHaveBeenSet) {
                    context.router.push(const ChangePINRoute()).then((value) {
                      controller.switchSecureApp();
                    });
                    return;
                  }

                  // Check PIN or Biometrik
                  controller.switchSecureApp();
                },
              ),
            ),
            FreeSpaceUI.vertical(8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              enabled: state.secureAppActive,
              title: TextUI.regularNoneRegular(
                "Change PIN",
                color: state.secureAppActive ? context.colors.onBackground : context.colors.ink.light,
              ),
              onTap: () {
                context.router.push(const ChangePINRoute());
                // print("hallo");
              },
            ),
            FreeSpaceUI.vertical(8),
            WidgetUI.visibility(
              visibility: controller.deviceSupportBiometrik ?? false,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                enabled: state.secureAppActive,
                title: TextUI.regularNoneRegular(
                  "Biometrik",
                  color: state.secureAppActive ? context.colors.onBackground : context.colors.ink.light,
                ),
                trailing: Switch.adaptive(
                  value: state.useBiometriLock,
                  activeColor: context.colors.primary.light,
                  onChanged: (value) async {
                    final LocalAuthentication localAuth = LocalAuthentication();
                    final bool canAuthenticateWithBiometrics = await localAuth.canCheckBiometrics;
                    if (!canAuthenticateWithBiometrics) {
                      return;
                    }
                    bool authenticated = await localAuth.authenticate(
                        localizedReason: "Scan for enable biometrik",
                        options: const AuthenticationOptions(
                          biometricOnly: true,
                          useErrorDialogs: true,
                          stickyAuth: false,
                        ));
                    if (authenticated) {
                      controller.switchUseBiometrik();
                    } else {}
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
