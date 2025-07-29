abstract class TrialPeriod {
  static TrialPeriod get noTrial => DefaultTrialPeriodEnum.noTrial;
  static TrialPeriod get threeDays => DefaultTrialPeriodEnum.threeDays;
  static TrialPeriod get oneWeek => DefaultTrialPeriodEnum.oneWeek;
  static TrialPeriod get oneMonth => DefaultTrialPeriodEnum.oneMonth;
  static TrialPeriod get oneYear => DefaultTrialPeriodEnum.oneYear;

  int get days;
}

enum DefaultTrialPeriodEnum implements TrialPeriod {
  noTrial,
  threeDays,
  oneWeek,
  oneMonth,
  oneYear;

  @override
  int get days => switch (this) {
        threeDays => 3,
        oneWeek => 7,
        oneMonth => 30,
        oneYear => 365,
        _ => 0,
      };
}
