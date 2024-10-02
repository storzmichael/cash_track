class ProductItem {
  final String productTitle;
  final double productPrice;
  final String productCategory;
  double availability;
  int quantity;

  ProductItem({
    required this.productTitle,
    this.productPrice = 0,
    required this.productCategory,
    this.availability = double.infinity,
    this.quantity = 1,
  });

  get keys => null;
}
