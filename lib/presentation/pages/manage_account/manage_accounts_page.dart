import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:brapa/presentation/pages/pages.dart';
import 'package:brapa/presentation/provider/account/manage_account_provider.dart';
import 'package:brapa/presentation/router/app_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../provider/account/get_list_account_provider.dart';

@RoutePage()
class ManageAccountsPage extends HookConsumerWidget {
  const ManageAccountsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listAccounts = ref.watch(listAccountProvider);
    var listAccountsController = ref.watch(listAccountProvider.notifier);

    var reorderListActive = useState(false);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: reorderListActive.value
              ? const TextUI.largeNoneBold("Reorder Accounts")
              : const TextUI.largeNoneBold("Accounts"),
          backgroundColor: context.colors.background,
          actions: [
            reorderListActive.value
                ? GestureDetector(
                    onTap: () async {
                      await listAccountsController.saveReorder();
                      reorderListActive.value = false;
                    },
                    child: Icon(
                      Icons.check_rounded,
                      color: context.colors.onBackground,
                    ),
                  )
                : Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          WidgetUI.showBottomSheet(context,
                              height: 20.h,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const TextUI.regularNormalBold("Manage Account Tips"),
                                    FreeSpaceUI.vertical(20),
                                    const TextUI.smallNoneRegular(
                                        "Press and hold the item to active reoder list feature"),
                                  ],
                                ),
                              ));
                        },
                        child: Icon(
                          Icons.help_outline_rounded,
                          color: context.colors.onBackground,
                        ),
                      ),
                      FreeSpaceUI.horizontal(16),
                      GestureDetector(
                        onTap: () => context.router.push(DetailAccountRoute(formMode: FormAccountType.create)),
                        child: Icon(
                          Icons.add_card,
                          color: context.colors.onBackground,
                        ),
                      ),
                    ],
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
                if (reorderListActive.value) {
                  return ReorderableListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      var account = data[index];
                      return ListTile(
                        key: Key(account.id.toString()),
                        contentPadding: EdgeInsets.zero,
                        onTap: null,
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            account.assets!,
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
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
                    onReorder: (oldIndex, newIndex) {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final tempItem = data.removeAt(oldIndex);
                      data.insert(newIndex, tempItem);
                      listAccountsController.reorderData(data);
                    },
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    var account = data[index];
                    return ListTile(
                      onLongPress: () => reorderListActive.value = true,
                      onTap: () {
                        ref.watch(manageAccountProvider.notifier).showAccount(account);
                        context.router.push(DetailAccountRoute(data: account, formMode: FormAccountType.update));
                      },
                      contentPadding: EdgeInsets.zero,
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          account.assets!,
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
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
