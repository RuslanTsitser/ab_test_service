import 'package:apphud/apphud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_premium_source.dart';

mixin UserPremiumMixin {
  Future<void> cacheIsPremium(UserPremiumSource userPremiumSource);
  Future<UserPremiumSource> getCachedIsPremium();
  Future<void> setDebugPremiumDate(DateTime date);
  Future<DateTime?> getDebugPremiumDate();
  bool get isOffline;

  void logInfo(Object message);
  void logError(Object message, [Object? error, StackTrace? stackTrace]);

  static const String isRestoredKey = 'isRestored';

  UserPremiumSource _userPremiumSource = UserPremiumSource.none;
  UserPremiumSource get userPremiumSource => _userPremiumSource;
  Future<void> setPremium(UserPremiumSource value) async {
    _userPremiumSource = value;
    await cacheIsPremium(value);
    if (value.debugPremiumDays != null) {
      await setDebugPremiumDate(DateTime.now());
    }
    logInfo('UserPremiumMixin setPremium: $value');
  }

  Future<void> checkUserPremium() async {
    if (isOffline) {
      final isPremium = await getCachedIsPremium();
      await setPremium(isPremium);
      return;
    }

    final cachedPremiumSource = await getCachedIsPremium();
    final debugPremiumDate = await getDebugPremiumDate();

    if (cachedPremiumSource.isDebugPremium) {
      if (cachedPremiumSource.debugPremiumDays != null &&
          debugPremiumDate != null) {
        final now = DateTime.now();
        final difference = now.difference(debugPremiumDate).inDays;
        if (difference > cachedPremiumSource.debugPremiumDays!) {
          await setPremium(UserPremiumSource.none);
        }
      }
      _userPremiumSource = cachedPremiumSource;
      return;
    }

    try {
      final pref = await SharedPreferences.getInstance();
      final isRestored = pref.getBool(isRestoredKey) ?? false;
      if (!isRestored) {
        await Apphud.restorePurchases();
        final isPremium = await Apphud.hasPremiumAccess();
        await setPremium(
          isPremium ? UserPremiumSource.apphud : UserPremiumSource.none,
        );
        await cacheIsPremium(
          isPremium ? UserPremiumSource.apphud : UserPremiumSource.none,
        );
        await pref
            .setBool(isRestoredKey, true)
            .whenComplete(() => logInfo({'setIsRestored': true}));
      } else {
        bool result = await Apphud.hasPremiumAccess();
        await cacheIsPremium(
          result ? UserPremiumSource.apphud : UserPremiumSource.none,
        );
        await setPremium(
          result ? UserPremiumSource.apphud : UserPremiumSource.none,
        );
      }
    } catch (error, stackTrace) {
      logError('Error in Apphud.hasPremiumAccess()', error, stackTrace);
    }
  }
}
