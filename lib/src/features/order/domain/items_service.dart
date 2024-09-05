import 'package:cash_track/src/features/order/domain/product_item.dart';

class ItemService {
  List<ProductItem> orderItems = [];

  void addItem(ProductItem item) {
    orderItems.add(item);
  }
}
