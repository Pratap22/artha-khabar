class Category {
  final int id;
  final String name;
  final String slug;

  Category({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['Category ID'] ?? json['category_id'] ?? 0,
      name: json['Category Name'] ?? json['category_name'] ?? '',
      slug: json['Category Slug'] ?? json['category_slug'] ?? '',
    );
  }
}
