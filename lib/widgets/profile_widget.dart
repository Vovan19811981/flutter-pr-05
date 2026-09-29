import 'package:flutter/material.dart';

import '../models/user.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.user,
    this.onEditPressed,
    this.isCompact = false,
  });

  final User user;
  final VoidCallback? onEditPressed;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final content = <Widget>[
      CircleAvatar(
        radius: isCompact ? 24 : 34,
        backgroundColor: theme.colorScheme.primaryContainer,
        foregroundColor: theme.colorScheme.onPrimaryContainer,
        child: Text(
          user.name.isEmpty ? '?' : user.name.substring(0, 1).toUpperCase(),
          style: isCompact ? theme.textTheme.titleMedium : theme.textTheme.headlineSmall,
        ),
      ),
      SizedBox(width: isCompact ? 12 : 16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              user.name,
              style: isCompact ? theme.textTheme.titleMedium : theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 2),
            Text(user.email, style: theme.textTheme.bodyMedium),
            if (!isCompact && user.subtitle.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(user.subtitle, style: theme.textTheme.bodySmall),
            ],
          ],
        ),
      ),
      if (onEditPressed != null)
        IconButton(
          tooltip: 'Редагувати',
          onPressed: onEditPressed,
          icon: const Icon(Icons.edit_outlined),
        ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final narrow = constraints.maxWidth < 320 && !isCompact;
        return DecoratedBox(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.colorScheme.outlineVariant),
          ),
          child: Padding(
            padding: EdgeInsets.all(isCompact ? 12 : 18),
            child: narrow
                ? Column(
                    children: [
                      content.first,
                      const SizedBox(height: 12),
                      Row(children: content.skip(2).toList()),
                    ],
                  )
                : Row(children: content),
          ),
        );
      },
    );
  }
}
