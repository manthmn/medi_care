import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/network/image_cache_manager.dart';
import 'product_shimmer.dart';

class ProductImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  const ProductImage({
    super.key,
    required this.url,
    this.height,
    this.width,
    this.borderRadius,
  });

  /// Legacy constructor for backwards compatibility
  factory ProductImage.square({
    Key? key,
    required String url,
    double size = double.infinity,
    double radius = 16,
  }) {
    return ProductImage(
      key: key,
      url: url,
      height: size,
      width: size,
      borderRadius: BorderRadius.circular(radius),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: CachedNetworkImage(
        imageUrl: url,
        cacheManager: AppImageCacheManager.instance,
        height: height,
        width: width ?? double.infinity,
        fit: BoxFit.cover,
        placeholder: (_, __) => const ProductShimmer(),
        errorWidget: (_, __, ___) => Container(
          height: height,
          width: width ?? double.infinity,
          color: Colors.grey.shade100,
          child: const Icon(Icons.broken_image, color: Colors.grey),
        ),
      ),
    );
  }
}
