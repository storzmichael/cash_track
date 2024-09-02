import 'package:cash_track/src/features/order/domain/product_item.dart';

class Table {
  final double number;
  List<ProductItem> orderProducts = [];

  Table({required this.number});

  void produktHinzufuegen(ProductItem produkt) {
    orderProducts.add(produkt);
  }

//   double getGesamtPreis() {
//     return orderProducts.fold(0, (sum, item) => sum + item.productPrice);
//   }
}
