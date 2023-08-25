import 'package:app_ui/app_ui.dart';
import 'package:app_ui/token/figma_token.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/gen/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:brapa/domain/account.dart';
import 'package:brapa/gen/assets.gen.dart';
import 'package:brapa/presentation/provider/account/get_list_account_provider.dart';
import 'package:brapa/presentation/provider/account/manage_account_provider.dart';

enum FormAccountType { create, update }

@RoutePage()
class DetailAccountPage extends HookConsumerWidget {
  const DetailAccountPage({super.key, this.data, required this.formMode});
  final Account? data;
  final FormAccountType formMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameTextController = useTextEditingController(text: data?.name);
    final balanceTextController = useTextEditingController(text: data?.balance.toThousandSeparator());
    final isActiveState = useState(data?.isActive ?? true);
    final assetImagePath = useState(data?.assets ?? Assets.accounts.walletAltGreen.path);

    final controller = ref.watch(manageAccountProvider.notifier);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: context.colors.background,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBarAction
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => context.router.pop(),
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: context.colors.onBackground,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDeleteItemUI(onConfirm: () {
                                ref.watch(manageAccountProvider.notifier).delete().then<void>((value) {
                                  ref.watch(listAccountProvider.notifier).reload();
                                  context.router.popForced();
                                  context.router.pop();
                                });
                              }, onCancel: () {
                                context.router.pop();
                              });
                            });
                      },
                      icon: const Icon(Icons.delete_rounded),
                      color: context.colors.onBackground,
                    ),
                  ],
                ),
                // Body COntent
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FreeSpaceUI.vertical(20),
                        TextUI.titleRegular(
                          formMode == FormAccountType.create ? S.of(context).createAccount : S.of(context).account,
                        ),
                        FreeSpaceUI.vertical(32),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextUI.smallTightBold(
                              S.of(context).name,
                              color: context.colors.sky.base,
                            ),
                            FreeSpaceUI.vertical(16),
                            TextFormField(
                              controller: nameTextController,
                              style: FigmaTextStyles.smallNormalRegular,
                              keyboardAppearance: Brightness.dark,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: context.colors.surface,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                              ),
                            )
                          ],
                        ),
                        FreeSpaceUI.vertical(20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextUI.smallTightBold(
                              S.of(context).balance,
                              color: context.colors.sky.base,
                            ),
                            FreeSpaceUI.vertical(16),
                            TextFormField(
                              style: FigmaTextStyles.smallNormalRegular,
                              // initialValue: data.balance!.toThousandSeparator(),
                              controller: balanceTextController,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                ThousandsFormatter(),
                              ],
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: context.colors.surface,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                              ),
                            )
                          ],
                        ),
                        FreeSpaceUI.vertical(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextUI.smallTightBold(
                                  S.of(context).active,
                                  color: context.colors.sky.base,
                                ),
                                FreeSpaceUI.vertical(8),
                                TextUI.tinyNoneRegular(
                                  S.of(context).activeDesc,
                                  color: context.colors.sky.dark,
                                )
                              ],
                            ),
                            FreeSpaceUI.vertical(16),
                            Switch.adaptive(
                                value: isActiveState.value,
                                activeColor: context.colors.primary.light,
                                onChanged: (value) {
                                  isActiveState.value = !isActiveState.value;
                                }),
                          ],
                        ),
                        FreeSpaceUI.vertical(28),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextUI.smallTightBold(
                                  S.of(context).iconImage,
                                  color: context.colors.sky.base,
                                ),
                                FreeSpaceUI.vertical(8),
                                TextUI.tinyNoneRegular(
                                  S.of(context).iconImageDesc,
                                  color: context.colors.sky.dark,
                                )
                              ],
                            ),
                            FreeSpaceUI.vertical(16),
                            GestureDetector(
                                onTap: () async {
                                  var pathSelected = await showModalBottomSheet(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        padding: const EdgeInsets.all(20),
                                        child: GridView.builder(
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            crossAxisSpacing: 8,
                                            mainAxisSpacing: 8,
                                          ),
                                          itemCount: Assets.accounts.values.length,
                                          itemBuilder: (context, index) {
                                            var path = Assets.accounts.values[index].path;
                                            return GestureDetector(
                                                onTap: () {
                                                  context.router.pop(path);
                                                },
                                                child: Image.asset(path, fit: BoxFit.fitWidth));
                                          },
                                        ),
                                      );
                                    },
                                  );
                                  if (pathSelected != null) {
                                    assetImagePath.value = pathSelected;
                                  }
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    assetImagePath.value,
                                    fit: BoxFit.cover,
                                    width: 70,
                                  ),
                                ))
                          ],
                        ),
                        FreeSpaceUI.vertical(42),
                        ElevatedButton(
                          onPressed: () async {
                            if (formMode == FormAccountType.create) {
                              controller
                                  .store(
                                      name: nameTextController.text,
                                      balance: balanceTextController.text,
                                      isActive: isActiveState.value,
                                      assetsPath: assetImagePath.value)
                                  .then((value) {
                                ref.watch(listAccountProvider.notifier).reload();

                                context.router.pop();
                              });
                            } else {
                              controller
                                  .saveUpdate(
                                      name: nameTextController.text,
                                      balance: balanceTextController.text,
                                      isActive: isActiveState.value,
                                      assetsPath: assetImagePath.value)
                                  .then((value) {
                                ref.watch(listAccountProvider.notifier).reload();
                                context.router.pop();
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(48),
                            backgroundColor: context.colors.primary.base,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: TextUI.regularNoneRegular(S.of(context).save),
                        ),
                        FreeSpaceUI.vertical(42),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
