# Changelog

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
