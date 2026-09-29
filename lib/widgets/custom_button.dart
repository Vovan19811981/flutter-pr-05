import 'package:flutter/material.dart';

enum CustomButtonStyle { primary, secondary, danger, outline }

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style = CustomButtonStyle.primary,
    this.icon,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final CustomButtonStyle style;
  final Widget? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[icon!, const SizedBox(width: 8)],
        Text(text),
      ],
    );
    return ElevatedButton(onPressed: onPressed, child: child);
  }
}
