import 'dart:convert';

import 'package:apphud/models/apphud_models/apphud_placement.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_premium_source.dart';

mixin ApphudCacheMixin {
  SharedPreferences? _preferences;
  void logInfo(Object message);
  UserPremiumSource userPremiumSource(String source);

  static const apphudPlacementsCache = 'apphud_placements_cache';
  static const userPremiumSourceCache = 'user_premium_source_cache';
  static const apphudUserIdCache = 'apphud_user_id_cache';
  static const debugPremiumDateCache = 'debug_premium_date_cache';

  Future<void> _initCache() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> cachePlacements(List<ApphudPlacement> placements) async {
    await _initCache();
    final placementsJson = placements.map((e) => e.toJson()).toList();
    final placementsJsonString = jsonEncode(placementsJson);

    await _preferences!.setString(apphudPlacementsCache, placementsJsonString);
    logInfo('ApphudCacheMixin Placements cached length: ${placements.length}');
  }

  Future<List<ApphudPlacement>> getCachedPlacements() async {
    logInfo('ApphudCacheMixin getCachedPlacements');
    await _initCache();
    final placementsJsonString = _preferences?.getString(apphudPlacementsCache);
    if (placementsJsonString == null) {
      return [];
    }

    final placementsJson = jsonDecode(placementsJsonString) as List;
    final placements = placementsJson
        .map((e) => ApphudPlacement.fromJson(e as Map))
        .toList();
    return placements;
  }

  Future<void> cacheIsPremium(UserPremiumSource userPremiumSource) async {
    await _initCache();
    await _preferences!.setString(
      userPremiumSourceCache,
      userPremiumSource.source,
    );
    logInfo('ApphudCacheMixin IsPremium cached: $userPremiumSource');
  }

  Future<UserPremiumSource> getCachedIsPremium() async {
    logInfo('ApphudCacheMixin getCachedIsPremium');
    await _initCache();
    return userPremiumSource(
      _preferences?.getString(userPremiumSourceCache) ?? 'none',
    );
  }

  Future<void> cacheUserId(String userId) async {
    await _initCache();
    await _preferences!.setString(apphudUserIdCache, userId);
    logInfo('ApphudCacheMixin UserId cached: $userId');
  }

  Future<String> getCachedUserId() async {
    logInfo('ApphudCacheMixin getCachedUserId');
    await _initCache();
    return _preferences!.getString(apphudUserIdCache) ?? '';
  }

  Future<void> setDebugPremiumDate(DateTime date) async {
    await _initCache();
    await _preferences!.setInt(
      debugPremiumDateCache,
      date.millisecondsSinceEpoch,
    );
    logInfo('ApphudCacheMixin DebugPremiumDate cached: $date');
  }

  Future<DateTime?> getDebugPremiumDate() async {
    await _initCache();
    final date = _preferences!.getInt(debugPremiumDateCache);
    if (date == null) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(date);
  }
}
