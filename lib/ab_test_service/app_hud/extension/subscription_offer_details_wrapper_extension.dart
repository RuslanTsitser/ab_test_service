import 'package:apphud/models/product_details/subscription_offer_details.dart';
import 'package:collection/collection.dart';

import '../../model/subscription_period.dart';

extension SubscriptionOfferDetailsWrapperExtension
    on SubscriptionOfferDetailsWrapper {
  static const _microsAmount = 1000000;

  double? getDiscountPriceValue() {
    final phases = pricingPhases;
    if (phases.isEmpty) {
      return null;
    }
    final price = phases
        .reduce(
          (value, element) =>
              value.priceAmountMicros < element.priceAmountMicros
              ? value
              : element,
        )
        .priceAmountMicros;

    return (price / _microsAmount).toDouble();
  }

  double? getFullPriceValue() {
    final phases = pricingPhases;
    final price = phases
        .firstWhereOrNull((element) => element.billingCycleCount == 0)
        ?.priceAmountMicros;
    if (price == null) {
      return null;
    }
    return (price / _microsAmount).toDouble();
  }

  int? getDiscountPercent() {
    final phases = pricingPhases;

    if (phases.length > 1) {
      final price = phases
          .reduce(
            (value, element) =>
                value.priceAmountMicros > element.priceAmountMicros
                ? value
                : element,
          )
          .priceAmountMicros;
      final discountPrice = phases
          .reduce(
            (value, element) =>
                value.priceAmountMicros < element.priceAmountMicros
                ? value
                : element,
          )
          .priceAmountMicros;
      return ((price - discountPrice) / price * 100).toInt();
    }
    return null;
  }

  String? getDiscountPrice() {
    final phases = pricingPhases;
    if (phases.isEmpty) {
      return null;
    }
    final price = phases
        .reduce(
          (value, element) =>
              value.priceAmountMicros < element.priceAmountMicros
              ? value
              : element,
        )
        .formattedPrice;
    return price;
  }

  String? getFullPrice() {
    final phases = pricingPhases;
    final price = phases
        .firstWhereOrNull((element) => element.billingCycleCount == 0)
        ?.formattedPrice;
    return price;
  }

  bool getWithTrial() {
    final phases = pricingPhases;
    final withTrial = phases.any((element) => element.priceAmountMicros == 0);
    return withTrial;
  }

  SubscriptionPeriod? getSubscriptionPeriod() {
    final phases = pricingPhases;
    final subscriptionPeriod = phases
        .firstWhereOrNull((element) => element.billingCycleCount == 0)
        ?.billingPeriod;
    if (subscriptionPeriod == 'P1W') {
      return SubscriptionPeriod.week;
    } else if (subscriptionPeriod == 'P1Y') {
      return SubscriptionPeriod.year;
    }
    return null;
  }

  String priceCurrency() {
    final phases = pricingPhases;
    final price =
        phases
            .firstWhereOrNull((element) => element.billingCycleCount == 0)
            ?.priceCurrencyCode ??
        '';
    return price;
  }
}
