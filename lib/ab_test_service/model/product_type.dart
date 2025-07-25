import 'remote_config.dart';

abstract class ProductType {
  String? productName(RemoteConfig config);
  String? parentProductName(RemoteConfig config);
}
