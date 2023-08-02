import 'package:app_ui/app_ui.dart';
import 'package:app_ui/molecules/category_chip.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../domain/category.dart';
import '../../../provider/transaction/create_record_provider.dart';

class ShowAllCategoryBottomSheet extends ConsumerWidget {
  const ShowAllCategoryBottomSheet({super.key, required this.getListCategory, required this.controller, this.onTap});

  final AsyncValue<List<Category>> getListCategory;
  final CreateRecordNotifier controller;
  final Function(int index)? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
      height: 70.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colors.ink.darker,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TextUI.largeNormalBold("All Categories"),
          FreeSpaceUI.vertical(20),
          getListCategory.maybeWhen(
            orElse: () => const Center(
              child: TextUI.largeTightMedium(
                "Data not found",
              ),
            ),
            data: (data) {
              var result = controller.segmentedControllerGroupValue == 1 ? data.incomeList() : data.expenseList();
              return Expanded(
                child: Wrap(
                    runSpacing: 8,
                    spacing: 8,
                    children: result
                        .map((item) => CategoryChip(
                            label: item!.name,
                            isActive: item == ref.watch(createRecordProvider).categorySelected,
                            onValueChanged: () {
                              ref.watch(createRecordProvider).categorySelected = item;
                              controller.notifyListeners();
                              onTap?.call(result.indexOf(item));
                              context.router.pop();
                            }))
                        .toList()),
              );
            },
          )
        ],
      ),
    );
  }
}
