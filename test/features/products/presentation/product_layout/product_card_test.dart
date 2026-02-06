import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_care/features/products/domain/entities/product.dart';
import 'package:medi_care/features/products/presentation/product_layout/product_card.dart';
import 'package:medi_care/features/products/presentation/product_layout/product_layout.dart';
import 'package:medi_care/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:medi_care/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MockCartBloc extends Mock implements CartBloc {}

void main() {
  late MockCartBloc mockCartBloc;

  setUpAll(() {
    registerFallbackValue(const CartStarted());
  });

  setUp(() {
    mockCartBloc = MockCartBloc();
    when(() => mockCartBloc.state).thenReturn(const CartState.initial());
    when(() => mockCartBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  final tProduct = Product(
    id: 1,
    title: 'Fjallraven - Foldsack No. 1 Backpack',
    price: 109.95,
    description: 'Your perfect pack for everyday use and walks in the forest.',
    image: 'https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg',
    rating: 3.9,
    updatedAt: DateTime.now(),
  );

  Widget createWidgetUnderTest({
    required Product product,
    required ProductLayout layout,
  }) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: Scaffold(
        body: BlocProvider<CartBloc>.value(
          value: mockCartBloc,
          child: ProductCard(
            product: product,
            layout: layout,
            onTap: () {},
          ),
        ),
      ),
    );
  }

  testWidgets('should render product title and price in grid layout',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(
      product: tProduct,
      layout: ProductLayout.grid,
    ));
    await tester.pump();

    expect(find.text('Fjallraven - Foldsack No. 1 Backpack'), findsOneWidget);
    // Price rendering might depend on localization, usually it's currency symbol + price
    expect(find.textContaining('110'), findsOneWidget);
  });

  testWidgets('should render product title and description in list layout',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(
      product: tProduct,
      layout: ProductLayout.list,
    ));
    await tester.pump();

    expect(find.text('Fjallraven - Foldsack No. 1 Backpack'), findsOneWidget);
    expect(
        find.text(
            'Your perfect pack for everyday use and walks in the forest.'),
        findsOneWidget);
  });
}
