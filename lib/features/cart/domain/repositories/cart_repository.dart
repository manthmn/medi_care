import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../products/domain/entities/product.dart';
import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<Either<Failure, List<CartItem>>> getCart();

  Future<Either<Failure, void>> addOrUpdateItem({
    required Product product,
    required int quantity,
  });

  Future<Either<Failure, void>> removeItem(int productId);

  Future<Either<Failure, void>> clear();
}

