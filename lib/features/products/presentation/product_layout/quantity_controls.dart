import 'package:flutter/material.dart';
import '../../../../shared/widgets/app_quantity_stepper.dart';
import '../../domain/entities/product.dart';

class QuantityControls extends StatelessWidget {
  final Product product;
  final int quantity;
  final bool isCompact;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantityControls({
    super.key,
    required this.product,
    required this.quantity,
    required this.isCompact,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return AppQuantityStepper(
      quantity: quantity,
      isCompact: isCompact,
      onIncrement: onIncrement,
      onDecrement: onDecrement,
      showDeleteOnOne: true,
    );
  }
}
