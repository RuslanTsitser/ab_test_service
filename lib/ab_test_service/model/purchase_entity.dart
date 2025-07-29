import 'product_entity.dart';
import 'purchase_type.dart';

class PurchaseEntity {
  const PurchaseEntity({required this.purchaseType, required this.product});

  final PurchaseType purchaseType;
  final ProductEntity product;

  Map<String, dynamic> toJson() {
    return {
      'purchase_type': purchaseType.name,
      'product': product.toJson(),
    };
  }
}
