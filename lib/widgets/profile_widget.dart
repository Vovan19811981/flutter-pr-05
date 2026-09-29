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
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(user.name.substring(0, 1))),
        title: Text(user.name),
        subtitle: Text(user.email),
        trailing: onEditPressed == null
            ? null
            : IconButton(onPressed: onEditPressed, icon: const Icon(Icons.edit)),
      ),
    );
  }
}
