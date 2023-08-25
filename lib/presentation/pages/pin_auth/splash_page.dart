import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/gen/assets.gen.dart';
import 'package:brapa/presentation/provider/pin_auth/pin_auth_provider.dart';
import 'package:brapa/presentation/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

@RoutePage()
class SplashScreenPage extends ConsumerWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.delayed(const Duration(milliseconds: 1500), () {
      final state = ref.watch(pinAuthProvider);
      if (state.secureAppActive) {
        context.router.replace(const PinAuthRoute());
      } else {
        context.router.popUntilRoot();
        context.router.replace(const MainRoute());
      }
    });
    return Scaffold(
      backgroundColor: context.colors.background,
      body: Center(
        child: Assets.launcher.roundLauncher.image(width: 20.w),
      ),
    );
  }
}
