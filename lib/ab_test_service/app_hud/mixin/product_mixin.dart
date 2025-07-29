import 'package:apphud/models/apphud_models/apphud_paywall.dart';
import 'package:apphud/models/apphud_models/apphud_product.dart';
import 'package:apphud/models/product_details/product_details_wrapper.dart';
import 'package:apphud/models/sk_product/discount_payment_mode_wrapper.dart';
import 'package:apphud/models/sk_product/sk_product_wrapper.dart';
import 'package:apphud/models/sk_product/subscription_period_time_wrapper.dart';
import 'package:collection/collection.dart';

import '../../../ab_test_service.dart';
import '../../model/trial_period.dart';

enum ProductLevel {
  current,
  child,
}

mixin ProductMixin {
  ApphudPaywall? get generalPaywall;
  ApphudPaywall? getPaywallByType(BasePlacementType type);
  BaseRemoteConfig remoteConfig(BasePlacementType type);
  ApphudProduct? get generalProduct;

  PaywallProduct paywallProduct(
    BasePlacementType type,
    BaseProductType productType, {
    required BaseRemoteConfig config,
  }) {
    final priceCurrency =
        this.priceCurrency(type, productType, isParent: false, config: config);
    final withTrial =
        getWithTrial(type, productType, isParent: false, config: config);
    final subscriptionPeriod = getSubscriptionPeriod(type, productType,
        isParent: false, config: config);
    final fullPrice =
        getFullPrice(type, productType, isParent: false, config: config);
    final fullPriceValue =
        getFullPriceValue(type, productType, isParent: false, config: config);
    final discountedPrice =
        getDiscountPrice(type, productType, isParent: false, config: config);
    final discountPriceValue = getDiscountPriceValue(type, productType,
        isParent: false, config: config);
    final discountPercent =
        getDiscountPercent(type, productType, isParent: false, config: config);

    PaywallProduct? parentProduct;

    var parentFullPrice =
        getFullPrice(type, productType, isParent: true, config: config);
    if (parentFullPrice != null) {
      parentProduct = PaywallProduct(
        priceCurrency: this
            .priceCurrency(type, productType, isParent: true, config: config),
        trialPeriod:
            getWithTrial(type, productType, isParent: true, config: config),
        subscriptionPeriod: getSubscriptionPeriod(type, productType,
            isParent: true, config: config),
        fullPrice: parentFullPrice,
        fullPriceValue: getFullPriceValue(type, productType,
            isParent: true, config: config),
        discountedPrice:
            getDiscountPrice(type, productType, isParent: true, config: config),
        discountedPriceValue: getDiscountPriceValue(type, productType,
            isParent: true, config: config),
        discountPercent: getDiscountPercent(type, productType,
            isParent: true, config: config),
      );
    }

    return PaywallProduct(
      priceCurrency: priceCurrency,
      trialPeriod: withTrial,
      subscriptionPeriod: subscriptionPeriod,
      fullPrice: fullPrice,
      fullPriceValue: fullPriceValue,
      discountedPrice: discountedPrice,
      discountedPriceValue: discountPriceValue,
      discountPercent: discountPercent,
      parentProduct: parentProduct,
    );
  }

  String priceCurrency(
    BasePlacementType type,
    BaseProductType purchaseType, {
    required bool isParent,
    required BaseRemoteConfig config,
  }) {
    final androidProductDetails = _androidProductDetails(
      type,
      purchaseType,
      isParent: isParent,
      config: config,
    );
    if (androidProductDetails != null) {
      return androidProductDetails.priceCurrency();
    }

    final iosSkProduct = _iosSkProduct(
      type,
      purchaseType,
      isParent: isParent,
      config: config,
    );
    if (iosSkProduct != null) {
      return iosSkProduct.priceLocale.currencySymbol ?? '';
    }
    return '';
  }

  ApphudProduct? getProductByType(
    BasePlacementType type,
    BaseProductType purchaseType, {
    required BaseRemoteConfig config,
    required bool isParent,
  }) {
    ApphudPaywall? paywall = getPaywallByType(type);

    final productName = isParent
        ? purchaseType.parentProductName(config)
        : purchaseType.productName(config);

    final products = paywall?.products;
    final result =
        products?.firstWhereOrNull((element) => element.name == productName);
    return result;
  }

  SKProductWrapper? _iosSkProduct(
    BasePlacementType type,
    BaseProductType purchaseType, {
    required bool isParent,
    required BaseRemoteConfig config,
  }) =>
      getProductByType(
        type,
        purchaseType,
        isParent: isParent,
        config: config,
      )?.skProduct;

  ProductDetailsWrapper? _androidProductDetails(
    BasePlacementType type,
    BaseProductType purchaseType, {
    required bool isParent,
    required BaseRemoteConfig config,
  }) =>
      getProductByType(
        type,
        purchaseType,
        isParent: isParent,
        config: config,
      )?.productDetails;

  SubscriptionPeriod? getSubscriptionPeriod(
    BasePlacementType type,
    BaseProductType purchaseType, {
    required bool isParent,
    required BaseRemoteConfig config,
  }) {
    final androidProductDetails = _androidProductDetails(
      type,
      purchaseType,
      isParent: isParent,
      config: config,
    );

    if (androidProductDetails != null) {
      return androidProductDetails.getSubscriptionPeriod();
    }

    final iosSkProduct = _iosSkProduct(
      type,
      purchaseType,
      isParent: isParent,
      config: config,
    );

    if (iosSkProduct != null) {
      final subscriptionPeriod = iosSkProduct.subscriptionPeriod;
      if (subscriptionPeriod == null) return null;
      if (subscriptionPeriod.unit == SKSubscriptionPeriodTime.day &&
          subscriptionPeriod.numberOfUnits == 7) {
        return SubscriptionPeriod.week;
      } else {
        return SubscriptionPeriod.year;
      }
    }
    return null;
  }

  TrialPeriod? getWithTrial(
    BasePlacementType type,
    BaseProductType purchaseType, {
    required bool isParent,
    required BaseRemoteConfig config,
  }) {
    final androidProductDetails = _androidProductDetails(
      type,
      purchaseType,
      isParent: isParent,
      config: config,
    );
    if (androidProductDetails != null) {
      return androidProductDetails.getTrialPeriod();
    }

    final iosSkProduct = _iosSkProduct(
      type,
      purchaseType,
      isParent: isParent,
      config: config,
    );
    if (iosSkProduct != null) {
      return iosSkProduct.introductoryPrice?.paymentMode ==
              SKProductDiscountPaymentMode.freeTrail
          ? TrialPeriod.threeDays
          : TrialPeriod.noTrial;
    }

    return TrialPeriod.noTrial;
  }

  String? getFullPrice(
    BasePlacementType type,
    BaseProductType purchaseType, {
    required bool isParent,
    required BaseRemoteConfig config,
  }) {
    final androidProductDetails = _androidProductDetails(
      type,
      purchaseType,
      isParent: isParent,
      config: config,
    );
    if (androidProductDetails != null) {
      return androidProductDetails.getFullPrice();
    }

    final iosSkProduct = _iosSkProduct(
      type,
      purchaseType,
      isParent: isParent,
      config: config,
    );
    if (iosSkProduct != null) {
      var price = iosSkProduct.price;
      if (price % 1 == 0) {
        return '${iosSkProduct.priceLocale.currencySymbol}${price.toInt()}';
      }
      return '${iosSkProduct.priceLocale.currencySymbol}${iosSkProduct.price.toStringAsFixed(2)}';
    }
    return null;
  }

  double? getFullPriceValue(
    BasePlacementType type,
    BaseProductType purchaseType, {
    required bool isParent,
    required BaseRemoteConfig config,
  }) {
    final androidProductDetails = _androidProductDetails(
      type,
      purchaseType,
      isParent: isParent,
      config: config,
    );
    if (androidProductDetails != null) {
      return androidProductDetails.getFullPriceValue();
    }

    final iosSkProduct = _iosSkProduct(
      type,
      purchaseType,
      isParent: isParent,
      config: config,
    );
    if (iosSkProduct != null) {
      final price = iosSkProduct.price;
      return price;
    }
    return null;
  }

  String? getDiscountPrice(
    BasePlacementType type,
    BaseProductType purchaseType, {
    required bool isParent,
    required BaseRemoteConfig config,
  }) {
    final androidProductDetails = _androidProductDetails(
      type,
      purchaseType,
      isParent: isParent,
      config: config,
    );
    if (androidProductDetails != null) {
      return androidProductDetails.getDiscountPrice();
    }

    final iosSkProduct = _iosSkProduct(
      type,
      purchaseType,
      isParent: isParent,
      config: config,
    );
    if (iosSkProduct != null) {
      final price = iosSkProduct.introductoryPrice?.price;
      if (price == null) {
        return null;
      }
      if (price % 1 == 0) {
        return '${iosSkProduct.priceLocale.currencySymbol}${price.toInt()}';
      }
      return '${iosSkProduct.priceLocale.currencySymbol}${price.toStringAsFixed(2)}';
    }
    return null;
  }

  double? getDiscountPriceValue(
    BasePlacementType type,
    BaseProductType purchaseType, {
    required bool isParent,
    required BaseRemoteConfig config,
  }) {
    final androidProductDetails = _androidProductDetails(
      type,
      purchaseType,
      isParent: isParent,
      config: config,
    );
    if (androidProductDetails != null) {
      return androidProductDetails.getDiscountPriceValue();
    }

    final iosSkProduct = _iosSkProduct(
      type,
      purchaseType,
      isParent: isParent,
      config: config,
    );
    if (iosSkProduct != null) {
      final price = iosSkProduct.introductoryPrice?.price;
      return price;
    }
    return null;
  }

  int? getDiscountPercent(
    BasePlacementType type,
    BaseProductType purchaseType, {
    required bool isParent,
    required BaseRemoteConfig config,
  }) {
    int? discountPercent;
    final androidProductDetails = _androidProductDetails(
      type,
      purchaseType,
      isParent: isParent,
      config: config,
    );
    if (androidProductDetails != null) {
      return androidProductDetails.getDiscountPercent();
    }

    final iosSkProduct = _iosSkProduct(
      type,
      purchaseType,
      isParent: isParent,
      config: config,
    );
    if (iosSkProduct != null) {
      final price = iosSkProduct.price;
      final discountPrice = iosSkProduct.introductoryPrice?.price;
      if (discountPrice != null) {
        discountPercent = ((price - discountPrice) / price * 100).toInt();
      }
    }
    if (discountPercent != null) {
      discountPercent = (discountPercent / 5).round() * 5;
    }
    return discountPercent;
  }
}
