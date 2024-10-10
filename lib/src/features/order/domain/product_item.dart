class ProductItem {
  final String productTitle;
  final double productPrice;
  final String productCategory;
  int quantity;
  double availability;

  ProductItem({
    required this.productTitle,
    required this.productPrice,
    required this.productCategory,
    this.quantity = 1,
    this.availability = double.infinity,
  });

  @override
  String toString() {
    return 'ProductItem(title: $productTitle, price: $productPrice, category: $productCategory, quantity: $quantity, availability: $availability)';
  }
}
