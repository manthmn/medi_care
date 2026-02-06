import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';

class ProductQuantityStepper extends StatelessWidget {
  const ProductQuantityStepper({
    super.key,
    required this.product,
    this.isCompact = true,
  });

  final Product product;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}