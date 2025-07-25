import 'package:apphud/apphud.dart';
import 'package:apphud/models/apphud_models/apphud_user_property_key.dart';

mixin ApphudUserPropertyMixin {
  void logInfo(Object message);

  Future<void> setUserProperty(String key, String value) async {
    await Apphud.setUserProperty(
      key: ApphudUserPropertyKey.customProperty(key),
      value: value,
    );
    logInfo({
      'setUserProperty': {key: value},
    });
  }
}
