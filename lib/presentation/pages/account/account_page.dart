import 'package:app_ui/app_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/gen/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:brapa/domain/account.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../provider/account/get_list_account_provider.dart';
import 'widgets/account_card_widget.dart';
import 'widgets/account_menu_bottom_sheet.dart';

@RoutePage()
class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final listAccount = ref.watch(getListAccountProvider);
    if (listAccount.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: context.colors.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FreeSpaceUI.vertical(8.h),
              TextUI.titleRegular(S.of(context).accounts),
              FreeSpaceUI.vertical(20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextUI.smallNormalMedium(S.of(context).myBalance),
                    TextUI.smallNoneBold(listAccount.value!.countValue()!.currency())
                  ],
                ),
              ),
              FreeSpaceUI.vertical(20),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: listAccount.value!.length,
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 7 / 6,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 12.0,
                  ),
                  itemBuilder: (context, index) {
                    var item = listAccount.value![index];
                    return GestureDetector(
                        onTap: () {
                          WidgetUI.showBottomSheet(context, height: 40.h, child: AccountMenuBottomSheet(item: item));
                        },
                        child: AccountCardWidget(item: item));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
