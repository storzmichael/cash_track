// class ProductItem {
//   final String productTitle;
//   final double productPrice;
//   final String productCategory;
//   int quantity;
//   double availability;

//   ProductItem({
//     required this.productTitle,
//     required this.productPrice,
//     required this.productCategory,
//     this.quantity = 1,
//     this.availability = double.infinity,
//   });

//   @override
//   String toString() {
//     return 'ProductItem(title: $productTitle, price: $productPrice, category: $productCategory, quantity: $quantity, availability: $availability)';
//   }
// }

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

  Map<String, dynamic> toMap() {
    return {
      'productTitle': productTitle,
      'productPrice': productPrice,
      'productCategory': productCategory,
      'quantity': quantity,
      'availability': availability,
    };
  }

  factory ProductItem.fromMap(Map<String, dynamic> map) {
    return ProductItem(
      productTitle: map['productTitle'],
      productPrice: map['productPrice'],
      productCategory: map['productCategory'],
      quantity: map['quantity'] ?? 1,
      availability: map['availability'] ?? double.infinity,
    );
  }

  @override
  String toString() {
    return 'ProductItem(title: $productTitle, price: $productPrice, category: $productCategory, quantity: $quantity, availability: $availability)';
  }
}
