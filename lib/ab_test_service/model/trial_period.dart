abstract class TrialPeriod {
  static TrialPeriod get threeDays => DefaultTrialPeriodEnum.threeDays;
  static TrialPeriod get oneWeek => DefaultTrialPeriodEnum.oneWeek;
}

enum DefaultTrialPeriodEnum implements TrialPeriod { threeDays, oneWeek }
