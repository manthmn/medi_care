// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'मेडीकेयर';

  @override
  String get productDetails => 'उत्पाद विवरण';

  @override
  String get searchMedicines => 'उत्पाद खोजें...';

  @override
  String get noProductsAvailable => 'कोई उत्पाद उपलब्ध नहीं है।';

  @override
  String get somethingWentWrong => 'कुछ गलत हो गया';

  @override
  String get connectToInternet =>
      'उत्पाद लोड करने के लिए एक बार इंटरनेट से कनेक्ट करें।';

  @override
  String get retry => 'पुनः प्रयास करें';

  @override
  String get retryConnection => 'पुनः कनेक्ट करें';

  @override
  String get myCart => 'मेरी कार्ट';

  @override
  String itemCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'आइटम',
      one: 'आइटम',
    );
    return '$count $_temp0';
  }

  @override
  String get yourCartIsEmpty => 'आपकी कार्ट खाली है';

  @override
  String get emptyCartDescription =>
      'ऐसा लगता है कि आपने अभी तक कोई दवा नहीं जोड़ी है।';

  @override
  String get browseProducts => 'उत्पाद देखें';

  @override
  String get addToCart => 'कार्ट में जोड़ें';

  @override
  String get add => 'जोड़ें';

  @override
  String get viewCart => 'कार्ट देखें';

  @override
  String get clearCart => 'कार्ट खाली करें';

  @override
  String get clearCartConfirmation => 'क्या आप वाकई सभी आइटम हटाना चाहते हैं?';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get clear => 'साफ़ करें';

  @override
  String get proceedToCheckout => 'चेकआउट करें';

  @override
  String get orderSummary => 'ऑर्डर सारांश';

  @override
  String itemsCount(int count) {
    return 'आइटम ($count)';
  }

  @override
  String get delivery => 'डिलीवरी';

  @override
  String get free => 'मुफ़्त';

  @override
  String get discount => 'छूट';

  @override
  String get total => 'कुल';

  @override
  String get oops => 'उफ़!';

  @override
  String get tryAgain => 'पुनः प्रयास करें';

  @override
  String get deliverTo => 'डिलीवरी का पता';

  @override
  String get defaultAddress => 'मुंबई, 400001';

  @override
  String ratings(int count) {
    return '$count रेटिंग';
  }

  @override
  String get save => 'सेव करें';

  @override
  String get inStock => 'स्टॉक में';

  @override
  String get outOfStock => 'स्टॉक में नहीं';

  @override
  String get productDescription => 'उत्पाद विवरण';

  @override
  String get readMore => 'और पढ़ें';

  @override
  String get readLess => 'कम पढ़ें';

  @override
  String get deliveryInformation => 'डिलीवरी जानकारी';

  @override
  String get freeDelivery => 'मुफ़्त डिलीवरी';

  @override
  String get expectedDelivery => '2-3 कार्य दिवसों में डिलीवरी की उम्मीद';

  @override
  String get authentic => '100% असली';

  @override
  String get authenticDescription => 'सीधे निर्माताओं से प्राप्त';

  @override
  String get offlineShowingCached => 'ऑफ़लाइन • कैश्ड डेटा दिखा रहा है';

  @override
  String offlineWithLastSync(String time) {
    return 'ऑफ़लाइन • अंतिम सिंक $time';
  }

  @override
  String get syncedJustNow => 'अभी सिंक हुआ';

  @override
  String syncedMinutesAgo(int minutes) {
    return '$minutes मिनट पहले सिंक हुआ';
  }

  @override
  String syncedHoursAgo(int hours) {
    return '$hours घंटे पहले सिंक हुआ';
  }

  @override
  String syncedDaysAgo(int days) {
    return '$days दिन पहले सिंक हुआ';
  }

  @override
  String get syncedNever => 'कभी सिंक नहीं हुआ';

  @override
  String get priceEach => 'प्रति';

  @override
  String percentOff(String percent) {
    return '$percent% छूट';
  }

  @override
  String addToCartWithPrice(String price) {
    return 'कार्ट में जोड़ें  •  ₹$price';
  }

  @override
  String saveAmount(String amount) {
    return '₹$amount बचाएं';
  }

  @override
  String get currencySymbol => '₹';
}
