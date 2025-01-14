class ProductItem {
  // Titel des Produkts, beispielsweise der Name
  final String productTitle;

  // Preis des Produkts als Double-Wert
  final double productPrice;

  // Menge des Produkts, standardmäßig 1
  int quantity;

  // Konstruktor, der die erforderlichen Werte initialisiert
  // und eine Standardmenge von 1 setzt, falls keine angegeben wird.
  ProductItem({
    required this.productTitle,
    required this.productPrice,
    this.quantity = 1, // Standardwert für die Menge
  });

  // Konvertiert das `ProductItem`-Objekt in eine Map,
  // um es z. B. in einer Datenbank oder als JSON zu speichern.
  Map<String, dynamic> toMap() {
    return {
      'productTitle': productTitle, // Titel wird in der Map gespeichert
      'productPrice': productPrice, // Preis wird in der Map gespeichert
      'quantity': quantity, // Menge wird in der Map gespeichert
    };
  }

  // Factory-Konstruktor, der ein `ProductItem`-Objekt aus einer Map erstellt.
  factory ProductItem.fromMap(Map<String, dynamic> map) {
    return ProductItem(
      productTitle: map['productTitle'], // Titel aus der Map lesen
      productPrice: map['productPrice'], // Preis aus der Map lesen
      quantity: map['quantity'] ?? 1, // Menge aus der Map lesen, standardmäßig 1
    );
  }

  // Überschreibt die Standard-`toString`-Methode,
  // um eine benutzerfreundliche Textdarstellung des Objekts zu erzeugen.
  @override
  String toString() {
    return 'ProductItem(title: $productTitle, price: $productPrice, quantity: $quantity,)';
  }

  // Erhöht die Menge des Produkts um 1.
  void increaseQuantity() {
    quantity++;
  }

  // Berechnet den Gesamtpreis basierend auf der Menge und dem Einzelpreis.
  double get totalPrice => productPrice * quantity;

  // Formatiert den Gesamtpreis als String mit zwei Dezimalstellen,
  // beispielsweise "12.34".
  String get formattedTotalPrice => totalPrice.toStringAsFixed(2);
}
