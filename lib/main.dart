import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:medi_care/l10n/app_localizations.dart';

import 'core/network/connectivity_cubit.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/cart/presentation/screens/cart_screen.dart';
import 'features/products/domain/entities/product.dart';
import 'features/products/presentation/bloc/product_bloc.dart';
import 'features/products/presentation/screens/product_detail_screen.dart';
import 'features/products/presentation/screens/product_list_screen.dart';
import 'injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(
    DevicePreview(
      enabled: kDebugMode, // Only enabled in debug mode
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ConnectivityCubit>(
          create: (_) => sl<ConnectivityCubit>()..startListening(),
        ),
        BlocProvider<ProductBloc>(
          create: (_) =>
              sl<ProductBloc>()..add(const ProductEvent.loadRequested()),
        ),
        BlocProvider<CartBloc>(
          create: (_) => sl<CartBloc>()..add(const CartStarted()),
        ),
      ],
      child: MaterialApp(
        title: 'MediCare',
        debugShowCheckedModeBanner: false,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('hi'),
        ],
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        ),
        routes: {
          ProductListScreen.routeName: (_) => const ProductListScreen(),
          CartScreen.routeName: (_) => const CartScreen(),
          ProductDetailScreen.routeName: (context) {
            final product =
                ModalRoute.of(context)!.settings.arguments as Product;
            return ProductDetailScreen(product: product);
          },
        },
        initialRoute: ProductListScreen.routeName,
      ),
    );
  }
}
