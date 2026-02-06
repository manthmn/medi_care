import 'package:shared_preferences/shared_preferences.dart';

import '../../features/products/presentation/screens/product_list_screen.dart';

/// Service for managing app preferences using SharedPreferences.
class PreferencesService {
  PreferencesService(this._prefs);

  final SharedPreferences _prefs;

  static const String _viewModeKey = 'view_mode';

  /// Get the saved view mode, defaults to grid.
  ViewMode getViewMode() {
    final value = _prefs.getString(_viewModeKey);
    if (value == 'list') return ViewMode.list;
    return ViewMode.grid;
  }

  /// Save the view mode preference.
  Future<void> setViewMode(ViewMode mode) async {
    await _prefs.setString(_viewModeKey, mode.name);
  }
}
