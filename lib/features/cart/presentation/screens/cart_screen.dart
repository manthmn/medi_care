import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_care/l10n/app_localizations.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../products/presentation/screens/product_list_screen.dart';
import '../bloc/cart_bloc.dart';
import '../widgets/cart_item_card.dart';
import '../widgets/cart_summary_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundGrey,
      appBar: _buildAppBar(context),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          switch (state.status) {
            case CartStatus.loading:
              return const Center(
                child: CircularProgressIndicator(
                  color: AppTheme.primary,
                ),
              );

            case CartStatus.error:
              final l10n = AppLocalizations.of(context)!;
              return _ErrorView(
                message: state.error ?? l10n.somethingWentWrong,
                onRetry: () =>
                    context.read<CartBloc>().add(const CartStarted()),
              );

            case CartStatus.empty:
              return _EmptyCart(
                onBrowse: () {
                  Navigator.of(context).pushReplacementNamed(
                    ProductListScreen.routeName,
                  );
                },
              );

            case CartStatus.success:
              return _CartContent(state: state);

            case CartStatus.initial:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.backgroundWhite,
      elevation: 0,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.surfaceGrey,
            borderRadius: AppDimensions.borderRadiusCircular10,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppTheme.textPrimary,
            size: 16,
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final l10n = AppLocalizations.of(context)!;
          final itemCount = state.items.length;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.myCart,
                style: AppTypography.textStyle18SemiBold.copyWith(
                  color: AppTheme.textPrimary,
                ),
              ),
              if (itemCount > 0)
                Text(
                  l10n.itemCount(itemCount),
                  style: AppTypography.textStyle12Regular.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
            ],
          );
        },
      ),
      centerTitle: false,
      actions: [
        BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state.items.isEmpty) return const SizedBox.shrink();
            return IconButton(
              icon: Icon(
                Icons.delete_sweep_outlined,
                color: AppTheme.error.withValues(alpha: 0.7),
              ),
              onPressed: () => _showClearCartDialog(context),
            );
          },
        ),
      ],
    );
  }

  void _showClearCartDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: AppDimensions.borderRadiusCircular16,
        ),
        title: Text(l10n.clearCart),
        content: Text(l10n.clearCartConfirmation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              l10n.cancel,
              style: TextStyle(color: AppTheme.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<CartBloc>().add(const CartCleared());
              Navigator.pop(ctx);
            },
            child: Text(
              l10n.clear,
              style: const TextStyle(color: AppTheme.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartContent extends StatelessWidget {
  const _CartContent({required this.state});

  final CartState state;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        // Cart Items List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            itemCount: state.items.length,
            itemBuilder: (context, index) {
              final item = state.items[index];
              return CartItemCard(
                item: item,
                onRemove: () {
                  context.read<CartBloc>().add(
                        CartItemRemoved(item.product.id),
                      );
                },
              );
            },
          ),
        ),

        // Bottom Section
        Container(
          decoration: BoxDecoration(
            color: AppTheme.backgroundWhite,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Summary Card
                  CartSummaryCard(
                    itemCount: state.items.length,
                    subtotal: state.total,
                    deliveryFee: 0,
                    discount: 0,
                  ),
                  const SizedBox(height: 16),

                  // Checkout Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Navigate to checkout
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: AppTheme.textOnPrimary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppDimensions.borderRadiusCircular16,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l10n.proceedToCheckout,
                            style: AppTypography.textStyle16SemiBold,
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart({required this.onBrowse});

  final VoidCallback onBrowse;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.spacing32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Shopping Bag Icon in Circular Container
            Container(
              width: AppTheme.emptyStateIconSize,
              height: AppTheme.emptyStateIconSize,
              decoration: BoxDecoration(
                color: AppTheme.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: AppTheme.emptyStateIconInnerSize,
                color: AppTheme.primary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing32),

            // Primary Message
            Text(
              l10n.yourCartIsEmpty,
              style: AppTypography.textStyle22Bold.copyWith(
                color: AppTheme.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spacing12),

            // Secondary Message
            Text(
              l10n.emptyCartDescription,
              style: AppTypography.textStyle14Regular.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spacing32),

            // Browse Products Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onBrowse,
                icon: const Icon(Icons.add_shopping_cart),
                label: Text(l10n.browseProducts),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: AppTheme.textOnPrimary,
                  padding: AppDimensions.paddingV16,
                  shape: RoundedRectangleBorder(
                    borderRadius: AppDimensions.borderRadiusCircular16,
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppDimensions.spacing32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.error.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline,
                size: 40,
                color: AppTheme.error,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing24),
            Text(
              l10n.oops,
              style: AppTypography.textStyle22Bold.copyWith(
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.spacing8),
            Text(
              message,
              style: AppTypography.textStyle14Regular.copyWith(
                color: AppTheme.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spacing24),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(l10n.tryAgain),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.primary,
                side: const BorderSide(color: AppTheme.primary),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: AppDimensions.borderRadiusCircular12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
