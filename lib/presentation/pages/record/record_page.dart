import 'package:app_ui/app_ui.dart';
import 'package:app_ui/molecules/account_chip.dart';
import 'package:app_ui/molecules/category_chip.dart';
import 'package:app_ui/token/figma_token.dart';
import 'package:app_ui/utils/numeric_formatter.dart';
import 'package:app_ui/utils/string_extension.dart';
import 'package:app_ui/utils/theme_extension.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:how_much/data/constant/account.dart';
import 'package:how_much/presentation/provider/category/get_list_category_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../domain/category.dart';

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
  Category? categorySelected;
  Account? accountSelected;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    accountSelected = Account(name: "no");
  }

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
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: Row(
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
                    ),
                    FreeSpaceUI.vertical(16.sp),
                    Consumer(builder: (context, ref, child) {
                      final listCategory = ref.watch(getListCategoryProvider);
                      if (listCategory.isLoading)
                        return CircularProgressIndicator();

                      return SizedBox.fromSize(
                        size: Size.fromHeight(48.px),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: listCategory.value?.length,
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var item = listCategory.value?[index];
                            return CategoryChip(
                                // icon: "Icons.home_filled",
                                label: item!.name,
                                isActive: item == categorySelected,
                                onValueChanged: () {});
                          },
                        ),
                      );
                    })
                  ],
                ),
              ),
              FreeSpaceUI.vertical(24),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.sp),
                      child: Row(
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
                          return AccountChip(
                            assetPath: item.assets!,
                            label: item.name,
                            isActive: accountSelected == item,
                            onValueChanged: () {},
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              // FreeSpaceUI.vertical(20),
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
