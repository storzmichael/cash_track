import 'package:cash_track/src/features/order/domain/product_item.dart';

class ItemService {
  List<ProductItem> orderItems = [];

  // Fügt ein neues Item hinzu und speichert die aktualisierte Liste.
  void addItem(ProductItem item) {
    orderItems.add(item);
  }
}
