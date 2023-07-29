import 'package:app_ui/app_ui.dart';
import 'package:app_ui/atom/text_ui.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

@RoutePage()
class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              const TextUI.titleRegular("History"),
              FreeSpaceUI.vertical(20),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 16,
                  ),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextUI.smallNoneRegular(
                                "Today",
                                color: context.colors.sky.light,
                              ),
                              TextUI.regularNoneBold(
                                "80,000",
                                color: context.colors.sky.lighter,
                              )
                            ],
                          ),
                          FreeSpaceUI.vertical(16),
                          ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: 4,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: context.theme.appColors.red.lightest,
                                  ),
                                  child: Icon(
                                    Icons.home,
                                    size: 24,
                                    color: context.theme.appColors.red.darkest,
                                  ),
                                ),
                                trailing: TextUI.smallNoneBold(
                                  "20,000",
                                  color: context.colors.sky.lighter,
                                ),
                                title: const TextUI.smallNormalMedium("Bill"),
                                subtitle: TextUI.smallNoneRegular(
                                  "Pulsa data 5GB",
                                  color: context.colors.sky.base,
                                ),
                              );
                            },
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
      ),
    );
  }
}
