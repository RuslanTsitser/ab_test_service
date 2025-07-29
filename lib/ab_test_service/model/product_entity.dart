class ProductEntity {
  const ProductEntity({
    required this.productId,
    this.currency,
    this.price,
    required this.isSubscription,
    required this.isWithTrial,
  });

  final String? productId;
  final String? currency;
  final double? price;
  final bool isSubscription;
  final bool isWithTrial;

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'currency': currency,
      'price': price,
      'is_subscription': isSubscription,
      'is_with_trial': isWithTrial,
    };
  }
}
