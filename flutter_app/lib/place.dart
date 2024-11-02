class Place {
  final String name;
  final String imageUrl;
  final String description;

  Place({
    required this.name,
    required this.imageUrl,
    required this.description,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
    );
  }
}
