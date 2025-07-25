import 'package:apphud/models/apphud_models/apphud_paywall.dart';
import 'package:apphud/models/apphud_models/apphud_product.dart';

extension ApphudPaywallCopyWithExtension on ApphudPaywall {
  ApphudPaywall copyWith({
    String? identifier,
    String? experimentName,
    Map<String, dynamic>? json,
    List<ApphudProduct>? products,
    String? placementIdentifier,
    String? variationName,
    String? parentPaywallIdentifier,
  }) {
    return ApphudPaywall(
      identifier: identifier ?? this.identifier,
      experimentName: experimentName ?? this.experimentName,
      json: json ?? this.json,
      products: products ?? this.products,
      placementIdentifier: placementIdentifier ?? this.placementIdentifier,
      variationName: variationName ?? this.variationName,
      parentPaywallIdentifier:
          parentPaywallIdentifier ?? this.parentPaywallIdentifier,
    );
  }
}
