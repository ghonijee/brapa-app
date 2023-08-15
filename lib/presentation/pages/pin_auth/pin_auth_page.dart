import 'package:app_ui/app_ui.dart';
import 'package:app_ui/token/figma_token.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/presentation/app.dart';
import 'package:brapa/presentation/provider/setting/security_provider.dart';
import 'package:brapa/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../provider/pin_auth/pin_auth_provider.dart';
import '../security/widgets/pin_keyboard.dart';

@RoutePage()
class PinAuthPage extends HookConsumerWidget {
  const PinAuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pinTextController = useTextEditingController();
    final pinAuthState = ref.watch(pinAuthProvider);
    final errorPin = useState(false);

    return Scaffold(
      backgroundColor: context.colors.background,
      body: SizedBox(
        width: 100.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Icon(
              IonIcons.lock_closed,
              size: 42,
            ),
            FreeSpaceUI.vertical(20),
            const TextUI.titleRegular("Enter your PIN"),
            FreeSpaceUI.vertical(32),
            Pinput(
              controller: pinTextController,
              keyboardType: TextInputType.none,
              length: 4,
              obscureText: true,
              crossAxisAlignment: CrossAxisAlignment.center,
              errorTextStyle: FigmaTextStyles.largeTightRegular.copyWith(color: context.colors.red.darkest),
              onChanged: (value) {
                errorPin.value = false;
                print(value);
              },
              obscuringWidget: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: context.colors.primary.darkest,
                  border: Border.all(color: context.colors.primary.light, width: 2),
                  borderRadius: BorderRadius.circular(90),
                ),
              ),
              defaultPinTheme: PinTheme(
                margin: const EdgeInsets.symmetric(horizontal: 12),
                width: 16,
                height: 16,
                textStyle: FigmaTextStyles.largeNormalMedium,
                decoration: BoxDecoration(
                  color: context.colors.ink.darkest,
                  // border: Border.all(color: context.colors.ink.dark, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onCompleted: (value) {
                if (pinAuthState.pinValidate(value)) {
                  context.router.replace(const MainRoute());
                } else {
                  errorPin.value = true;
                }
              },
            ),
            FreeSpaceUI.vertical(24),
            WidgetUI.visibility(
                visibility: errorPin.value,
                child: TextUI.regularNoneRegular(
                  "PIN is incorrect",
                  color: context.colors.red.base,
                )),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: PinKeyboardWidget(
                controller: pinTextController,
                leftKey: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      // color: context.colors.ink.darker,
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: Center(
                        child: Icon(
                      IonIcons.finger_print,
                      size: 36,
                      color: context.colors.primary.darkest,
                    )),
                  ),
                  onTap: () {
                    //
                  },
                ),
              ),
            ),
            FreeSpaceUI.vertical(60),
          ],
        ),
      ),
    );
  }
}
