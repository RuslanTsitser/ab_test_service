abstract class BaseRemoteConfig {
  const BaseRemoteConfig({
    this.paywall,
    this.onboarding,
    this.onboardingPaywall,
  });
  final String? paywall;
  final String? onboardingPaywall;
  final String? onboarding;

  Map<String, dynamic> toJson();
}
