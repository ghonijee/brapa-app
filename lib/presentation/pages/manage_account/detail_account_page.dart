import 'package:app_ui/app_ui.dart';
import 'package:app_ui/token/figma_token.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:how_much/domain/account.dart';
import 'package:how_much/gen/assets.gen.dart';

@RoutePage()
class DetailAccountPage extends HookConsumerWidget {
  const DetailAccountPage({super.key, required this.data});
  final Account data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameTextController = useTextEditingController(text: data.name);
    final balanceTextController = useTextEditingController(text: data.balance!.toThousandSeparator());
    final isActiveState = useState(data.isActive!);
    final assetImagePath = useState(data.assets!);

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
                                // ref.watch(deleteRecordProvider).delete(controller.transaction).then<void>((value) {
                                //   ref.watch(asyncListHistory.notifier).reload();
                                //   context.router.popForced();
                                //   context.router.pop();
                                // });
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
                        const TextUI.titleRegular("Account Details"),
                        FreeSpaceUI.vertical(32),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextUI.smallTightBold(
                              "Name",
                              color: context.colors.sky.base,
                            ),
                            FreeSpaceUI.vertical(16),
                            TextFormField(
                              controller: nameTextController,
                              style: FigmaTextStyles.smallNormalRegular,
                              keyboardType: TextInputType.number,
                              keyboardAppearance: Brightness.dark,
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextUI.smallTightBold(
                              "Balance",
                              color: context.colors.sky.base,
                            ),
                            FreeSpaceUI.vertical(16),
                            TextFormField(
                              style: FigmaTextStyles.smallNormalRegular,
                              // initialValue: data.balance!.toThousandSeparator(),
                              controller: balanceTextController,
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
                                  "Active",
                                  color: context.colors.sky.base,
                                ),
                                FreeSpaceUI.vertical(8),
                                TextUI.tinyNoneRegular(
                                  "When an account is set to inactive,\n it will not appear on the list.",
                                  color: context.colors.sky.dark,
                                )
                              ],
                            ),
                            FreeSpaceUI.vertical(16),
                            Switch.adaptive(
                                value: isActiveState.value,
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
                                  "Icon Image",
                                  color: context.colors.sky.base,
                                ),
                                FreeSpaceUI.vertical(8),
                                TextUI.tinyNoneRegular(
                                  "This image will show on list and chips",
                                  color: context.colors.sky.dark,
                                )
                              ],
                            ),
                            FreeSpaceUI.vertical(16),
                            GestureDetector(
                                onTap: () async {
                                  var pathSelected = await showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return Container(
                                        child: GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            crossAxisSpacing: 8,
                                            mainAxisSpacing: 8,
                                          ),
                                          itemCount: Assets.bank.values.length,
                                          itemBuilder: (context, index) {
                                            var path = Assets.bank.values[index].path;
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

                                  print(pathSelected);
                                  assetImagePath.value = pathSelected;
                                },
                                child: Image.asset(assetImagePath.value))
                          ],
                        ),
                        FreeSpaceUI.vertical(42),
                        ElevatedButton(
                          onPressed: () async {
                            // controller.save().then((value) {
                            //   ref.watch(asyncListHistory.notifier).reload();
                            //   context.router.pop();
                            // });
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(48),
                            backgroundColor: context.colors.primary.base,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const TextUI.regularNoneRegular("Save"),
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
