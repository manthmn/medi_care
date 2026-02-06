import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_care/l10n/app_localizations.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../shared/widgets/cart_icon_badge.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/screens/cart_screen.dart';
import '../../domain/entities/product.dart';
import 'product_detail/widgets/bottom_action_bar.dart';
import 'product_detail/widgets/delivery_info_item.dart';
import 'product_detail/widgets/product_image_section.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Product product;

  static const routeName = '/product-detail';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isDescriptionExpanded = false;

  // Calculate discount (mock - 25% discount)
  double get _discountPercentage => 25.0;
  double get _originalPrice =>
      widget.product.price / (1 - _discountPercentage / 100);
  double get _discountAmount => _originalPrice - widget.product.price;
  int get _ratingCount => 1243; // Mock rating count

  /// Get current quantity from cart state
  int _getQuantityFromCart(CartState state) {
    final match =
        state.items.where((e) => e.product.id == widget.product.id).toList();
    if (match.isEmpty) return 0;
    return match.first.quantity;
  }

  void _updateQuantity(int quantity) {
    context.read<CartBloc>().add(
          CartItemQuantityChanged(
            product: widget.product,
            quantity: quantity,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: AppTheme.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          l10n.productDetails,
          style: AppTypography.textStyle20Bold.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        centerTitle: true,
        actions: const [
          CartIconBadge(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image Section
                  ProductImageSection(
                    imageUrl: widget.product.image,
                    discountPercentage: _discountPercentage,
                  ),
                  const SizedBox(height: AppDimensions.spacing20),
                  // Product Information
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      AppDimensions.spacing16,
                      AppDimensions.spacing12,
                      AppDimensions.spacing16,
                      AppDimensions.spacing12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Title
                        Text(
                          widget.product.title,
                          style: AppTypography.textStyle20Bold.copyWith(
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacing12),
                        // Rating Badge
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppDimensions.spacing8,
                                vertical: AppDimensions.spacing4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.success,
                                borderRadius:
                                    AppDimensions.borderRadiusCircular6,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: AppTheme.backgroundWhite,
                                    size: AppDimensions.iconSize14,
                                  ),
                                  const SizedBox(width: AppDimensions.spacing4),
                                  Text(
                                    widget.product.rating.toStringAsFixed(1),
                                    style: AppTypography.textStyle12SemiBold
                                        .copyWith(
                                      color: AppTheme.backgroundWhite,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppDimensions.spacing8),
                            Text(
                              l10n.ratings(_ratingCount),
                              style: AppTypography.textStyle13Regular.copyWith(
                                color: AppTheme.textSecondary,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppDimensions.spacing16),
                        // Pricing Section
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${l10n.currencySymbol}${widget.product.price.toStringAsFixed(0)}',
                              style: AppTypography.textStyle28Bold.copyWith(
                                color: AppTheme.textPrimary,
                              ),
                            ),
                            const SizedBox(width: AppDimensions.spacing12),
                            Text(
                              '${l10n.currencySymbol}${_originalPrice.toStringAsFixed(0)}',
                              style: AppTypography.textStyle18SemiBold.copyWith(
                                color: AppTheme.textTertiary,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppDimensions.spacing8,
                                vertical: AppDimensions.spacing4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.successLight10,
                                borderRadius:
                                    AppDimensions.borderRadiusCircular6,
                              ),
                              child: Text(
                                '${l10n.save} ${l10n.currencySymbol}${_discountAmount.toStringAsFixed(0)}',
                                style:
                                    AppTypography.textStyle13SemiBold.copyWith(
                                  color: AppTheme.success,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppDimensions.spacing16),
                        // Stock Status
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.spacing10,
                            vertical: AppDimensions.spacing6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.successLight15,
                            borderRadius: AppDimensions.borderRadiusCircular8,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: AppDimensions.spacing8,
                                height: AppDimensions.spacing8,
                                decoration: const BoxDecoration(
                                  color: AppTheme.success,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: AppDimensions.spacing6),
                              Text(
                                l10n.inStock,
                                style:
                                    AppTypography.textStyle13SemiBold.copyWith(
                                  color: AppTheme.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacing24),
                        // Product Description Section
                        Text(
                          l10n.productDescription,
                          style: AppTypography.textStyle16SemiBold.copyWith(
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacing12),
                        Text(
                          widget.product.description,
                          maxLines: _isDescriptionExpanded ? null : 3,
                          overflow: _isDescriptionExpanded
                              ? TextOverflow.visible
                              : TextOverflow.ellipsis,
                          style: AppTypography.textStyle14Regular.copyWith(
                            color: AppTheme.textSecondary,
                            height: AppTheme.lineHeight1_5,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isDescriptionExpanded = !_isDescriptionExpanded;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: AppDimensions.spacing8),
                            child: Row(
                              children: [
                                Text(
                                  _isDescriptionExpanded
                                      ? l10n.readLess
                                      : l10n.readMore,
                                  style: AppTypography.textStyle14SemiBold
                                      .copyWith(
                                    color: AppTheme.primary,
                                  ),
                                ),
                                const SizedBox(width: AppDimensions.spacing4),
                                Icon(
                                  _isDescriptionExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  size: AppDimensions.iconSize18,
                                  color: AppTheme.primary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacing24),
                        // Delivery Information Section
                        Text(
                          l10n.deliveryInformation,
                          style: AppTypography.textStyle16SemiBold.copyWith(
                            color: AppTheme.textPrimary,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spacing16),
                        DeliveryInfoItem(
                          icon: Icons.local_shipping_outlined,
                          title: l10n.freeDelivery,
                          subtitle: l10n.expectedDelivery,
                        ),
                        const SizedBox(height: AppDimensions.spacing16),
                        DeliveryInfoItem(
                          icon: Icons.verified_outlined,
                          title: l10n.authentic,
                          subtitle: l10n.authenticDescription,
                        ),
                        const SizedBox(height: 100), // Space for bottom bar
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Action Bar - synced with cart state
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              final quantity = _getQuantityFromCart(state);
              return BottomActionBar(
                quantity: quantity,
                price: widget.product.price,
                cartTotal: state.total,
                cartItemCount: state.items.fold<int>(
                  0,
                  (sum, item) => sum + item.quantity,
                ),
                onQuantityChanged: _updateQuantity,
                onAddToCart: () => _updateQuantity(1),
                onGoToCart: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
