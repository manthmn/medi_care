import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl({
    required ProductRemoteDataSource remoteDataSource,
    required ProductLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _networkInfo = networkInfo;

  final ProductRemoteDataSource _remoteDataSource;
  final ProductLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    final isOnline = await _networkInfo.isConnected;

    if (isOnline) {
      try {
        final remote = await _remoteDataSource.fetchProducts();
        await _cacheProducts(remote);
        return Right(remote);
      } catch (e) {
        // Remote failed; gracefully fall back to cache.
        final cached = await _getFromCache();
        if (cached != null) return Right(cached);
        return Left(ServerFailure('Failed to load products: $e'));
      }
    } else {
      final cached = await _getFromCache();
      if (cached != null) return Right(cached);
      return const Left(
        CacheFailure(
          'No network connection and no cached data available. Please connect to the internet once.',
        ),
      );
    }
  }

  Future<void> _cacheProducts(List<ProductModel> products) async {
    await _localDataSource.cacheProducts(products);
    await _localDataSource.setLastSynced(DateTime.now());
  }

  Future<List<ProductModel>?> _getFromCache() async {
    final cached = await _localDataSource.getCachedProducts();
    if (cached.isEmpty) return null;
    return cached;
  }
}

