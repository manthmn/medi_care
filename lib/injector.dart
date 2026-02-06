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
import 'features/cart/domain/usecases/add_or_update_item.dart';
import 'features/cart/domain/usecases/clear_cart.dart';
import 'features/cart/domain/usecases/get_cart.dart';
import 'features/cart/domain/usecases/remove_item.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/products/data/datasources/product_local_data_source.dart';
import 'features/products/data/datasources/product_remote_data_source.dart';
import 'features/products/data/repositories/product_repository_impl.dart';
import 'features/products/data/repositories/sync_repository_impl.dart';
import 'features/products/domain/repositories/product_repository.dart';
import 'features/products/domain/repositories/sync_repository.dart';
import 'features/products/domain/usecases/get_products.dart';
import 'features/products/domain/usecases/search_products.dart';
import 'features/products/presentation/bloc/product_bloc.dart';
import 'features/products/presentation/bloc/sync_cubit.dart';
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
    ..registerLazySingleton<SyncRepository>(
      () => SyncRepositoryImpl(sl()),
    )
    ..registerLazySingleton<CartRepository>(
      () => CartRepositoryImpl(localDataSource: sl()),
    );

  // Use cases
  sl
    ..registerLazySingleton<GetProducts>(() => GetProducts(sl()))
    ..registerLazySingleton<SearchProducts>(() => SearchProducts())
    ..registerLazySingleton<GetCartUseCase>(() => GetCartUseCase(sl()))
    ..registerLazySingleton<AddOrUpdateCartItemUseCase>(
      () => AddOrUpdateCartItemUseCase(sl()),
    )
    ..registerLazySingleton<RemoveCartItemUseCase>(
      () => RemoveCartItemUseCase(sl()),
    )
    ..registerLazySingleton<ClearCartUseCase>(() => ClearCartUseCase(sl()));

  // Blocs / Cubits
  sl
    ..registerFactory(
      () => ConnectivityCubit(
        connectivity: sl(),
        networkInfo: sl(),
      ),
    )
    ..registerFactory(
      () => SyncCubit(syncRepository: sl()),
    )
    ..registerFactory(
      () => ProductBloc(
        getProducts: sl(),
        searchProducts: sl(),
      ),
    )
    ..registerFactory(
      () => CartBloc(
        getCart: sl(),
        addOrUpdateItem: sl(),
        removeItem: sl(),
        clearCart: sl(),
      ),
    );
}
