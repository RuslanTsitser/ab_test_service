abstract class TrialPeriod {
  static TrialPeriod get noTrial => DefaultTrialPeriodEnum.noTrial;
  static TrialPeriod get threeDays => DefaultTrialPeriodEnum.threeDays;
  static TrialPeriod get oneWeek => DefaultTrialPeriodEnum.oneWeek;
}

enum DefaultTrialPeriodEnum implements TrialPeriod {
  noTrial,
  threeDays,
  oneWeek
}
