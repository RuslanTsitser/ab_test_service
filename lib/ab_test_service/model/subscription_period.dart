abstract class SubscriptionPeriod {
  static SubscriptionPeriod get week => DefaultSubscriptionPeriodEnum.week;
  static SubscriptionPeriod get month => DefaultSubscriptionPeriodEnum.month;
  static SubscriptionPeriod get year => DefaultSubscriptionPeriodEnum.year;
}

enum DefaultSubscriptionPeriodEnum implements SubscriptionPeriod {
  week,
  month,
  year,
}
