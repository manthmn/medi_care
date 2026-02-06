import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../products/data/models/product_model.dart';
import '../../../products/domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';
import '../datasources/cart_local_data_source.dart';

class CartRepositoryImpl implements CartRepository {
  CartRepositoryImpl({required CartLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  final CartLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, void>> addOrUpdateItem({
    required Product product,
    required int quantity,
  }) async {
    try {
      if (quantity <= 0) {
        await _localDataSource.removeCartItem(product.id);
      } else {
        await _localDataSource.upsertCartItem(product.id, quantity);
      }
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to update cart: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> clear() async {
    try {
      await _localDataSource.clearCart();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to clear cart: $e'));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCart() async {
    try {
      final rows = await _localDataSource.getCartRows();
      if (rows.isEmpty) return const Right([]);

      final result = <CartItem>[];
      for (final row in rows) {
        final productRow =
            await _localDataSource.getProductForCartRow(row.productId);
        if (productRow == null) continue;
        final product = ProductModel.fromDb(productRow);
        result.add(CartItem(product: product, quantity: row.quantity));
      }
      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Failed to load cart: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> removeItem(int productId) async {
    try {
      await _localDataSource.removeCartItem(productId);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to remove item: $e'));
    }
  }
}

