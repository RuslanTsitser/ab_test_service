mixin CancelSubscriptionLinkMixin {
  void logInfo(Object message);

  String? _cancelSubscriptionLink;

  String? get cancelSubscriptionLink => _cancelSubscriptionLink;

  void setCancelSubscriptionLink(String? value) {
    logInfo('setCancelSubscriptionLink: $value');
    _cancelSubscriptionLink = value;
  }
}
