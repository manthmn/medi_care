import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi')
  ];

  /// The application name
  ///
  /// In en, this message translates to:
  /// **'MediCare'**
  String get appName;

  /// Title for product details screen
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetails;

  /// Placeholder text for search field
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get searchMedicines;

  /// Message when product list is empty
  ///
  /// In en, this message translates to:
  /// **'No products available.'**
  String get noProductsAvailable;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// Message when app is offline on first launch
  ///
  /// In en, this message translates to:
  /// **'Connect to the internet once to load products.'**
  String get connectToInternet;

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Retry connection button text
  ///
  /// In en, this message translates to:
  /// **'Retry Connection'**
  String get retryConnection;

  /// Cart screen title
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get myCart;

  /// Item count with pluralization
  ///
  /// In en, this message translates to:
  /// **'{count} {count, plural, =1{item} other{items}}'**
  String itemCount(int count);

  /// Empty cart title
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get yourCartIsEmpty;

  /// Empty cart description
  ///
  /// In en, this message translates to:
  /// **'Looks like you haven\'t added any medicines yet.'**
  String get emptyCartDescription;

  /// Button to browse products
  ///
  /// In en, this message translates to:
  /// **'Browse Products'**
  String get browseProducts;

  /// Add to cart button text
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// Short add button text
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// View cart button text
  ///
  /// In en, this message translates to:
  /// **'View Cart'**
  String get viewCart;

  /// Clear cart dialog title
  ///
  /// In en, this message translates to:
  /// **'Clear Cart'**
  String get clearCart;

  /// Clear cart confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove all items?'**
  String get clearCartConfirmation;

  /// Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Clear button text
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// Checkout button text
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get proceedToCheckout;

  /// Order summary section title
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// Items count label in summary
  ///
  /// In en, this message translates to:
  /// **'Items ({count})'**
  String itemsCount(int count);

  /// Delivery label
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// Free delivery text
  ///
  /// In en, this message translates to:
  /// **'FREE'**
  String get free;

  /// Discount label
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// Total label
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// Error state title
  ///
  /// In en, this message translates to:
  /// **'Oops!'**
  String get oops;

  /// Try again button text
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// Delivery address label
  ///
  /// In en, this message translates to:
  /// **'Deliver to'**
  String get deliverTo;

  /// Default delivery address
  ///
  /// In en, this message translates to:
  /// **'Mumbai, 400001'**
  String get defaultAddress;

  /// Rating count text
  ///
  /// In en, this message translates to:
  /// **'{count} ratings'**
  String ratings(int count);

  /// Save label
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// In stock status
  ///
  /// In en, this message translates to:
  /// **'In Stock'**
  String get inStock;

  /// Out of stock status
  ///
  /// In en, this message translates to:
  /// **'Out of Stock'**
  String get outOfStock;

  /// Product description section title
  ///
  /// In en, this message translates to:
  /// **'Product Description'**
  String get productDescription;

  /// Read more button text
  ///
  /// In en, this message translates to:
  /// **'Read More'**
  String get readMore;

  /// Read less button text
  ///
  /// In en, this message translates to:
  /// **'Read Less'**
  String get readLess;

  /// Delivery information section title
  ///
  /// In en, this message translates to:
  /// **'Delivery Information'**
  String get deliveryInformation;

  /// Free delivery title
  ///
  /// In en, this message translates to:
  /// **'Free Delivery'**
  String get freeDelivery;

  /// Expected delivery description
  ///
  /// In en, this message translates to:
  /// **'Expected delivery in 2-3 business days'**
  String get expectedDelivery;

  /// Authenticity title
  ///
  /// In en, this message translates to:
  /// **'100% Authentic'**
  String get authentic;

  /// Authenticity description
  ///
  /// In en, this message translates to:
  /// **'Sourced directly from manufacturers'**
  String get authenticDescription;

  /// Offline status message
  ///
  /// In en, this message translates to:
  /// **'Offline • Showing cached data'**
  String get offlineShowingCached;

  /// Offline status with last sync time
  ///
  /// In en, this message translates to:
  /// **'Offline • Last synced {time}'**
  String offlineWithLastSync(String time);

  /// Synced just now message
  ///
  /// In en, this message translates to:
  /// **'Synced just now'**
  String get syncedJustNow;

  /// Synced minutes ago message
  ///
  /// In en, this message translates to:
  /// **'Synced {minutes} min ago'**
  String syncedMinutesAgo(int minutes);

  /// Synced hours ago message
  ///
  /// In en, this message translates to:
  /// **'Synced {hours} hr ago'**
  String syncedHoursAgo(int hours);

  /// Synced days ago message
  ///
  /// In en, this message translates to:
  /// **'Synced {days} days ago'**
  String syncedDaysAgo(int days);

  /// Never synced message
  ///
  /// In en, this message translates to:
  /// **'Never synced'**
  String get syncedNever;

  /// Price per item suffix
  ///
  /// In en, this message translates to:
  /// **'each'**
  String get priceEach;

  /// Discount percentage badge
  ///
  /// In en, this message translates to:
  /// **'{percent}% OFF'**
  String percentOff(String percent);

  /// Add to cart button with price
  ///
  /// In en, this message translates to:
  /// **'Add to Cart  •  ₹{price}'**
  String addToCartWithPrice(String price);

  /// Amount saved badge
  ///
  /// In en, this message translates to:
  /// **'Save ₹{amount}'**
  String saveAmount(String amount);

  /// Currency symbol for India
  ///
  /// In en, this message translates to:
  /// **'₹'**
  String get currencySymbol;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
