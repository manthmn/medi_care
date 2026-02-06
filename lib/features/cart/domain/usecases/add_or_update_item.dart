import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../products/domain/entities/product.dart';
import '../repositories/cart_repository.dart';

class AddOrUpdateCartItemUseCase {
  AddOrUpdateCartItemUseCase(this._repository);
  final CartRepository _repository;

  Future<Either<Failure, void>> call({
    required Product product,
    required int quantity,
  }) {
    return _repository.addOrUpdateItem(product: product, quantity: quantity);
  }
}
