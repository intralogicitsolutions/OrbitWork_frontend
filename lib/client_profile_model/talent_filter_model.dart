class Specialty {
  final String name;

  Specialty({required this.name});
}

class Subcategory {
  final String name;
  final List<Specialty> specialties;

  Subcategory({required this.name, required this.specialties});
}

class Category {
  final String name;
  final List<Subcategory> subcategories;

  Category({required this.name, required this.subcategories});
}