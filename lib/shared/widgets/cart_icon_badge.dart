import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_theme.dart';
import '../../core/theme/app_typography.dart';
import '../../features/cart/presentation/bloc/cart_bloc.dart';
import '../../features/cart/presentation/screens/cart_screen.dart';

/// A cart icon with an animated badge showing the total item count.
/// Reads from CartBloc and automatically updates when cart changes.
class CartIconBadge extends StatelessWidget {
  const CartIconBadge({
    super.key,
    this.iconColor,
    this.badgeColor,
    this.onPressed,
  });

  final Color? iconColor;
  final Color? badgeColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        final itemCount = state.items.fold<int>(
          0,
          (sum, item) => sum + item.quantity,
        );

        return IconButton(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                color: iconColor ?? AppTheme.textPrimary,
              ),
              if (itemCount > 0)
                Positioned(
                  right: -6,
                  top: -6,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.8, end: 1.0),
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.elasticOut,
                    builder: (context, scale, child) {
                      return Transform.scale(
                        scale: scale,
                        child: child,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor ?? AppTheme.errorPink,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (badgeColor ?? AppTheme.errorPink)
                                .withValues(alpha: 0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        itemCount > 99 ? '99+' : '$itemCount',
                        style: AppTypography.textStyle11Regular.copyWith(
                          color: AppTheme.textOnPrimary,
                          height: 1,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          onPressed: onPressed ??
              () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
        );
      },
    );
  }
}
