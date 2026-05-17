import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class AppCard extends StatelessWidget {
  AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    required this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF152230),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell
          (onTap: onTap,borderRadius: BorderRadius.circular(18),child: Padding(
            padding: padding,
            child: child,
          )),
      ),
    );
  }
}
