abstract class SubscriptionPeriod {
  static SubscriptionPeriod get week => DefaultSubscriptionPeriodEnum.week;
  static SubscriptionPeriod get month => DefaultSubscriptionPeriodEnum.month;
  static SubscriptionPeriod get threeMonths =>
      DefaultSubscriptionPeriodEnum.threeMonths;
  static SubscriptionPeriod get year => DefaultSubscriptionPeriodEnum.year;

  bool get isYear;
  bool get isMonth;
  bool get isThreeMonths;
  bool get isWeek;
  int get days;
}

enum DefaultSubscriptionPeriodEnum implements SubscriptionPeriod {
  week,
  month,
  threeMonths,
  year;

  @override
  bool get isYear => this == year;

  @override
  bool get isMonth => this == month;

  @override
  bool get isThreeMonths => this == threeMonths;

  @override
  bool get isWeek => this == week;

  @override
  int get days => switch (this) {
        week => 7,
        month => 30,
        threeMonths => 90,
        year => 365,
      };
}
