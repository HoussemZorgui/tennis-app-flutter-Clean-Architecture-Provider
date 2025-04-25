class Player {
  final String id;
  final String name;
  final int age;
  final String photoUrl;
  final int wins;
  final int losses;
  final int matchesPlayed;

  Player({
    required this.id,
    required this.name,
    required this.age,
    required this.photoUrl,
    this.wins = 0,
    this.losses = 0,
    this.matchesPlayed = 0,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      id: json['_id']?.toString() ?? '', // Gestion du null
      name: json['name']?.toString() ?? 'Unknown', // Conversion sécurisée
      age: (json['age'] as int?) ?? 0,
      photoUrl:
          json['photoUrl']?.toString() ?? 'https://via.placeholder.com/150',
      wins: (json['wins'] as int?) ?? 0,
      losses: (json['losses'] as int?) ?? 0,
      matchesPlayed: (json['matchesPlayed'] as int?) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'age': age, 'photoUrl': photoUrl};
  }
}
