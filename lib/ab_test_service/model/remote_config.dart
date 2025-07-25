abstract class RemoteConfig {
  const RemoteConfig({
    this.childPaywall,
    this.paywall,
    this.onboarding,
    this.onboardingPaywall,
  });
  final RemoteConfig? childPaywall;
  final String? paywall;
  final String? onboardingPaywall;
  final String? onboarding;

  RemoteConfig copyWith({
    RemoteConfig? childPaywall,
    String? paywall,
    String? onboardingPaywall,
    String? onboarding,
  });

  Map<String, dynamic> toJson();
}
