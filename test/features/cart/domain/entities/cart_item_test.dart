import 'package:flutter_test/flutter_test.dart';
import 'package:medi_care/features/products/domain/entities/product.dart';
import 'package:medi_care/features/cart/domain/entities/cart_item.dart';

void main() {
  final tProduct = Product(
    id: 1,
    title: 'Samsung 49-Inch CHG90 144Hz Curved Gaming Monitor',
    price: 999.99,
    description: '49 inch super ultra wide 32:9 curved gaming monitor',
    image: 'https://fakestoreapi.com/img/81Zt42ioCgL._AC_SX679_.jpg',
    rating: 2.2,
    updatedAt: DateTime.now(),
  );

  test('should calculate total price correctly for quantity 1', () {
    final cartItem = CartItem(product: tProduct, quantity: 1);
    expect(cartItem.totalPrice, 999.99);
  });

  test('should calculate total price correctly for quantity 2', () {
    final cartItem = CartItem(product: tProduct, quantity: 2);
    expect(cartItem.totalPrice, 1999.98);
  });

  test('should support equatable', () {
    final cartItem1 = CartItem(product: tProduct, quantity: 2);
    final cartItem2 = CartItem(product: tProduct, quantity: 2);
    expect(cartItem1, cartItem2);
  });
}
