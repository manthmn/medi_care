import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/constants/app_constants.dart';
import 'core/network/connectivity_cubit.dart';
import 'core/network/network_info.dart';
import 'core/preferences/preferences_service.dart';
import 'features/cart/data/datasources/cart_local_data_source.dart';
import 'features/cart/data/repositories/cart_repository_impl.dart';
import 'features/cart/domain/repositories/cart_repository.dart';
import 'features/cart/domain/usecases/cart_usecases.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
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
  // Initialize SharedPreferences first (required for PreferencesService)
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // Core
  sl
    ..registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: AppConstants.baseUrl,
          connectTimeout: AppConstants.connectTimeout,
          receiveTimeout: AppConstants.receiveTimeout,
        ),
      ),
    )
    ..registerLazySingleton<Connectivity>(() => Connectivity())
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    ..registerLazySingleton<AppDatabase>(() => AppDatabase())
    ..registerLazySingleton<PreferencesService>(
      () => PreferencesService(sl()),
    );

  // Data sources
  sl
    ..registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(sl()),
    )
    ..registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sl()),
    )
    ..registerLazySingleton<CartLocalDataSource>(
      () => CartLocalDataSourceImpl(sl()),
    );

  // Repositories
  sl
    ..registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    )
    ..registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(localDataSource: sl()),
    );

  // Use cases
  sl
    ..registerLazySingleton<GetProducts>(() => GetProducts(sl()))
    ..registerLazySingleton<SearchProducts>(() => SearchProducts())
    ..registerLazySingleton<CartUseCases>(() => CartUseCases(sl()));

  // Blocs / Cubits
  sl
    ..registerFactory(
      () => ConnectivityCubit(
        connectivity: sl(),
        networkInfo: sl(),
        productLocalDataSource: sl(),
      ),
    )
    ..registerFactory(
      () => ProductBloc(
        getProducts: sl(),
        searchProducts: sl(),
      ),
    )
    ..registerFactory(
      () => CartBloc(cartUseCases: sl()),
    );
}
