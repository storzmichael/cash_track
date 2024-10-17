import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

// Event ----------------------------------------------------
List<Map<String, dynamic>> convertProductItemsToMaps(List<ProductItem> products) {
  return products.map((product) => product.toMap()).toList();
}

Future<String> setNewEvent(
  String eventTitle,
  Map<String, List<dynamic>> categoryData,
  List<String> orderDeskNumbers,
  Map<String, List<dynamic>> orderDeskProducts,
  List<ProductItem> paidProducts,
  List<String> tables,
) async {
  final eventCollectionRef = _firestore.collection('events');

  final convertedCategoryData = categoryData.map((key, value) {
    List<ProductItem> productItems = value.cast<ProductItem>();
    return MapEntry(key, convertProductItemsToMaps(productItems));
  });

  final convertedOrderDeskProducts = orderDeskProducts.map((key, value) {
    List<ProductItem> productItems = value.cast<ProductItem>();
    return MapEntry(key, convertProductItemsToMaps(productItems));
  });

  final convertedPaidProducts = convertProductItemsToMaps(paidProducts);

  // Erstelle das Event und erhalte die ID
  DocumentReference eventDoc = await eventCollectionRef.add({
    'eventTitle': eventTitle,
    'categoryData': convertedCategoryData,
    'orderDeskNumber': orderDeskNumbers,
    'orderDeskProducts': convertedOrderDeskProducts,
    'paidProducts': convertedPaidProducts,
    'tables': tables,
  });

  // Die Event-ID speichern und als Event-Code verwenden
  String eventId = eventDoc.id;

  // Aktualisiere das Dokument, um die Event-ID als Event-Code zu speichern
  await eventDoc.update({
    'eventCode': eventId, // Event-ID als Event-Code speichern
  });

  // Event-ID zurückgeben
  return eventId;
}

// categoryData ----------------------------------------------------------------

Future<void> addProductsToCategory(
  String eventId,
  String categoryKey,
  List<ProductItem> newProducts,
) async {
  final eventDocRef = _firestore.collection('events').doc(eventId);

  // Konvertiere die neuen Produkte in Maps
  List<Map<String, dynamic>> productMaps = convertProductItemsToMaps(newProducts);

  // Füge die Produkte zur Kategorie in der Firestore-Datenbank hinzu
  await eventDocRef.update({
    'categoryData.$categoryKey': FieldValue.arrayUnion(productMaps),
  });
}
