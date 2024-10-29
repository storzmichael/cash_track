// import 'package:cash_track/src/config/config_colors.dart';
// import 'package:cash_track/src/core/presentation/dialog_helper.dart';
// import 'package:cash_track/src/data/lang/app_text.dart';
// import 'package:cash_track/src/features/events/application/product_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:cash_track/src/features/order/domain/product_item.dart';
// import 'package:cash_track/src/features/settings/application/language_provider.dart';

// class EventFunctions {
//   static void addProductToGrid({
//     required BuildContext context,
//     required String productName,
//     required double productPrice,
//     required TextEditingController nameController,
//     required TextEditingController priceController,
//   }) {
//     final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
//     final String language = languageProvider.language;

//     // Validierung der Eingaben
//     if (productName.isEmpty || productPrice <= 0) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(textFiles[language]![75]), // Ungültige Eingabe
//           duration: Duration(seconds: 2),
//         ),
//       );
//       return;
//     }

//     // Zugriff auf den ProductProvider
//     final productProvider = Provider.of<ProductProvider>(context, listen: false);
//     final List? products = productProvider.categories;

//     if (products != null && products.length >= 12) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(textFiles[language]![76]), // Maximale Anzahl erreicht
//           duration: Duration(seconds: 2),
//         ),
//       );
//       return;
//     }

//     // Produkt erstellen
//     ProductItem product = ProductItem(
//       productTitle: productName,
//       productPrice: productPrice,
//     );
//   }

//   static void clearAllControllers(
//     TextEditingController nameController,
//     TextEditingController priceController,
//   ) {
//     nameController.clear();
//     priceController.clear();
//   }

//   static void showProductOptionsDialog(
//     BuildContext context,
//     String category,
//     ProductItem product,
//     VoidCallback deleteCallback,
//     VoidCallback editCallback,
//   ) {
//     final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
//     final String language = languageProvider.language;

//     String message = '${textFiles[language]![74]} ${product.productTitle}';

//     DialogHelper.showConfirmationDialog(
//       context: context,
//       title: textFiles[language]![72],
//       message: message,
//       cancelButtonText: textFiles[language]![14],
//       confirmButtonText: textFiles[language]![18],
//       textColor: alertColor,
//       onConfirm: () {
//         deleteCallback();
//       },
//     );
//   }

//   static void updateProduct({
//     required BuildContext context,
//     required String category,
//     required ProductItem oldProduct,
//     required String newName,
//     required String newPriceText,
//     required TextEditingController nameController,
//     required TextEditingController priceController,
//     required TextEditingController categoryController,
//   }) {
//     final languageProvider = Provider.of<LanguageProvider>(context, listen: false);
//     final String language = languageProvider.language;

//     double? newPrice;
//     try {
//       newPrice = double.parse(newPriceText.replaceAll(',', '.'));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text(textFiles[language]![73]), // Ungültiger Preis
//           duration: Duration(seconds: 2),
//         ),
//       );
//       return;
//     }

//     final productProvider = Provider.of<ProductProvider>(context, listen: false);

//     final products = productProvider.categoryData[category];
//     if (products != null) {
//       final index = products.indexOf(oldProduct);
//       if (index != -1) {
//         products[index] = ProductItem(
//           productTitle: newName,
//           productPrice: newPrice!,
//           productCategory: category,
//         );
//       }
//     }

//     clearAllControllers(
//       nameController,
//       priceController,
//     );
//   }

//   static void deleteProduct({
//     required BuildContext context,
//     required String category,
//     required ProductItem product,
//   }) {
//     final productProvider = Provider.of<ProductProvider>(context, listen: false);
//     productProvider.removeProduct(category, product); // Methode zum Entfernen verwenden
//   }
// }
