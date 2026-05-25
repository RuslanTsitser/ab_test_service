class ProductEntity {
  const ProductEntity({
    required this.productId,
    this.currency,
    this.price,
    required this.isSubscription,
    required this.isWithTrial,
    this.hasNetworkIssue,
    this.errorMessage,
  });

  final String? productId;
  final String? currency;
  final double? price;
  final bool isSubscription;
  final bool isWithTrial;
  final bool? hasNetworkIssue;
  final String? errorMessage;

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'currency': currency,
      'price': price,
      'is_subscription': isSubscription,
      'is_with_trial': isWithTrial,
      'has_network_issue': hasNetworkIssue,
      'error_message': errorMessage,
    };
  }
}
