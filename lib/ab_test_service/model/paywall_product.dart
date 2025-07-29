import 'subscription_period.dart';
import 'trial_period.dart';

class PaywallProduct {
  const PaywallProduct({
    required this.priceCurrency,
    this.trialPeriod,
    this.subscriptionPeriod,
    this.fullPrice,
    this.fullPriceValue,
    this.discountedPrice,
    this.discountedPriceValue,
    this.parentProduct,
    this.discountPercent,
  });

  final String priceCurrency;
  final TrialPeriod? trialPeriod;
  final SubscriptionPeriod? subscriptionPeriod;
  final String? fullPrice;
  final double? fullPriceValue;
  final String? discountedPrice;
  final double? discountedPriceValue;
  final int? discountPercent;
  final PaywallProduct? parentProduct;

  bool get withTrial => trialPeriod != null;
}
