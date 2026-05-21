import 'dart:async';

import 'package:apphud/apphud.dart';

mixin ApphudMixin {
  void logInfo(Object message);
  void logError(Object message, [Object? error, StackTrace? stackTrace]);

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> initApphud(String apiKey) async {
    try {
      await Apphud.start(
        apiKey: apiKey,
        observerMode: false,
      ).timeout(const Duration(seconds: 10));
      _isInitialized = true;
    } on TimeoutException {
      logInfo('AbTestApHud._initApphud Timeout');
    }
  }

  Future<void> disposeApphud() async {
    await Future.wait([Apphud.logout()]);
    _isInitialized = false;
  }

  Future<void> restore() async {
    try {
      final result = await Apphud.restorePurchases();
      logInfo({
        'AbTestApHud': 'restore',
        'error': result.error?.toJson(),
        'subscriptions': result.subscriptions,
        'purchases': result.purchases,
      });
    } catch (e, s) {
      logError('Error in Apphud.restorePurchases()', e, s);
    }
  }
}
