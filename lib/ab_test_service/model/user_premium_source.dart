abstract class UserPremiumSource {
  final String source;
  const UserPremiumSource({required this.source});

  static UserPremiumSource get none => const UserPremiumSourceNone();
  static UserPremiumSource get debug => const UserPremiumSourceDebug();
  static UserPremiumSource get apphud => const UserPremiumSourceApphud();

  bool get isPremium;
}

class UserPremiumSourceNone extends UserPremiumSource {
  const UserPremiumSourceNone() : super(source: 'none');

  @override
  bool get isPremium => false;
}

class UserPremiumSourceDebug extends UserPremiumSource {
  const UserPremiumSourceDebug() : super(source: 'debug');

  @override
  bool get isPremium => true;
}

class UserPremiumSourceApphud extends UserPremiumSource {
  const UserPremiumSourceApphud() : super(source: 'apphud');

  @override
  bool get isPremium => true;
}
