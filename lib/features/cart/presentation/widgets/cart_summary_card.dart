import 'package:flutter/material.dart';
import 'package:medi_care/l10n/app_localizations.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';

class CartSummaryCard extends StatelessWidget {
  const CartSummaryCard({
    super.key,
    required this.itemCount,
    required this.subtotal,
    this.deliveryFee = 0,
    this.discount = 0,
  });

  final int itemCount;
  final double subtotal;
  final double deliveryFee;
  final double discount;

  double get total => subtotal + deliveryFee - discount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: AppDimensions.borderRadiusCircular16,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.orderSummary,
            style: AppTypography.textStyle16SemiBold.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 16),

          // Items count
          _SummaryRow(
            label: l10n.itemsCount(itemCount),
            value: '${l10n.currencySymbol}${subtotal.toStringAsFixed(0)}',
          ),
          const SizedBox(height: 8),

          // Delivery
          _SummaryRow(
            label: l10n.delivery,
            value: deliveryFee == 0
                ? l10n.freeDelivery
                : '${l10n.currencySymbol}${deliveryFee.toStringAsFixed(0)}',
            valueColor: deliveryFee == 0 ? AppTheme.success : null,
          ),

          // Discount (if any)
          if (discount > 0) ...[
            const SizedBox(height: 8),
            _SummaryRow(
              label: l10n.discount,
              value: '-${l10n.currencySymbol}${discount.toStringAsFixed(0)}',
              valueColor: AppTheme.success,
            ),
          ],

          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),

          // Total
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.total,
                style: AppTypography.textStyle16SemiBold.copyWith(
                  color: AppTheme.textPrimary,
                ),
              ),
              Text(
                '${l10n.currencySymbol}${total.toStringAsFixed(0)}',
                style: AppTypography.textStyle20Bold.copyWith(
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.textStyle14Regular.copyWith(
            color: AppTheme.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTypography.textStyle14SemiBold.copyWith(
            color: valueColor ?? AppTheme.textPrimary,
          ),
        ),
      ],
    );
  }
}
