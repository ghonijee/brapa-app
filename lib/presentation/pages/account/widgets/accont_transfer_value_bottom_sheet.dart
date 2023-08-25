import 'package:app_ui/app_ui.dart';
import 'package:app_ui/token/figma_token.dart';
import 'package:auto_route/auto_route.dart';
import 'package:brapa/gen/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/account.dart';
import '../../../provider/account/get_list_account_provider.dart';
import '../../../provider/account/transfer_account_provider.dart';

class TransferValueBottomSheet extends HookConsumerWidget {
  const TransferValueBottomSheet({
    super.key,
    required this.account,
  });

  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final listAccount = ref.watch(getListAccountProvider);
    final transferController = ref.watch(transferAccountProvider.notifier);
    final transferState = ref.watch(transferAccountProvider);
    final valueTextController = useTextEditingController();
    final disableTransfer = useState(true);

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUI.regularNormalBold(account.name),
                IconButton(
                  onPressed: () {
                    context.router.popUntilRoot();
                  },
                  icon: Icon(
                    Icons.highlight_remove_rounded,
                    color: context.colors.sky.dark,
                  ),
                )
              ],
            ),
            FreeSpaceUI.vertical(10),
            Divider(
              height: 1,
              color: context.colors.sky.dark,
            ),
            FreeSpaceUI.vertical(20),
            TextFormField(
              autofocus: true,
              style: FigmaTextStyles.regularNormalBold,
              controller: valueTextController,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if (value.isEmpty) {
                  return;
                }

                if (transferState.fromAccount!.balance < value.toNumber()!) {
                  disableTransfer.value = true;
                  return;
                }

                disableTransfer.value = false;
              },
              inputFormatters: [
                ThousandsFormatter(),
              ],
              decoration: InputDecoration(
                prefixText: "Rp. ",
                filled: true,
                fillColor: context.colors.ink.dark,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              ),
            ),
            FreeSpaceUI.vertical(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    text: "${S.of(context).from}  ",
                    style: FigmaTextStyles.smallNormalRegular,
                    children: [
                      TextSpan(
                        text: transferState.fromAccount?.name,
                        style: FigmaTextStyles.smallNormalBold,
                      ),
                    ],
                  ),
                ),
                TextUI.smallNormalBold(transferState.fromAccount?.balance.currency() ?? "0"),
              ],
            ),
            FreeSpaceUI.vertical(20),
            ElevatedButton(
              onPressed: disableTransfer.value
                  ? null
                  : () async {
                      transferController.setAmount(valueTextController.text);
                      transferController.transfer().then<void>((value) {
                        if (value) {
                          context.router.popUntilRoot();
                          transferController.reset();
                          Fluttertoast.showToast(
                            msg: S.of(context).transferSuccess,
                            backgroundColor: context.colors.green.darkest,
                            textColor: context.colors.sky.base,
                          );
                          ref.invalidate(getListAccountProvider);
                        }
                      });
                    },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
                backgroundColor: context.colors.primary.base,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const TextUI.regularNoneRegular("Transfer"),
            ),
            FreeSpaceUI.vertical(24),
          ],
        ),
      ),
    );
  }
}
