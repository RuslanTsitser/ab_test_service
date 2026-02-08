import 'package:apphud/models/product_details/subscription_offer_details.dart';
import 'package:collection/collection.dart';

import '../../model/subscription_period.dart';
import '../../model/trial_period.dart';

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

  TrialPeriod getTrialPeriod() {
    final phases = pricingPhases;
    final withTrial = phases.any((element) => element.priceAmountMicros == 0);
    return withTrial ? TrialPeriod.threeDays : TrialPeriod.noTrial;
  }

  SubscriptionPeriod? getSubscriptionPeriod() {
    final phases = pricingPhases;
    final billingPeriod = phases
        .firstWhereOrNull((element) => element.billingCycleCount == 0)
        ?.billingPeriod;
    if (billingPeriod == null || billingPeriod.isEmpty) return null;
    switch (billingPeriod) {
      case 'P1W':
        return SubscriptionPeriod.week;
      case 'P1M':
        return SubscriptionPeriod.month;
      case 'P3M':
        return SubscriptionPeriod.threeMonths;
      case 'P1Y':
        return SubscriptionPeriod.year;
      default:
        return null;
    }
  }

  String priceCurrency() {
    final phases = pricingPhases;
    final price = phases
            .firstWhereOrNull((element) => element.billingCycleCount == 0)
            ?.priceCurrencyCode ??
        '';
    return price;
  }
}
