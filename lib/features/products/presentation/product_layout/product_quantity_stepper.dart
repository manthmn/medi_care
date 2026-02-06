import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../domain/entities/product.dart';
import 'add_to_cart_button.dart';
import 'quantity_controls.dart';

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
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (prev, next) => _quantityFor(prev) != _quantityFor(next),
      builder: (context, state) {
        final quantity = _quantityFor(state);
        if (quantity == 0) {
          return AddToCartButton(
            product: product,
            isCompact: isCompact,
            onPressed: () => _updateQuantity(context, 1),
          );
        }
        return QuantityControls(
          product: product,
          quantity: quantity,
          isCompact: isCompact,
          onDecrement: () => _updateQuantity(context, quantity - 1),
          onIncrement: () => _updateQuantity(context, quantity + 1),
        );
      },
    );
  }

  int _quantityFor(CartState state) {
    final match = state.items.where((e) => e.product.id == product.id).toList();
    if (match.isEmpty) return 0;
    return match.first.quantity;
  }

  void _updateQuantity(BuildContext context, int quantity) {
    context.read<CartBloc>().add(
          CartItemQuantityChanged(product: product, quantity: quantity),
        );
  }
}
