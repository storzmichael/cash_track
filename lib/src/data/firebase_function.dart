import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

// Event ----------------------------------------------------
List<Map<String, dynamic>> convertProductItemsToMaps(List<ProductItem> products) {
  return products.map((product) => product.toMap()).toList();
}

String globaleventTitle = '';
late Map<String, List<dynamic>> globalcategoryData;
List<String> globalorderDeskNumbers = ["sdagasg", "asgag"];
late Map<String, List<dynamic>> globalorderDeskProducts;
List<ProductItem> globalpaidProducts = [];
List<String> globaltables = [];

Future<String> addProductToMap(ProductItem product) async {
//   DocumentReference docRef = await _firestore.collection('events/$globalID').add({
  final eventCollectionRef = _firestore.collection('events');
  // Produktkategorie aus Firebase Dokument holen

  // Pfad mit Kategorie erstellen

  // Produktitem in richtigen Pfad einfügen
  globalcategoryData['Getränke']!.add(product);
  final convertedCategoryData = globalcategoryData.map((key, value) {
    List<ProductItem> productItems = value.cast<ProductItem>();
    return MapEntry(key, convertProductItemsToMaps(productItems));
  });

  final convertedOrderDeskProducts = globalorderDeskProducts.map((key, value) {
    List<ProductItem> productItems = value.cast<ProductItem>();
    return MapEntry(key, convertProductItemsToMaps(productItems));
  });

  final convertedPaidProducts = convertProductItemsToMaps(globalpaidProducts);

  // Dokument hinzufügen und die Referenz erhalten

  // _firestore.collection('events/$globalID')

  DocumentReference docRef = await eventCollectionRef.add({
    'eventTitle': globaleventTitle,
    'categoryData': convertedCategoryData,
    'orderDeskNumber': globalorderDeskNumbers,
    'orderDeskProducts': convertedOrderDeskProducts,
    'paidProducts': convertedPaidProducts,
    'tables': globaltables,
  });

  // Dokumenten-ID abrufen und als eventCode speichern
  String eventCode = docRef.id;

  // eventCode im Dokument speichern
  await docRef.update({'eventCode': eventCode});

  return eventCode; // Rückgabe der eventCodetextfield
}

Future<String> setNewEvent(
  String eventTitle,
  Map<String, List<dynamic>> categoryData,
  List<String> orderDeskNumbers,
  Map<String, List<dynamic>> orderDeskProducts,
  List<ProductItem> paidProducts,
  List<String> tables,
) async {
  globaleventTitle = eventTitle;
  globalcategoryData = categoryData;
  globalorderDeskNumbers = orderDeskNumbers;
  globalorderDeskProducts = orderDeskProducts;
  globalpaidProducts = paidProducts;
  globaltables = tables;

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

  // Dokument hinzufügen und die Referenz erhalten
  DocumentReference docRef = await eventCollectionRef.add({
    'eventTitle': eventTitle,
    'categoryData': convertedCategoryData,
    'orderDeskNumber': orderDeskNumbers,
    'orderDeskProducts': convertedOrderDeskProducts,
    'paidProducts': convertedPaidProducts,
    'tables': tables,
  });

  // Dokumenten-ID abrufen und als eventCode speichern
  String eventCode = docRef.id;

  // eventCode im Dokument speichern
  await docRef.update({'eventCode': eventCode});

  return eventCode; // Rückgabe der eventCodetextfield
}
