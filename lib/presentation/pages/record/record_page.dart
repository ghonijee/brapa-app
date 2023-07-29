import 'package:app_ui/app_ui.dart';
import 'package:app_ui/token/figma_token.dart';
import 'package:app_ui/utils/numeric_formatter.dart';
import 'package:app_ui/utils/string_extension.dart';
import 'package:app_ui/utils/theme_extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:how_much/data/dummy/account.dart';
import 'package:how_much/data/dummy/category.dart';
import 'package:how_much/gen/assets.gen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

@RoutePage()
class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  late int segmentedControllerGroupValue = 0;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController memoController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
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
                    groupValue: segmentedControllerGroupValue,
                    children: [
                      SegmentedControlValue(label: "Expense"),
                      SegmentedControlValue(label: "Income"),
                    ],
                    onValueChanged: (index, value) {
                      setState(() {
                        segmentedControllerGroupValue = index;
                      });
                    },
                  ),
                ),
              ),
              Column(
                children: [
                  FreeSpaceUI.vertical(16.sp),
                  AmountInputField(
                    focusNode: focusNode,
                    controller: amountController,
                  ),
                  FreeSpaceUI.vertical(12.sp),
                  MemoInputField(memoController: memoController),
                ],
              ),
              FreeSpaceUI.vertical(12.sp),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextUI.smallNoneRegular(
                          "Category",
                          color: context.colors.sky.dark,
                        ),
                        TextUI.tinyNoneRegular(
                          "Show more",
                          color: context.colors.primary.base,
                        )
                      ],
                    ),
                    FreeSpaceUI.vertical(16.sp),
                    SizedBox.fromSize(
                      size: Size.fromHeight(48.px),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: listCategory.length,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var item = listCategory[index];
                          return Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(right: 12.sp),
                            decoration: BoxDecoration(
                                color: context.theme.appColors.ink.dark,
                                border: true
                                    ? Border.all(
                                        color: context
                                            .theme.appColors.primary.darkest,
                                        width: 2,
                                      )
                                    : null,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.sp, vertical: 8.sp),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextUI.smallNoneRegular(item.name),
                                FreeSpaceUI.horizontal(12.sp),
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(45),
                                    color: context.theme.appColors.red.lightest,
                                  ),
                                  child: Icon(
                                    item.icon,
                                    size: 16,
                                    color: context.theme.appColors.red.darkest,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              FreeSpaceUI.vertical(24),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextUI.smallNoneRegular(
                          "Account",
                          color: context.colors.sky.dark,
                        ),
                        TextUI.tinyNoneRegular(
                          "Show more",
                          color: context.colors.primary.base,
                        )
                      ],
                    ),
                    FreeSpaceUI.vertical(16.sp),
                    SizedBox.fromSize(
                      size: Size.fromHeight(48.px),
                      child: ListView.builder(
                        addSemanticIndexes: true,
                        shrinkWrap: true,
                        itemCount: listAccount.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var item = listAccount[index];
                          return Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(right: 12.sp),
                            decoration: BoxDecoration(
                                color: context.theme.appColors.ink.dark,
                                border: true
                                    ? Border.all(
                                        color: context
                                            .theme.appColors.primary.darkest,
                                        width: 2,
                                      )
                                    : null,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(32))),
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.sp, vertical: 8.sp),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextUI.smallNoneRegular(item.name),
                                FreeSpaceUI.horizontal(12.sp),
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(45),
                                      color:
                                          context.theme.appColors.red.lightest,
                                    ),
                                    child: Assets.bank.bcaPng.image(width: 20))
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              FreeSpaceUI.vertical(20),
              NumericKeyboard(
                onKeyboardTap: (value) {
                  var oldValue = amountController.text;
                  var newValue = oldValue + value;
                  amountController.text = newValue.currency(prefix: '');
                },
                textStyle: FigmaTextStyles.largeNormalMedium,
                rightButtonFn: () {
                  // On Submit
                },
                rightButtonLongPressFn: () {},
                rightIcon: const Icon(
                  Icons.check,
                ),
                leftButtonFn: () {
                  amountController.text = amountController.text
                      .substring(0, amountController.text.length - 1)
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
