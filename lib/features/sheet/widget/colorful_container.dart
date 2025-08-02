import 'package:flutter/material.dart';

class SheetColorfulContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final Color? gradientColor;
  const SheetColorfulContainer({
    super.key,
    required this.child,
    this.gradientColor,
    this.height = 60,
    this.width = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 1,
          colors: [
            gradientColor ?? Color.fromARGB(255, 111, 6, 11),
            const Color.fromARGB(255, 255, 255, 255),
          ],
          stops: const [0.3, 0.9],
        ),
      ),
      child: Center(child: child),
    );
  }
}
