import 'package:flutter/material.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String? title;
  final List<Widget>? actions;
  final bool? automaticallyImplyLeading;
  final bool? centerTitle;

  const CustomAppBar({
    super.key,
    this.leading,
    this.title,
    this.actions,
    this.automaticallyImplyLeading,
    this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Text(title ?? context.l10n.discover),
      centerTitle: centerTitle ?? true,
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
