class Pokemon {
  final String name;
  final String image;
  final int height;
  final int weight;

  Pokemon({
    required this.name,
    required this.image,
    required this.height,
    required this.weight,
  });

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      name: json['name'],
      image: json['sprites']['front_default'],
      height: json['height'],
      weight: json['weight'],
    );
  }
}