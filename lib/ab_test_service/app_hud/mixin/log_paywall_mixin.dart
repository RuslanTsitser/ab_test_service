import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/apphud_paywall.dart';

import '../../model/placement_type.dart';

mixin LogPaywallMixin {
  ApphudPaywall? getPaywallByType(PlacementType type);
  void logInfo(Object message);

  Future<void> logShowPaywall(PlacementType type) async {
    final paywall = getPaywallByType(type);
    if (paywall != null) {
      await Apphud.paywallShown(paywall);
    }
    logInfo('LogPaywallMixin.logShowPaywall $type');
  }

  Future<void> logClosePaywall(PlacementType type) async {
    final paywall = getPaywallByType(type);
    if (paywall != null) {
      await Apphud.paywallClosed(paywall);
    }
    logInfo('LogPaywallMixin.logClosePaywall $type');
  }
}
