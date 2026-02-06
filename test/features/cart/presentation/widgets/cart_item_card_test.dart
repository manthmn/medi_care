import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medi_care/features/products/domain/entities/product.dart';
import 'package:medi_care/features/cart/domain/entities/cart_item.dart';
import 'package:medi_care/features/cart/presentation/widgets/cart_item_card.dart';
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

  final tCartItem = CartItem(product: tProduct, quantity: 2);

  Widget createWidgetUnderTest({required CartItem item}) {
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
          child: CartItemCard(
            item: item,
            onRemove: () {},
          ),
        ),
      ),
    );
  }

  testWidgets('should render cart item details correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(item: tCartItem));
    await tester.pump();

    expect(find.text('Fjallraven - Foldsack No. 1 Backpack'), findsOneWidget);
    expect(find.text('2'), findsOneWidget); // Quantity

    // Total price for 2 items @ 109.95 each = 219.9 -> Rounds to 220
    expect(find.textContaining('220'), findsOneWidget);
  });

  testWidgets('should have a remove button', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(item: tCartItem));
    await tester.pump();

    expect(find.byIcon(Icons.delete_outline), findsAtLeast(1));
  });
}
