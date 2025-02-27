class Product {
  final String id;
  final String name;
  final double price;
  final String image;
  final String description;
  final String weight; 
  final String quality;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.weight,
    required this.quality,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      image: json['image'],
      description: json['description'],
        quality: json['quality'].toDouble(),
weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'image': image,
        'description': description,
      };
}