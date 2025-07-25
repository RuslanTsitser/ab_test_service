import 'dart:async';

import 'package:apphud/apphud.dart';

mixin ApphudMixin {
  void logInfo(Object message);
  void logError(Object message, [Object? error, StackTrace? stackTrace]);

  Future<void> initApphud(String apiKey) async {
    try {
      await Apphud.start(
        apiKey: apiKey,
        observerMode: false,
      ).timeout(const Duration(seconds: 10));
    } on TimeoutException {
      logInfo('AbTestApHud._initApphud Timeout');
    }
  }

  Future<void> dispose() async {
    await Future.wait([Apphud.logout()]);
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
