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

  int quantity;

  ProductItem({
    required this.productTitle,
    required this.productPrice,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'productTitle': productTitle,
      'productPrice': productPrice,
      'quantity': quantity,
    };
  }

  factory ProductItem.fromMap(Map<String, dynamic> map) {
    return ProductItem(
      productTitle: map['productTitle'],
      productPrice: map['productPrice'],
      quantity: map['quantity'] ?? 1,
    );
  }

  @override
  String toString() {
    return 'ProductItem(title: $productTitle, price: $productPrice, quantity: $quantity,)';
  }

  void increaseQuantity() {
    quantity++;
  }

  double get totalPrice => productPrice * quantity;

  String get formattedTotalPrice => totalPrice.toStringAsFixed(2);
}
