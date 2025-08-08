import 'model/base_placement_type.dart';
import 'model/base_product_type.dart';
import 'model/base_remote_config.dart';
import 'model/paywall_product.dart';
import 'model/purchase_entity.dart';
import 'model/user_premium_source.dart';

/// {@template ab_test_service}
/// AbTestService interface.
/// {@endtemplate}
abstract class BaseAbTestService<R extends BaseRemoteConfig> {
  /// {@macro ab_test_service}
  const BaseAbTestService();

  /// Check if user is offline
  bool get isOffline;

  /// Get user id
  String? get userId;

  /// Set user is premium or not
  /// - [value] user premium source [S]
  Future<void> setPremium(UserPremiumSource value);

  /// Get user premium source
  UserPremiumSource get userPremiumSource;

  /// Get placement by type
  /// - [type] placement type [P]
  String appHudPlacement(BasePlacementType type);

  /// Get paywall by type
  /// - [type] placement type [P]
  String appHudPaywall(BasePlacementType type);

  /// Get remote config by type
  /// - [type] placement type [P]
  R remoteConfig(BasePlacementType type, {R? defaultValue});

  /// Set remote config by type
  /// - [value] remote config [R]
  /// - [type] placement type [BasePlacementType]
  /// - [log] default is true
  void setRemoteConfig(
    covariant BaseRemoteConfig value,
    BasePlacementType type, {
    bool log = true,
  });

  /// Init remote configs
  Future<void> initRemoteConfigs();

  /// Restore user is premium
  Future<void> restore();

  /// Purchase paywall
  /// - [type] placement type [BasePlacementType]
  /// - [productType] product type [BaseProductType]. Default is [BaseProductType.current]
  /// - [onPurchase] purchase callback [PurchaseCallback]
  /// - [config] remote config [R]
  Future<PurchaseEntity?> purchasePaywall(
    BasePlacementType type, {
    required BaseProductType productType,
    required R config,
  });

  /// Log show paywall
  /// - [type] placement type [BasePlacementType]
  Future<void> logShowPaywall(BasePlacementType type);

  /// Log close paywall
  /// - [type] placement type [BasePlacementType]
  Future<void> logClosePaywall(BasePlacementType type);

  /// Log purchase paywall
  /// - [type] placement type [BasePlacementType]
  /// - [productType] product type [BaseProductType]
  /// - [config] remote config [R]
  PaywallProduct paywallProduct(
    BasePlacementType type,
    BaseProductType productType, {
    required R config,
  });

  /// Set user property
  /// - [key] property key
  /// - [value] property value
  Future<void> setUserProperty(String key, String value);

  /// Ссылка на отмену подписки в web2wave
  String? get cancelSubscriptionLink;

  /// Установить ссылку на отмену подписки в web2wave
  void setCancelSubscriptionLink(String? value);

  /// Check if user is with trial
  bool get isWithTrial;

  /// Set is with trial
  void setIsWithTrial(bool value);
}
