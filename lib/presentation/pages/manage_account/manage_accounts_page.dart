import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_much/gen/assets.gen.dart';
import 'package:how_much/presentation/router/app_router.dart';

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
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    var account = data[index];
                    return ListTile(
                      onTap: () {
                        context.router.push(DetailAccountRoute(data: account));
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        width: 80,
                        height: 40,
                        child: Image.asset(
                          account.assets!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      title: TextUI.regularTightRegular(account.name),
                      subtitle: TextUI.smallTightRegular(
                        account.balance!.currency(),
                        color: context.colors.sky.dark,
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
