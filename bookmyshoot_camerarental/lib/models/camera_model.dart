class Camera {
  final String id;
  final String name;
  final String description;
  final double price;
  final double rating;
  final String imageUrl;  // This will point to your asset paths
  final List<String> features;

  const Camera({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    required this.imageUrl,
    required this.features,
  });

  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      rating: json['rating'].toDouble(),
      imageUrl: 'assets/${json['imageUrl']}', // Prepend 'assets/' to JSON value
      features: List<String>.from(json['features']),
    );
  }
}