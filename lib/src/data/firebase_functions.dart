import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

// Event ----------------------------------------------------
List<Map<String, dynamic>> convertProductItemsToMaps(List<ProductItem> products) {
  return products.map((product) => product.toMap()).toList();
}

Future<void> setNewEvent(
  String eventTitle,
  String eventCode,
  Map<String, List<dynamic>> categoryData,
  List<String> orderDeskNumbers,
  Map<String, List<dynamic>> orderDeskProducts,
  List<ProductItem> paidProducts,
  List<String> tables,
) async {
  final eventCollectionRef = _firestore.collection('events');

  final convertedCategoryData = categoryData.map((key, value) {
    // Sicherstellen, dass der Wert eine List<ProductItem> ist
    List<ProductItem> productItems = value.cast<ProductItem>();
    return MapEntry(key, convertProductItemsToMaps(productItems));
  });

  final convertedOrderDeskProducts = orderDeskProducts.map((key, value) {
    // Sicherstellen, dass der Wert eine List<ProductItem> ist
    List<ProductItem> productItems = value.cast<ProductItem>();
    return MapEntry(key, convertProductItemsToMaps(productItems));
  });

  final convertedPaidProducts = convertProductItemsToMaps(paidProducts);

  await eventCollectionRef.add({
    'code': eventCode,
    'eventTitle': eventTitle,
    'categoryData': convertedCategoryData,
    'orderDeskNumber': orderDeskNumbers,
    'orderDeskProducts': convertedOrderDeskProducts,
    'paidProducts': convertedPaidProducts,
    'tables': tables,
  });
}
