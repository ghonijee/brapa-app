import 'package:app_ui/app_ui.dart';
import 'package:app_ui/token/figma_token.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:how_much/presentation/provider/transaction/create_record_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../provider/account/get_list_account_provider.dart';
import 'widgets/list_account_widget.dart';
import 'widgets/list_category_widget.dart';

@RoutePage()
class RecordPage extends HookConsumerWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = ref.watch(createRecordProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: context.theme.appColors.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FreeSpaceUI.vertical(8.h),
              Center(
                child: SizedBox(
                  width: 70.w,
                  child: SegmentedControl(
                    groupValue: controller.segmentedControllerGroupValue,
                    children: [
                      SegmentedControlValue(
                          label: "Expense",
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.arrow_circle_up_rounded,
                                color: context.colors.red.darkest,
                                size: 20,
                              ),
                              const TextUI.tinyNoneMedium("Expense"),
                            ],
                          )),
                      SegmentedControlValue(
                          label: "Expense",
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const TextUI.tinyNoneMedium("Incone"),
                              Icon(
                                Icons.arrow_circle_down_rounded,
                                color: context.colors.green.darkest,
                                size: 20,
                              ),
                            ],
                          )),
                      // SegmentedControlValue(label: "Income"),
                    ],
                    onValueChanged: (index, value) {
                      controller.segmentedControllerGroupValue = index;
                      controller.notifyListeners();
                    },
                  ),
                ),
              ),
              Column(
                children: [
                  FreeSpaceUI.vertical(16.sp),
                  AmountInputField(
                    focusNode: controller.focusNode,
                    controller: controller.amountController,
                  ),
                  FreeSpaceUI.vertical(12.sp),
                  MemoInputField(memoController: controller.memoController),
                ],
              ),
              FreeSpaceUI.vertical(12.sp),
              const ListCategoryWidget(),
              FreeSpaceUI.vertical(24),
              const ListAccountWidget(),
              // FreeSpaceUI.vertical(20),
              NumericKeyboard(
                onKeyboardTap: (value) {
                  var oldValue = controller.amountController.text;
                  var newValue = oldValue + value;
                  controller.amountController.text = newValue.currency(prefix: '');
                },
                textStyle: FigmaTextStyles.largeNormalMedium,
                rightButtonFn: () async {
                  // On Submit
                  await controller.save();
                },
                rightIcon: const Icon(
                  Icons.check,
                ),
                leftButtonFn: () {
                  controller.amountController.text = controller.amountController.text
                      .substring(0, controller.amountController.text.length - 1)
                      .currency(prefix: "");
                },
                leftIcon: const Icon(
                  Icons.backspace,
                ),
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              )
            ],
          ),
        ),
      ),
    );
  }
}
