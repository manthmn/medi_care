import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/network/connectivity_cubit.dart';
import 'core/network/network_info.dart';
import 'features/products/data/datasources/product_local_data_source.dart';
import 'features/products/data/datasources/product_remote_data_source.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/domain/repositories/product_repository.dart';
import 'features/products/domain/usecases/get_products.dart';
import 'features/products/domain/usecases/search_products.dart';
import 'features/products/presentation/bloc/product_bloc.dart';
import 'shared/data/local/app_database.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  // Core
  sl
    ..registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: 'https://fakestoreapi.com',
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 15),
        ),
      ),
    )
    ..registerLazySingleton<Connectivity>(() => Connectivity())
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    ..registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Data sources
  sl
    ..registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(sl()),
    )
    ..registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sl()),
    );

  // Repositories
  sl
    .registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    );

  // Use cases
  sl
    ..registerLazySingleton<GetProducts>(() => GetProducts(sl()))
    ..registerLazySingleton<SearchProducts>(() => SearchProducts());

  // Blocs / Cubits
  sl
    ..registerFactory(
      () => ConnectivityCubit(connectivity: sl(), networkInfo: sl()),
    )
    ..registerFactory(
      () => ProductBloc(
        getProducts: sl(),
        searchProducts: sl(),
      ),
    );
}

