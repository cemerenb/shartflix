import 'package:flutter/widgets.dart';
import 'package:shartflix/shared/utils/context/context_extensions.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final BoxDecoration? decoration;
  final BorderRadius? borderRadius;

  const CustomContainer({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.alignment,
    this.decoration,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding ?? const EdgeInsets.all(16.0),
      alignment: alignment,
      decoration:
          decoration ??
          BoxDecoration(
            color: context.theme.colorScheme.surface,
            borderRadius: borderRadius ?? BorderRadius.circular(10.0),
            border: Border.all(
              color: context.theme.colorScheme.onSurface.withAlpha(80),
              width: 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: context.theme.colorScheme.shadow.withAlpha(25),
                blurRadius: 4.0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
      child: child,
    );
  }
}
