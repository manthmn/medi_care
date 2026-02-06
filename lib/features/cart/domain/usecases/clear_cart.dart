import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/cart_repository.dart';

class ClearCartUseCase {
  ClearCartUseCase(this._repository);
  final CartRepository _repository;

  Future<Either<Failure, void>> call() => _repository.clear();
}
