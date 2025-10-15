class Ingredient {
  final String name;
  final bool safe;
  final String description;

  Ingredient({
    required this.name,
    required this.safe,
    required this.description,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] as String,
      safe: json['safe'] as bool,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'safe': safe,
      'description': description,
    };
  }
}