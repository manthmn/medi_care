import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Custom cache manager for product images with persistent storage.
/// Images are stored locally and available offline.
class AppImageCacheManager {
  static const _key = 'medicareCachedImages';

  static final CacheManager instance = CacheManager(
    Config(
      _key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 200,
    ),
  );
}
