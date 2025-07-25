abstract class UserPremiumSource {
  String get source;

  static UserPremiumSource get none => DefaultUserPremiumSourceEnum.none;
  static UserPremiumSource get debug => DefaultUserPremiumSourceEnum.debug;
  static UserPremiumSource get apphud => DefaultUserPremiumSourceEnum.apphud;
}

enum DefaultUserPremiumSourceEnum implements UserPremiumSource {
  none,
  apphud,
  debug;

  @override
  String get source => switch (this) {
    DefaultUserPremiumSourceEnum.none => 'none',
    DefaultUserPremiumSourceEnum.apphud => 'apphud',
    DefaultUserPremiumSourceEnum.debug => 'debug',
  };
}
