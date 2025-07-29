abstract class BaseRemoteConfig {
  const BaseRemoteConfig({
    this.paywall,
    this.onboarding,
    this.onboardingPaywall,
    this.promoOfferId,
  });
  final String? paywall;
  final String? onboardingPaywall;
  final String? onboarding;
  final String? promoOfferId;

  Map<String, dynamic> toJson();
}
