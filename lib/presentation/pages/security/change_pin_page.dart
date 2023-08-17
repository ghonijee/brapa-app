import 'package:app_ui/app_ui.dart';
import 'package:app_ui/token/figma_token.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/presentation/pages/security/widgets/pin_keyboard.dart';
import 'package:brapa/presentation/provider/setting/security_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pinput/pinput.dart';

@RoutePage()
class ChangePINPage extends HookConsumerWidget {
  const ChangePINPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinController = useTextEditingController();
    final controller = ref.watch(securitySettingProvider.notifier);
    final state = ref.watch(securitySettingProvider);
    return Scaffold(
      backgroundColor: context.colors.background,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Spacer(),
          const Icon(
            IonIcons.lock_closed,
            size: 52,
          ),
          FreeSpaceUI.vertical(20),
          const TextUI.largeTightBold(
            "Set PIN to secure your data",
            textAlign: TextAlign.center,
          ),
          FreeSpaceUI.vertical(40),
          Pinput(
            controller: pinController,
            keyboardType: TextInputType.none,
            length: 4,
            crossAxisAlignment: CrossAxisAlignment.center,
            defaultPinTheme: PinTheme(
              width: 56,
              height: 56,
              textStyle: FigmaTextStyles.largeNormalMedium,
              decoration: BoxDecoration(
                border: Border.all(color: context.colors.ink.light),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) async {
              await controller.storePin(value);
            },
          ),
          const Spacer(),
          SizedBox(
            child: PinKeyboardWidget(
              controller: pinController,
            ),
          ),
          FreeSpaceUI.vertical(40),
          ElevatedButton(
            onPressed: state.pinIsValid
                ? () async {
                    if (pinController.length < 4) {
                      return;
                    }
                    await controller.storePin(pinController.text).then((value) {
                      context.router.pop();
                    });
                  }
                : null,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(48),
              backgroundColor: context.colors.primary.base,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const TextUI.regularNoneRegular("Save"),
          ),
          FreeSpaceUI.vertical(24),
        ]),
      ),
    );
  }
}
