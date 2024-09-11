import 'package:cash_track/src/features/order/domain/product_item.dart';

// Class representing a table with a number and a list of ordered products
class Table {
  final double number; // The table number
  List<ProductItem> orderProducts = []; // List to store products added to the order

  // Constructor requires the table number to be passed
  Table({required this.number});

  // Method to add a product to the list of ordered products
  void productAddToOrderProducts(ProductItem produkt) {
    orderProducts.add(produkt); // Adds the product to the table's order list
  }
  //TODO:
  // Uncomment to calculate the total price of all products in the order
  // double getGesamtPreis() {
  //   return orderProducts.fold(0, (sum, item) => sum + item.productPrice);
  // }
}
