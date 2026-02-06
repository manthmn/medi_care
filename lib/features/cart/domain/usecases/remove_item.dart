import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/cart_repository.dart';

class RemoveCartItemUseCase {
  RemoveCartItemUseCase(this._repository);
  final CartRepository _repository;

  Future<Either<Failure, void>> call(int productId) =>
      _repository.removeItem(productId);
}
