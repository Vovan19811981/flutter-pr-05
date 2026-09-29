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
    final scheme = Theme.of(context).colorScheme;
    final enabled = !isLoading && onPressed != null;
    final child = isLoading
        ? const SizedBox.square(
            dimension: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 8)],
              Text(text),
            ],
          );

    final callback = enabled ? onPressed : null;
    return switch (style) {
      CustomButtonStyle.primary => FilledButton(onPressed: callback, child: child),
      CustomButtonStyle.secondary => FilledButton.tonal(onPressed: callback, child: child),
      CustomButtonStyle.danger => FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: scheme.error,
            foregroundColor: scheme.onError,
          ),
          onPressed: callback,
          child: child,
        ),
      CustomButtonStyle.outline => OutlinedButton(onPressed: callback, child: child),
    };
  }
}
