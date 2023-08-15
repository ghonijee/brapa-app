import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PinKeyboardWidget extends StatefulWidget {
  const PinKeyboardWidget({
    super.key,
    required this.controller,
    this.leftKey,
    this.rightKey,
  });
  final TextEditingController controller;
  final Widget? leftKey;
  final Widget? rightKey;

  @override
  State<PinKeyboardWidget> createState() => _PinKeyboardWidgetState();
}

class _PinKeyboardWidgetState extends State<PinKeyboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 28,
      runSpacing: 24,
      children: [
        ...["1", "2", "3", "4", "5", "6", "7", "8", "9"]
            .map(
              (value) => BuildNumberPad(
                label: value,
                onTap: () => onPress(value),
              ),
            )
            .toList(),
        widget.leftKey ??
            SizedBox(
              width: 20.w,
              height: 20.w,
            ),
        BuildNumberPad(
          label: "0",
          onTap: () => onPress("0"),
        ),
        widget.rightKey ??
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(90),
              ),
              child: Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                ),
                child: Center(
                    child: Icon(
                  EvaIcons.backspace_outline,
                  size: 34,
                  color: context.colors.sky.lighter,
                )),
              ),
              onTap: () => onBackspace(),
            )
      ],
    );
  }

  onPress(String value) {
    widget.controller.text += value;
  }

  onBackspace() {
    widget.controller.text = widget.controller.text.substring(0, widget.controller.text.length - 1);
  }
}

class BuildNumberPad extends StatelessWidget {
  const BuildNumberPad({super.key, required this.label, required this.onTap, this.child});
  final String? label;
  final void Function() onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(90),
      ),
      onTap: onTap,
      child: Container(
        width: 20.w,
        height: 20.w,
        decoration: BoxDecoration(
          color: context.colors.ink.darker,
          borderRadius: BorderRadius.circular(90),
        ),
        child: Center(
          child: child ??
              TextUI.titleRegular(
                label ?? "-",
              ),
        ),
      ),
    );
  }
}
