import 'base_remote_config.dart';

abstract class BaseProductType {
  String? productName(BaseRemoteConfig config);
  String? parentProductName(BaseRemoteConfig config);
}
