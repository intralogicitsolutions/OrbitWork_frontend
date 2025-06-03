class CategoryModel {
  final String id;
  final String title;
  final List<String> subcategories;
  final bool isExpanded;

  CategoryModel({
    required this.id,
    required this.title,
    required this.subcategories,
    this.isExpanded = false,
  });

  CategoryModel copyWith({
    String? id,
    String? title,
    List<String>? subcategories,
    bool? isExpanded,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subcategories: subcategories ?? this.subcategories,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }
}