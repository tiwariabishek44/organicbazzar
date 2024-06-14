class Product {
  final String name;
  final String id;
  final String imageUrl;
  final double price;
  final String unit;

  Product({
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.price,
    required this.unit,
  });

  // Optionally, you can add a method to convert the Product object to a Map
  // This can be useful for storing the product in a database or sending it over the network
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'imageUrl': imageUrl,
      'price': price,
      'unit': unit,
    };
  }

  // Optionally, you can add a method to create a Product object from a Map
  // This can be useful for retrieving the product from a database or from network data
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'],
      id: map['id'],
      imageUrl: map['imageUrl'],
      price: map['price'],
      unit: map['unit'],
    );
  }

  toJson() {}
}

final List<Product> products = [
  Product(
    name: 'Fresh Local Vine Tomatoes (5kg)',
    id: '1',
    imageUrl:
        'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS71yrunowsGOtqw2tISwOGDbHZBtPjUEyBHqN0inYXpFw0qH43rt_ALP-G67UdxOI5X9nJZkJcqI6RnK1WX2SiwrM_PEgICYOXgPVpOw',
    price: 12.80,
    unit: '1kg',
  ),
  Product(
    name: 'Organic Bananas (1kg)',
    id: '2',
    imageUrl:
        'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS71yrunowsGOtqw2tISwOGDbHZBtPjUEyBHqN0inYXpFw0qH43rt_ALP-G67UdxOI5X9nJZkJcqI6RnK1WX2SiwrM_PEgICYOXgPVpOw',
    price: 2.99,
    unit: '1kg',
  ),
  Product(
    name: 'Red Apples (1kg)',
    id: '3',
    imageUrl:
        'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS71yrunowsGOtqw2tISwOGDbHZBtPjUEyBHqN0inYXpFw0qH43rt_ALP-G67UdxOI5X9nJZkJcqI6RnK1WX2SiwrM_PEgICYOXgPVpOw',
    price: 3.50,
    unit: '1kg',
  ),
];

final List<Product> products1 = [
  Product(
    name: 'Fresh Local Vine Tomatoes (5kg)',
    id: '1',
    imageUrl:
        'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS71yrunowsGOtqw2tISwOGDbHZBtPjUEyBHqN0inYXpFw0qH43rt_ALP-G67UdxOI5X9nJZkJcqI6RnK1WX2SiwrM_PEgICYOXgPVpOw',
    price: 12.80,
    unit: '1kg',
  ),
  Product(
    name: 'Organic Bananas (1kg)',
    id: '2',
    imageUrl:
        'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS71yrunowsGOtqw2tISwOGDbHZBtPjUEyBHqN0inYXpFw0qH43rt_ALP-G67UdxOI5X9nJZkJcqI6RnK1WX2SiwrM_PEgICYOXgPVpOw',
    price: 2.99,
    unit: '1kg',
  ),
  Product(
    name: 'Red Apples (1kg)',
    id: '3',
    imageUrl:
        'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS71yrunowsGOtqw2tISwOGDbHZBtPjUEyBHqN0inYXpFw0qH43rt_ALP-G67UdxOI5X9nJZkJcqI6RnK1WX2SiwrM_PEgICYOXgPVpOw',
    price: 3.50,
    unit: '1kg',
  ),
  Product(
    name: 'Fresh Local Vine Tomatoes (5kg)',
    id: '1',
    imageUrl:
        'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS71yrunowsGOtqw2tISwOGDbHZBtPjUEyBHqN0inYXpFw0qH43rt_ALP-G67UdxOI5X9nJZkJcqI6RnK1WX2SiwrM_PEgICYOXgPVpOw',
    price: 12.80,
    unit: '1kg',
  ),
  Product(
    name: 'Organic Bananas (1kg)',
    id: '2',
    imageUrl:
        'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS71yrunowsGOtqw2tISwOGDbHZBtPjUEyBHqN0inYXpFw0qH43rt_ALP-G67UdxOI5X9nJZkJcqI6RnK1WX2SiwrM_PEgICYOXgPVpOw',
    price: 2.99,
    unit: '1kg',
  ),
  Product(
    name: 'Red Apples (1kg)',
    id: '3',
    imageUrl:
        'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS71yrunowsGOtqw2tISwOGDbHZBtPjUEyBHqN0inYXpFw0qH43rt_ALP-G67UdxOI5X9nJZkJcqI6RnK1WX2SiwrM_PEgICYOXgPVpOw',
    price: 3.50,
    unit: '1kg',
  ),
];
