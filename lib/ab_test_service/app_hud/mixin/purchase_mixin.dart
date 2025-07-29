import 'dart:io';

import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/apphud_product.dart';

import '../../model/base_placement_type.dart';
import '../../model/base_product_type.dart';
import '../../model/base_remote_config.dart';
import '../../model/product_entity.dart';
import '../../model/purchase_entity.dart';
import '../../model/purchase_type.dart';
import '../../model/user_premium_source.dart';
import '../extension/apphud_product_copy_with_extension.dart';
import '../extension/product_details_wrapper_extension.dart';

mixin PurchaseMixin {
  Future<void> checkUserPremium();
  UserPremiumSource get userPremiumSource;
  ApphudProduct? getProductByType(
    BasePlacementType type,
    BaseProductType purchaseType, {
    required BaseRemoteConfig config,
    required bool isParent,
  });
  void logInfo(Object message);

  Future<PurchaseEntity?> purchasePaywall(
    BasePlacementType type, {
    required BaseProductType productType,
    required BaseRemoteConfig config,
  }) async {
    final productEntity =
        await _purchase(type, productType: productType, config: config);
    await checkUserPremium();

    if (productEntity != null) {
      if (userPremiumSource.isPremium) {
        return PurchaseEntity(
            purchaseType: PurchaseType.purchase, product: productEntity);
      }
      return PurchaseEntity(
          purchaseType: PurchaseType.none, product: productEntity);
    }
    return null;
  }

  Future<ProductEntity?> _purchase(
    BasePlacementType type, {
    required BaseProductType productType,
    required BaseRemoteConfig config,
  }) async {
    final subscriptions = await Apphud.subscriptions();

    final product = getProductByType(
      type,
      productType,
      config: config,
      isParent: false,
    );

    if (subscriptions.isEmpty ||
        Platform.isAndroid ||
        config.promoOfferId == null) {
      await Apphud.purchase(
        product: product,
        offerIdToken: product?.productDetails?.getOfferToken(),
      );
    } else if (product != null) {
      await Apphud.purchasePromo(
        productId: product.productId,
        discountID: config.promoOfferId!,
      );
    }
    final entity = product?.getEntity();
    logInfo('PurchaseMixin._purchase $type $entity');
    return entity;
  }
}
