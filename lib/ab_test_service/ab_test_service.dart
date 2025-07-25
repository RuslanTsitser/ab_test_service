import 'model/paywall_product.dart';
import 'model/placement_type.dart';
import 'model/product_type.dart';
import 'model/purchase_entity.dart';
import 'model/remote_config.dart';
import 'model/user_premium_source.dart';

/// {@template ab_test_service}
/// AbTestService interface.
/// {@endtemplate}
abstract class AbTestService {
  /// {@macro ab_test_service}
  const AbTestService();

  /// Check if user is offline
  bool get isOffline;

  /// Get user id
  String? get userId;

  /// Set user is premium or not
  /// - [value] user premium source [UserPremiumSource]
  Future<void> setPremium(UserPremiumSource value);

  /// Get user premium source
  UserPremiumSource get userPremiumSource;

  /// Get placement by type
  /// - [type] placement type [PlacementType]
  String appHudPlacement(PlacementType type);

  /// Get paywall by type
  /// - [type] placement type [PlacementType]
  String appHudPaywall(PlacementType type);

  /// Get remote config by type
  /// - [type] placement type [PlacementType]
  RemoteConfig remoteConfig(PlacementType type);

  /// Set remote config by type
  /// - [value] remote config [RemoteConfig]
  /// - [type] placement type [PlacementType]
  /// - [log] default is true
  void setRemoteConfig(
    RemoteConfig value,
    PlacementType type, {
    bool log = true,
  });

  /// Init remote configs
  Future<void> initRemoteConfigs();

  /// Restore user is premium
  Future<void> restore();

  /// Purchase paywall
  /// - [type] placement type [PlacementType]
  /// - [productType] product type [ProductType]. Default is [ProductType.current]
  /// - [onPurchase] purchase callback [PurchaseCallback]
  /// - [config] remote config [RemoteConfig]
  Future<PurchaseEntity?> purchasePaywall(
    PlacementType type, {
    required ProductType productType,
    required RemoteConfig config,
  });

  /// Log show paywall
  /// - [type] placement type [PlacementType]
  Future<void> logShowPaywall(PlacementType type);

  /// Log close paywall
  /// - [type] placement type [PlacementType]
  Future<void> logClosePaywall(PlacementType type);

  /// Log purchase paywall
  /// - [type] placement type [PlacementType]
  /// - [productType] product type [ProductType]
  /// - [config] remote config [RemoteConfig]
  PaywallProduct paywallProduct(
    PlacementType type,
    ProductType productType, {
    required RemoteConfig config,
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
