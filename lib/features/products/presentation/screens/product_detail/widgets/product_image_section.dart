import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medi_care/core/theme/app_dimensions.dart';
import 'package:medi_care/core/theme/app_theme.dart';
import 'package:medi_care/core/theme/app_typography.dart';

class ProductImageSection extends StatelessWidget {
  const ProductImageSection({
    super.key,
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
