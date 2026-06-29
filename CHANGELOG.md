# Changelog

## 0.2.2

- feat: update UserPremiumMixin to determine premium status from active Apphud subscriptions instead of Apphud.hasPremiumAccess
- chore: bump package version to 0.2.2 in pubspec.yaml

## 0.2.1

- feat: add isConsumable parameter to PurchaseMixin.purchasePaywall for consumable in-app purchases via Apphud.purchase with consumableInappProduct
- chore: bump package version to 0.2.1 in pubspec.yaml

## 0.2.0

- chore: bump apphud dependency to ^3.2.4
- chore: bump package version to 0.2.0 in pubspec.yaml

## 0.1.0

- feat: add promoOfferId parameter to PurchaseMixin.purchasePaywall for iOS promo purchases
- feat: detect Android trial duration from billing period in SubscriptionOfferDetailsWrapperExtension.getTrialPeriod (P3D, P7D/P1W, P1M, P1Y)
- breaking: remove promoOfferId from BaseRemoteConfig; pass it directly to purchasePaywall instead
- chore: bump package version to 0.1.0 in pubspec.yaml

## 0.0.17

- fix: pass hasNetworkIssue from ApphudPurchaseResult.error.networkIssue when purchase fails in PurchaseMixin
- chore: bump package version to 0.0.17 in pubspec.yaml

## 0.0.16

- feat: add errorMessage to ProductEntity and expose it in toJson
- feat: return purchase error message from PurchaseMixin via ApphudPurchaseResult.error.message
- feat: add errorMessage parameter to ApphudProductCopyWithExtension.getEntity
- refactor: replace hasNetworkIssue-based purchase error detection with errorMessage in PurchaseMixin
- chore: bump package version to 0.0.16 in pubspec.yaml

## 0.0.15

- feat: add hasNetworkIssue to ProductEntity and expose it in toJson
- feat: detect purchase network errors in PurchaseMixin via ApphudPurchaseResult and pass hasNetworkIssue to getEntity
- feat: add hasNetworkIssue parameter to ApphudProductCopyWithExtension.getEntity
- chore: bump package version to 0.0.15 in pubspec.yaml

## 0.0.14

- feat: add isInitialized flag to ApphudMixin to track Apphud SDK initialization state
- chore: bump package version to 0.0.14 in pubspec.yaml

## 0.0.13

- feat: add setPlacements to RemoteConfigMixin for external placement updates
- feat: add setUserPremiumSource to UserPremiumMixin for syncing premium source without persisting to cache
- chore: bump package version to 0.0.13 in pubspec.yaml

## 0.0.12

- chore: bump package version to 0.0.12 in pubspec.yaml
- refactor: clean up logClosePaywall method in LogPaywallMixin
- refactor: update cached premium source handling logic in UserPremiumMixin

## 0.0.11

- feat: add debugPremiumDays property to UserPremiumSource and its implementations
- feat: add isDebugPremium property to UserPremiumSource and its implementations
- fix: adjust premium date calculation to use current date instead of a fixed future date in UserPremiumMixin
- refactor: enhance premium status handling in UserPremiumMixin to use debugPremiumDays and cachedPremiumSource
- chore: bump package version to 0.0.11 in pubspec.yaml

## 0.0.10

- feat: add product name to PaywallProduct model

## 0.0.9

- feat: add devtools_options.yaml for Dart & Flutter DevTools configuration
- feat: add support for three-month subscription period and update DevTools configuration

## 0.0.8

- feat: add monthly subscription period handling in ProductMixin

## 0.0.7

- refactor: streamline premium access check by replacing restorePurchases with hasPremiumAccess in UserPremiumMixin

## 0.0.6

- refactor: update remoteConfig method to accept an optional defaultValue parameter

## 0.0.5

- fix: initialize \_userPremiumSource to UserPremiumSource.none in UserPremiumMixin

## 0.0.4

- feat: add script to automate version tagging and pushing
- feat: add trial_period model export to ab_test_service

## 0.0.3

- feat: enhance trial period handling in ProductMixin and related models
- feat: introduce subscription period days property and update PaywallProduct to support trial period in copyWith
- refactor: trial period enum to include additional durations

## 0.0.2

- refactor: update ProductMixin and PaywallProduct to standardize trial period handling
- refactor: rename getWithTrial to getTrialPeriod and enforce required trialPeriod in PaywallProduct constructor

## 0.0.1

- Initial release: configuration, core service classes, mixins for user properties and subscriptions (AppHud, WebToWave), model definitions for paywalls and products
