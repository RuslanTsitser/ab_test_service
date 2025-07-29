import 'subscription_period.dart';
import 'trial_period.dart';

class PaywallProduct {
  const PaywallProduct({
    required this.priceCurrency,
    required this.trialPeriod,
    this.subscriptionPeriod,
    this.fullPrice,
    this.fullPriceValue,
    this.discountedPrice,
    this.discountedPriceValue,
    this.parentProduct,
    this.discountPercent,
  });

  final String priceCurrency;
  final TrialPeriod trialPeriod;
  final SubscriptionPeriod? subscriptionPeriod;
  final String? fullPrice;
  final double? fullPriceValue;
  final String? discountedPrice;
  final double? discountedPriceValue;
  final int? discountPercent;
  final PaywallProduct? parentProduct;

  bool get withTrial => trialPeriod != TrialPeriod.noTrial;

  PaywallProduct copyWith({
    String? priceCurrency,
    TrialPeriod? trialPeriod,
    SubscriptionPeriod? subscriptionPeriod,
    String? fullPrice,
    double? fullPriceValue,
    String? discountedPrice,
    double? discountedPriceValue,
    int? discountPercent,
    PaywallProduct? parentProduct,
  }) =>
      PaywallProduct(
        priceCurrency: priceCurrency ?? this.priceCurrency,
        trialPeriod: trialPeriod ?? this.trialPeriod,
        subscriptionPeriod: subscriptionPeriod ?? this.subscriptionPeriod,
        fullPrice: fullPrice ?? this.fullPrice,
        fullPriceValue: fullPriceValue ?? this.fullPriceValue,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        discountedPriceValue: discountedPriceValue ?? this.discountedPriceValue,
        discountPercent: discountPercent ?? this.discountPercent,
        parentProduct: parentProduct ?? this.parentProduct,
      );
}
