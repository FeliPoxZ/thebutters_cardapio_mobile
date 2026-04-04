import 'package:flutter/material.dart';
import 'package:thebutters_cardapio_mobile/core/theme/app_colors.dart';

class RoundButtonWidget extends StatelessWidget {
  final Icon icon;
  final VoidCallback onPressed;

  const RoundButtonWidget({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.banner.withValues(alpha: 0.55),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: icon,
        onPressed: onPressed,
        padding: EdgeInsets.all(5),
        constraints: const BoxConstraints(),
      ),
    );
  }
}
