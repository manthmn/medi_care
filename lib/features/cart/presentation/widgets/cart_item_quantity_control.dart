import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/widgets/app_quantity_stepper.dart';
import '../../domain/entities/cart_item.dart';
import '../bloc/cart_bloc.dart';

class CartItemQuantityControl extends StatelessWidget {
  const CartItemQuantityControl({super.key, required this.item});

  final CartItem item;

  @override
  Widget build(BuildContext context) {
    return AppQuantityStepper(
      quantity: item.quantity,
      isCompact: true,
      showDeleteOnOne: true,
      onDecrement: () {
        context.read<CartBloc>().add(
              CartItemQuantityChanged(
                product: item.product,
                quantity: item.quantity - 1,
              ),
            );
      },
      onIncrement: () {
        context.read<CartBloc>().add(
              CartItemQuantityChanged(
                product: item.product,
                quantity: item.quantity + 1,
              ),
            );
      },
    );
  }
}
