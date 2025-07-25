import 'package:apphud/models/product_details/one_time_purchase_offer_details_wrapper.dart';

import '../../model/subscription_period.dart';

extension OneTimePurchaseOfferDetailsWrapperExtension
    on OneTimePurchaseOfferDetailsWrapper {
  static const _microsAmount = 1000000;

  double? getDiscountPriceValue() {
    return null;
  }

  double? getFullPriceValue() {
    final price = priceAmountMicros;
    return (price / _microsAmount).toDouble();
  }

  int? getDiscountPercent() {
    return null;
  }

  String? getDiscountPrice() {
    return null;
  }

  String? getFullPrice() {
    final price = formattedPrice;
    return price;
  }

  bool getWithTrial() {
    return false;
  }

  SubscriptionPeriod? getSubscriptionPeriod() {
    return null;
  }

  String priceCurrency() {
    return priceCurrencyCode;
  }
}
