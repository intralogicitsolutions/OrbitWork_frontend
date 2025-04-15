class StringUtils {
  static String getInitials(String name) {
    if (name.trim().isEmpty) return "?";
    List<String> nameParts = name.split(' ');
    return nameParts
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();
  }
}
