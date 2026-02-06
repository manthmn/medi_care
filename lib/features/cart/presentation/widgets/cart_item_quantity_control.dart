import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_care/core/theme/app_dimensions.dart';
import 'package:medi_care/core/theme/app_theme.dart';
import 'package:medi_care/core/theme/app_typography.dart';
import '../../domain/entities/cart_item.dart';
import '../bloc/cart_bloc.dart';

class CartItemQuantityControl extends StatelessWidget {
  const CartItemQuantityControl({super.key, required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceGrey200,
        borderRadius: AppDimensions.borderRadiusCircular8,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepperButton(
            icon: item.quantity == 1 ? Icons.delete_outline : Icons.remove,
            onPressed: () {
              context.read<CartBloc>().add(
                    CartItemQuantityChanged(
                      product: item.product,
                      quantity: item.quantity - 1,
                    ),
                  );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              '${item.quantity}',
              style: AppTypography.textStyle14SemiBold.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          _StepperButton(
            icon: Icons.add,
            onPressed: () {
              context.read<CartBloc>().add(
                    CartItemQuantityChanged(
                      product: item.product,
                      quantity: item.quantity + 1,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: AppDimensions.borderRadiusCircular8,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: AppDimensions.iconSize18,
            color: AppTheme.primary,
          ),
        ),
      ),
    );
  }
}
