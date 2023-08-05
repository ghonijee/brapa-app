import 'package:app_ui/app_ui.dart';
import 'package:app_ui/token/figma_token.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:how_much/presentation/provider/account/get_list_account_provider.dart';
import 'package:how_much/presentation/provider/account/manage_account_provider.dart';
import 'package:how_much/presentation/provider/category/get_list_category_provider.dart';

import '../../../domain/category.dart';
import '../../provider/category/manage_category_provider.dart';

enum FormCategoryType { create, update }

@RoutePage()
class DetailCategoryPage extends HookConsumerWidget {
  const DetailCategoryPage({super.key, this.data, required this.formMode, this.label, required this.type});
  final Category? data;
  final FormCategoryType formMode;
  final String? label;
  final CategoryType type;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameTextController = useTextEditingController(text: data?.name);
    final isActiveState = useState(data?.isActive ?? true);

    final controller = ref.watch(manageCategoryProvider.notifier);

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
                                ref.watch(manageCategoryProvider.notifier).delete().then<void>((value) {
                                  ref.watch(listCategoriesProvider.notifier).reload();
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
                            formMode == FormCategoryType.create ? "Create Category" : "Category Details"),
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
                                activeColor: context.colors.primary.light,
                                onChanged: (value) {
                                  isActiveState.value = !isActiveState.value;
                                }),
                          ],
                        ),
                        FreeSpaceUI.vertical(42),
                        ElevatedButton(
                          onPressed: () async {
                            if (formMode == FormCategoryType.create) {
                              controller
                                  .store(
                                name: nameTextController.text,
                                type: type,
                                isActive: isActiveState.value,
                              )
                                  .then((value) {
                                ref.watch(listCategoriesProvider.notifier).reload();

                                context.router.pop();
                              });
                            } else {
                              controller
                                  .saveUpdate(
                                name: nameTextController.text,
                                isActive: isActiveState.value,
                                type: type,
                              )
                                  .then((value) {
                                ref.watch(listCategoriesProvider.notifier).reload();
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
