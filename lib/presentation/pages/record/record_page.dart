import 'package:app_ui/app_ui.dart';
import 'package:app_ui/token/figma_token.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/gen/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:brapa/presentation/provider/transaction/create_record_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'widgets/list_account_widget.dart';
import 'widgets/list_category_widget.dart';

@RoutePage()
class RecordPage extends HookConsumerWidget {
  const RecordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = ref.watch(createRecordProvider);
    var numberKeyboarVisible = useState(true);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: context.theme.appColors.background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FreeSpaceUI.vertical(8.h),
            SizedBox(
              height: 30.h,
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      width: 70.w,
                      child: SegmentedControl(
                        groupValue: controller.segmentedControllerGroupValue,
                        children: [
                          SegmentedControlValue(
                              label: S.of(context).expense,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.arrow_circle_up_rounded,
                                    color: context.colors.red.base,
                                    size: 20,
                                  ),
                                  TextUI.tinyNoneMedium(S.of(context).expense),
                                ],
                              )),
                          SegmentedControlValue(
                              label: S.of(context).income,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextUI.tinyNoneMedium(S.of(context).income),
                                  Icon(
                                    Icons.arrow_circle_down_rounded,
                                    color: context.colors.green.base,
                                    size: 20,
                                  ),
                                ],
                              )),
                          // SegmentedControlValue(label: "Income"),
                        ],
                        onValueChanged: (index, value) {
                          controller.changeSegmentedControlValue(index);
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
                      MemoInputField(
                        memoController: controller.memoController,
                        hintText: S.of(context).noteHint,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FreeSpaceUI.vertical(12.sp),
                    const ListCategoryWidget(),
                    FreeSpaceUI.vertical(24),
                    const ListAccountWidget(),
                    // Spacer(),
                    FreeSpaceUI.vertical(24),
                    WidgetUI.visibility(
                      visibility: numberKeyboarVisible.value,
                      child: NumericKeyboard(
                        onKeyboardTap: (value) {
                          String newValue;
                          if (controller.amountController.selection.start >= 0) {
                            int newPosition = controller.amountController.selection.start + value.length;
                            controller.amountController.text = controller.amountController.text.replaceRange(
                              controller.amountController.selection.start,
                              controller.amountController.selection.end,
                              value,
                            );

                            controller.amountController.selection = TextSelection(
                              baseOffset: newPosition,
                              extentOffset: newPosition,
                            );
                            newValue = controller.amountController.text;
                            controller.amountController.text = newValue.currency(prefix: '');
                          } else {
                            var oldValue = controller.amountController.text;
                            newValue = oldValue + value;
                            controller.amountController.text = newValue.currency(prefix: '');
                          }
                          controller.onChangeAmountValue(newValue);
                        },
                        textStyle: FigmaTextStyles.largeNormalMedium,
                        rightButtonFn: () async {
                          if (controller.validate() == false) {
                            return;
                          }
                          await controller.save().then((value) {
                            Fluttertoast.showToast(
                              msg: S.of(context).saveRecordSuccess,
                              backgroundColor: context.colors.green.darkest,
                              textColor: context.colors.sky.base,
                            );
                            // On Submit
                          });
                        },
                        rightIcon: Icon(
                          Icons.check_circle,
                          color: controller.validate() ? context.colors.green.base : context.colors.ink.base,
                          size: 28,
                        ),
                        leftButtonFn: () {
                          if (controller.amountController.text.isEmpty) {
                            return;
                          }
                          String newValue;
                          if (controller.amountController.selection.start >= 0) {
                            int newPosition = controller.amountController.selection.start - 1;
                            controller.amountController.text = controller.amountController.text.replaceRange(
                              controller.amountController.selection.start - 1,
                              controller.amountController.selection.end,
                              '',
                            );

                            controller.amountController.selection = TextSelection(
                              baseOffset: newPosition,
                              extentOffset: newPosition,
                            );
                            newValue = controller.amountController.text;
                            controller.amountController.text = newValue.currency(prefix: '');
                          } else {
                            newValue = controller.amountController.text
                                .substring(0, controller.amountController.text.length - 1)
                                .currency(prefix: "");
                            controller.amountController.text = newValue.currency(prefix: '');
                          }
                          controller.onChangeAmountValue(newValue);

                          // newValue = controller.amountController.text
                          //     .substring(0, controller.amountController.text.length - 1)
                          //     .currency(prefix: "");
                          // controller.amountController.text = newValue.currency(prefix: '');
                          // controller.onChangeAmountValue(newValue);
                        },
                        leftIcon: const Icon(
                          Icons.backspace,
                        ),
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
