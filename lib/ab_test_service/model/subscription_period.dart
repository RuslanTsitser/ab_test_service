abstract class SubscriptionPeriod {
  static SubscriptionPeriod get week => DefaultSubscriptionPeriodEnum.week;
  static SubscriptionPeriod get month => DefaultSubscriptionPeriodEnum.month;
  static SubscriptionPeriod get year => DefaultSubscriptionPeriodEnum.year;

  bool get isYear;
  bool get isMonth;
  bool get isWeek;
  int get days;
}

enum DefaultSubscriptionPeriodEnum implements SubscriptionPeriod {
  week,
  month,
  year;

  @override
  bool get isYear => this == year;

  @override
  bool get isMonth => this == month;

  @override
  bool get isWeek => this == week;

  @override
  int get days => switch (this) {
        week => 7,
        month => 30,
        year => 365,
      };
}
