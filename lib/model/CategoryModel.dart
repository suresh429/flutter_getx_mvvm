class Category {
  final String title;
  final String subtitle;
  final String image;

  // Constructor
  Category({
    required this.title,
    required this.subtitle,
    required this.image,
  });

  // Factory constructor for creating a Category instance from a Map
  factory Category.fromMap(Map<String, String> map) {
    return Category(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      image: map['image'] ?? '',
    );
  }

  // Method to convert a Category instance into a Map
  Map<String, String> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'image': image,
    };
  }
}
