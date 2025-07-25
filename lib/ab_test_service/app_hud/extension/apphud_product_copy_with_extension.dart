import 'package:apphud/models/apphud_models/apphud_product.dart';
import 'package:apphud/models/sk_product/discount_payment_mode_wrapper.dart';

import '../../model/product_entity.dart';
import 'product_details_wrapper_extension.dart';

extension ApphudProductCopyWithExtension on ApphudProduct {
  bool get isSubscription {
    if (productDetails != null) {
      return productDetails!.productType == 'subs';
    } else if (skProduct != null) {
      return skProduct!.subscriptionPeriod != null;
    }
    return false;
  }

  bool get isWithTrial {
    if (isSubscription) {
      if (productDetails != null) {
        return productDetails?.getWithTrial() ?? false;
      } else if (skProduct != null) {
        return skProduct!.introductoryPrice?.paymentMode ==
            SKProductDiscountPaymentMode.freeTrail;
      }
    }
    return false;
  }

  ProductEntity getEntity() {
    final skProduct = this.skProduct;
    final androidProduct = productDetails;

    if (isSubscription) {
      if (skProduct != null) {
        return ProductEntity(
          productId: skProduct.productIdentifier,
          currency: skProduct.priceLocale.currencyCode,
          price: skProduct.price,
          isSubscription: true,
          isWithTrial: isWithTrial,
        );
      } else if (androidProduct != null) {
        final currency = androidProduct.priceCurrency();
        final double price = isWithTrial
            ? 0
            : androidProduct.getFullPriceValue() ?? 0;
        return ProductEntity(
          productId: androidProduct.productId,
          currency: currency,
          price: price,
          isSubscription: true,
          isWithTrial: isWithTrial,
        );
      } else {
        return ProductEntity(
          productId: productId,
          isSubscription: true,
          isWithTrial: isWithTrial,
        );
      }
    } else {
      if (skProduct != null) {
        return ProductEntity(
          productId: skProduct.productIdentifier,
          currency: skProduct.priceLocale.currencyCode,
          price: skProduct.price,
          isSubscription: false,
          isWithTrial: false,
        );
      } else if (androidProduct != null) {
        final currency = androidProduct.priceCurrency();
        final price = androidProduct.getFullPriceValue() ?? 0;
        return ProductEntity(
          productId: androidProduct.productId,
          currency: currency,
          price: price,
          isSubscription: false,
          isWithTrial: false,
        );
      } else {
        return ProductEntity(
          productId: productId,
          isSubscription: false,
          isWithTrial: false,
        );
      }
    }
  }
}
