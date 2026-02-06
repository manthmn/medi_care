import 'package:cached_network_image/cached_network_image.dart';
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
                  _ProductImageSection(
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
                        _DeliveryInfoItem(
                          icon: Icons.local_shipping_outlined,
                          title: l10n.freeDelivery,
                          subtitle: l10n.expectedDelivery,
                        ),
                        const SizedBox(height: AppDimensions.spacing16),
                        _DeliveryInfoItem(
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
              return _BottomActionBar(
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

class _ProductImageSection extends StatelessWidget {
  const _ProductImageSection({
    required this.imageUrl,
    required this.discountPercentage,
  });

  final String imageUrl;
  final double discountPercentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: AppTheme.imageHeight300,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: AppTheme.surfaceGrey200,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: AppTheme.surfaceGrey200,
              child: const Icon(Icons.broken_image,
                  size: AppDimensions.iconSize64),
            ),
          ),
        ),
        // Discount Badge
        Positioned(
          top: AppDimensions.spacing16,
          left: AppDimensions.spacing16,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacing12,
              vertical: AppDimensions.spacing6,
            ),
            decoration: BoxDecoration(
              color: AppTheme.errorPink,
              borderRadius: AppDimensions.borderRadiusCircular8,
            ),
            child: Text(
              '${discountPercentage.toStringAsFixed(0)}% OFF',
              style: AppTypography.textStyle14SemiBold.copyWith(
                color: AppTheme.backgroundWhite,
                fontWeight: AppTypography.fontWeightBold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DeliveryInfoItem extends StatelessWidget {
  const _DeliveryInfoItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: AppDimensions.padding8,
          decoration: BoxDecoration(
            color: AppTheme.primaryLight10,
            borderRadius: AppDimensions.borderRadiusCircular8,
          ),
          child: Icon(
            icon,
            color: AppTheme.primary,
            size: AppDimensions.iconSize24,
          ),
        ),
        const SizedBox(width: AppDimensions.spacing12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTypography.textStyle15SemiBold.copyWith(
                  color: AppTheme.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimensions.spacing4),
              Text(
                subtitle,
                style: AppTypography.textStyle13Regular.copyWith(
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar({
    required this.quantity,
    required this.price,
    required this.cartTotal,
    required this.cartItemCount,
    required this.onQuantityChanged,
    required this.onAddToCart,
    required this.onGoToCart,
  });

  final int quantity;
  final double price;
  final double cartTotal;
  final int cartItemCount;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onAddToCart;
  final VoidCallback onGoToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: AppTheme.opacity05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: AppTheme.bottomBarPadding,
      child: SafeArea(
        top: false,
        child: quantity == 0
            ? _buildAddToCartButton()
            : _buildQuantityWithCartBar(),
      ),
    );
  }

  Widget _buildAddToCartButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onAddToCart,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primary,
          foregroundColor: AppTheme.backgroundWhite,
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadiusCircular12,
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart_outlined,
                size: AppDimensions.iconSize20),
            const SizedBox(width: AppDimensions.spacing8),
            Text(
              'Add to Cart  •  ₹${price.toStringAsFixed(0)}',
              style: AppTypography.textStyle16SemiBold,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantityWithCartBar() {
    return Row(
      children: [
        // Quantity Selector
        Container(
          decoration: BoxDecoration(
            color: AppTheme.primaryLight,
            borderRadius: AppDimensions.borderRadiusCircular12,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  quantity == 1 ? Icons.delete_outline : Icons.remove,
                  color: AppTheme.primary,
                ),
                onPressed: () => onQuantityChanged(quantity - 1),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: AppTheme.buttonHeight40,
                  minHeight: AppTheme.buttonHeight40,
                ),
              ),
              SizedBox(
                width: 30,
                child: Text(
                  '$quantity',
                  textAlign: TextAlign.center,
                  style: AppTypography.textStyle16SemiBold.copyWith(
                    fontWeight: AppTypography.fontWeightBold,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: AppTheme.primary),
                onPressed: () => onQuantityChanged(quantity + 1),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: AppTheme.buttonHeight40,
                  minHeight: AppTheme.buttonHeight40,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppDimensions.spacing12),
        // Go to Cart Button (Zepto style)
        Expanded(
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: onGoToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: AppTheme.backgroundWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: AppDimensions.borderRadiusCircular12,
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$cartItemCount ${cartItemCount == 1 ? 'item' : 'items'}',
                        style: AppTypography.textStyle12Regular.copyWith(
                          color: AppTheme.textOnPrimary.withValues(alpha: 0.8),
                        ),
                      ),
                      Text(
                        '₹${cartTotal.toStringAsFixed(0)}',
                        style: AppTypography.textStyle16SemiBold.copyWith(
                          color: AppTheme.textOnPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'View Cart',
                        style: AppTypography.textStyle14SemiBold.copyWith(
                          color: AppTheme.textOnPrimary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward, size: 18),
                    ],
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
