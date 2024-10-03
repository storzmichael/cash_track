import 'package:cash_track/src/features/order/domain/product_item.dart';

Map<String, List<ProductItem>> categoryData = {
  'Getränke': [
    ProductItem(productTitle: 'Cola', productPrice: 2.50, productCategory: 'Getränke'),
    ProductItem(productTitle: 'Fanta', productPrice: 2.50, productCategory: 'Getränke'),
    ProductItem(productTitle: 'Med. Wasser', productPrice: 2.50, productCategory: 'Getränke'),
    ProductItem(productTitle: 'Mineral Wasser', productPrice: 2.50, productCategory: 'Getränke'),
    ProductItem(productTitle: 'Bier', productPrice: 3.50, productCategory: 'Getränke'),
    ProductItem(productTitle: 'Radler Süß', productPrice: 3.50, productCategory: 'Getränke'),
    ProductItem(productTitle: 'Radler Sauer', productPrice: 3.50, productCategory: 'Getränke'),
    ProductItem(productTitle: 'Weizen', productPrice: 4.00, productCategory: 'Getränke'),
    ProductItem(productTitle: 'Weiswein', productPrice: 3.00, productCategory: 'Getränke'),
    ProductItem(productTitle: 'Weis Süß', productPrice: 3.00, productCategory: 'Getränke'),
    ProductItem(productTitle: 'Weis Sauer', productPrice: 3.00, productCategory: 'Getränke'),
    ProductItem(productTitle: 'Rotwein', productPrice: 3.50, productCategory: 'Getränke'),
  ],
  'Essen': [
    ProductItem(productTitle: 'Pommes', productPrice: 3.50, productCategory: 'Essen'),
    ProductItem(productTitle: 'Grillwurst', productPrice: 3.00, productCategory: 'Essen'),
    ProductItem(productTitle: 'Currywurst', productPrice: 3.50, productCategory: 'Essen'),
    ProductItem(productTitle: 'Wurstwecken', productPrice: 2.50, productCategory: 'Essen'),
    ProductItem(productTitle: 'Käsewecken', productPrice: 2.50, productCategory: 'Essen'),
  ]
};

Map<String, List<ProductItem>> orderData = {};

//test
void addProductToOrder(ProductItem productItem) {
  if (!orderData.containsKey(productItem.productCategory)) {
    orderData[productItem.productCategory] = [];
  }

  orderData[productItem.productCategory]!.add(productItem);
}
