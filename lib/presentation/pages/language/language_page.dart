import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/gen/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/language/setting_local_provider.dart';

@RoutePage()
class LanguagePage extends ConsumerWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localeState = ref.watch(settingLocalProvider);
    final localeController = ref.watch(settingLocalProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: TextUI.largeNoneBold(
          S.of(context).language,
        ),
        backgroundColor: context.colors.background,
      ),
      backgroundColor: context.colors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            ListTile(
              title: const TextUI.regularTightRegular("English"),
              onTap: () async {
                await localeController.changeLocal("en");
              },
              trailing: localeState.languageCode == "en"
                  ? Icon(
                      Icons.check_circle,
                      color: context.colors.primary.base,
                    )
                  : null,
            ),
            FreeSpaceUI.vertical(8),
            ListTile(
              title: const TextUI.regularTightRegular("Indonesia"),
              onTap: () async {
                await localeController.changeLocal("id");
              },
              trailing: localeState.languageCode == "id"
                  ? Icon(
                      Icons.check_circle,
                      color: context.colors.primary.base,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
