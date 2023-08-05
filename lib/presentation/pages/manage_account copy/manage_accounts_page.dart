import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brapa/presentation/pages/pages.dart';
import 'package:brapa/presentation/provider/account/manage_account_provider.dart';
import 'package:brapa/presentation/router/app_router.dart';

import '../../provider/account/get_list_account_provider.dart';

@RoutePage()
class ManageAccountsPage extends ConsumerWidget {
  const ManageAccountsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listAccounts = ref.watch(listAccountProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const TextUI.titleRegular("Accounts"),
          backgroundColor: context.colors.background,
          actions: [
            GestureDetector(
              onTap: () => context.router.push(DetailAccountRoute(formMode: FormAccountType.create)),
              child: Icon(
                Icons.add_card,
                color: context.colors.onBackground,
              ),
            ),
            FreeSpaceUI.horizontal(24),
          ],
        ),
        backgroundColor: context.colors.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FreeSpaceUI.vertical(12),
              Expanded(
                  child: listAccounts.when(data: (data) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var account = data[index];
                    return ListTile(
                      onTap: () {
                        ref.watch(manageAccountProvider.notifier).showAccount(account);
                        context.router.push(DetailAccountRoute(data: account, formMode: FormAccountType.update));
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        width: 80,
                        height: 40,
                        decoration: BoxDecoration(),
                        child: Image.asset(
                          account.assets!,
                          fit: BoxFit.fitHeight,
                          color: account.isActive! ? null : Colors.grey,
                          colorBlendMode: BlendMode.color,
                        ),
                      ),
                      title: TextUI.regularTightBold(
                        account.name,
                        color: account.isActive! ? context.colors.onBackground : context.colors.ink.light,
                      ),
                      subtitle: TextUI.smallNoneRegular(
                        account.balance!.currency(),
                        color: context.colors.sky.base,
                      ),
                    );
                  },
                );
              }, error: (e, s) {
                return const SizedBox(
                  child: TextUI.regularNoneRegular("Something wrong, please try later!"),
                );
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })),
              // Body COntent
            ],
          ),
        ),
      ),
    );
  }
}
