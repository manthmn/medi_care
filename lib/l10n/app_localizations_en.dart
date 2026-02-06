// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'MediCare';

  @override
  String get productDetails => 'Product Details';

  @override
  String get searchMedicines => 'Search products...';

  @override
  String get noProductsAvailable => 'No products available.';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get connectToInternet =>
      'Connect to the internet once to load products.';

  @override
  String get retry => 'Retry';

  @override
  String get retryConnection => 'Retry Connection';

  @override
  String get myCart => 'My Cart';

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'items',
      one: 'item',
    );
    return '$count $_temp0';
  }

  @override
  String get yourCartIsEmpty => 'Your cart is empty';

  @override
  String get emptyCartDescription =>
      'Looks like you haven\'t added any medicines yet.';

  @override
  String get browseProducts => 'Browse Products';

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get add => 'Add';

  @override
  String get viewCart => 'View Cart';

  @override
  String get clearCart => 'Clear Cart';

  @override
  String get clearCartConfirmation =>
      'Are you sure you want to remove all items?';

  @override
  String get cancel => 'Cancel';

  @override
  String get clear => 'Clear';

  @override
  String get proceedToCheckout => 'Proceed to Checkout';

  @override
  String get orderSummary => 'Order Summary';

  @override
  String itemsCount(int count) {
    return 'Items ($count)';
  }

  @override
  String get delivery => 'Delivery';

  @override
  String get free => 'FREE';

  @override
  String get discount => 'Discount';

  @override
  String get total => 'Total';

  @override
  String get oops => 'Oops!';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get deliverTo => 'Deliver to';

  @override
  String get defaultAddress => 'Mumbai, 400001';

  @override
  String ratings(int count) {
    return '$count ratings';
  }

  @override
  String get save => 'Save';

  @override
  String get inStock => 'In Stock';

  @override
  String get outOfStock => 'Out of Stock';

  @override
  String get productDescription => 'Product Description';

  @override
  String get readMore => 'Read More';

  @override
  String get readLess => 'Read Less';

  @override
  String get deliveryInformation => 'Delivery Information';

  @override
  String get freeDelivery => 'Free Delivery';

  @override
  String get expectedDelivery => 'Expected delivery in 2-3 business days';

  @override
  String get authentic => '100% Authentic';

  @override
  String get authenticDescription => 'Sourced directly from manufacturers';

  @override
  String get offlineShowingCached => 'Offline • Showing cached data';

  @override
  String offlineWithLastSync(String time) {
    return 'Offline • Last synced $time';
  }

  @override
  String get syncedJustNow => 'Synced just now';

  @override
  String syncedMinutesAgo(int minutes) {
    return 'Synced $minutes min ago';
  }

  @override
  String syncedHoursAgo(int hours) {
    return 'Synced $hours hr ago';
  }

  @override
  String syncedDaysAgo(int days) {
    return 'Synced $days days ago';
  }

  @override
  String get syncedNever => 'Never synced';

  @override
  String get priceEach => 'each';

  @override
  String percentOff(String percent) {
    return '$percent% OFF';
  }

  @override
  String addToCartWithPrice(String price) {
    return 'Add to Cart  •  ₹$price';
  }

  @override
  String saveAmount(String amount) {
    return 'Save ₹$amount';
  }

  @override
  String get currencySymbol => '₹';
}
