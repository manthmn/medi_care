import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../products/domain/entities/product.dart';
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class CartUseCases {
  CartUseCases(this._repository);

  final CartRepository _repository;

  Future<Either<Failure, List<CartItem>>> getCart() => _repository.getCart();

  Future<Either<Failure, void>> addOrUpdateItem({
    required Product product,
    required int quantity,
  }) {
    return _repository.addOrUpdateItem(product: product, quantity: quantity);
  }

  Future<Either<Failure, void>> removeItem(int productId) =>
      _repository.removeItem(productId);

  Future<Either<Failure, void>> clear() => _repository.clear();
}

