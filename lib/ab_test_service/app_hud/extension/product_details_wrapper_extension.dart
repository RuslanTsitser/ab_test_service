import 'package:apphud/models/product_details/one_time_purchase_offer_details_wrapper.dart';
import 'package:apphud/models/product_details/product_details_wrapper.dart';
import 'package:apphud/models/product_details/subscription_offer_details.dart';

import '../../model/subscription_period.dart';
import 'one_time_purchase_offer_details_wrapper_extension.dart';
import 'subscription_offer_details_wrapper_extension.dart';

extension ProductDetailsWrapperExtension on ProductDetailsWrapper {
  String? getOfferToken() {
    if (_oneTimePurchaseOfferDetails != null) {
      return null;
    }
    return _subscriptionOfferDetails?.offerToken;
  }

  SubscriptionOfferDetailsWrapper? get _subscriptionOfferDetails =>
      _getSubscriptionOfferDetails(this);
  OneTimePurchaseOfferDetailsWrapper? get _oneTimePurchaseOfferDetails =>
      _getOneTimePurchaseOfferDetails(this);

  double? getDiscountPriceValue() {
    if (_oneTimePurchaseOfferDetails != null) {
      return _oneTimePurchaseOfferDetails?.getDiscountPriceValue();
    }
    return _subscriptionOfferDetails?.getDiscountPriceValue();
  }

  double? getFullPriceValue() {
    if (_oneTimePurchaseOfferDetails != null) {
      return _oneTimePurchaseOfferDetails?.getFullPriceValue();
    }
    return _subscriptionOfferDetails?.getFullPriceValue();
  }

  int? getDiscountPercent() {
    if (_oneTimePurchaseOfferDetails != null) {
      return _oneTimePurchaseOfferDetails?.getDiscountPercent();
    }
    return _subscriptionOfferDetails?.getDiscountPercent();
  }

  String? getDiscountPrice() {
    if (_oneTimePurchaseOfferDetails != null) {
      return _oneTimePurchaseOfferDetails?.getDiscountPrice();
    }
    return _subscriptionOfferDetails?.getDiscountPrice();
  }

  String? getFullPrice() {
    if (_oneTimePurchaseOfferDetails != null) {
      return _oneTimePurchaseOfferDetails?.getFullPrice();
    }
    return _subscriptionOfferDetails?.getFullPrice();
  }

  bool getWithTrial() {
    if (_oneTimePurchaseOfferDetails != null) {
      return _oneTimePurchaseOfferDetails?.getWithTrial() ?? false;
    }
    return _subscriptionOfferDetails?.getWithTrial() ?? false;
  }

  SubscriptionPeriod? getSubscriptionPeriod() {
    if (_oneTimePurchaseOfferDetails != null) {
      return _oneTimePurchaseOfferDetails?.getSubscriptionPeriod();
    }
    return _subscriptionOfferDetails?.getSubscriptionPeriod();
  }

  String priceCurrency() {
    if (_oneTimePurchaseOfferDetails != null) {
      return _oneTimePurchaseOfferDetails?.priceCurrency() ?? '';
    }
    return _subscriptionOfferDetails?.priceCurrency() ?? '';
  }

  OneTimePurchaseOfferDetailsWrapper? _getOneTimePurchaseOfferDetails(
    ProductDetailsWrapper? productDetails,
  ) {
    final details = productDetails?.oneTimePurchaseOfferDetails;
    return details;
  }

  SubscriptionOfferDetailsWrapper? _getSubscriptionOfferDetails(
    ProductDetailsWrapper? productDetails,
  ) {
    final details = productDetails?.subscriptionOfferDetails;
    return details?.firstOrNull;
  }
}
