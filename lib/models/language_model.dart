class Language{
  String name;
  String? description;
  String? proficiency;
  bool isDefault;

  Language({
    required this.name,
     this.description,
     this.proficiency,
    this.isDefault = false
});
}