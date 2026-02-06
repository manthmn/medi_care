import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/network/connectivity_cubit.dart';
import 'features/products/presentation/bloc/product_bloc.dart';
import 'features/products/presentation/screens/product_list_screen.dart';
import 'injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(const MyApp());
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
      ],
      child: MaterialApp(
        title: 'MediCare',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        ),
        routes: {
          ProductListScreen.routeName: (_) => const ProductListScreen(),
        },
        initialRoute: ProductListScreen.routeName,
      ),
    );
  }
}

