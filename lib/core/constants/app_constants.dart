/// Centralized application constants
class AppConstants {
  AppConstants._();

  // ===========================================================================
  // API CONFIGURATION
  // ===========================================================================

  /// Base URL for the API
  static const String baseUrl = 'https://fakestoreapi.com';

  /// API Endpoints
  static const String productsEndpoint = '/products';

  /// Database keys
  static const String productsLastSyncedKey = 'products_last_synced';

  // ===========================================================================
  // TIMEOUTS
  // ===========================================================================

  /// Connection timeout duration
  static const Duration connectTimeout = Duration(seconds: 15);

  /// Receive timeout duration
  static const Duration receiveTimeout = Duration(seconds: 15);

  // ===========================================================================
  // ROUTE NAMES
  // ===========================================================================

  /// Products list screen route
  static const String productsRoute = '/products';

  /// Cart screen route
  static const String cartRoute = '/cart';

  /// Product detail screen route
  static const String productDetailRoute = '/product-detail';

  // ===========================================================================
  // APP INFO
  // ===========================================================================

  /// Application name
  static const String appName = 'MediCare';

  // ===========================================================================
  // MOCK VALUES
  // ===========================================================================

  /// Mock discount percentage for product details
  static const double mockDiscountPercentage = 25.0;

  /// Mock rating count for product details
  static const int mockRatingCount = 1243;

  // ===========================================================================
  // UI CONSTANTS
  // ===========================================================================

  /// Maximum cart badge count display
  static const int maxBadgeCount = 99;

  /// Bottom bar fixed height
  static const double bottomBarHeight = 52.0;

  /// Quantity selector width
  static const double quantitySelectorWidth = 30.0;
}
