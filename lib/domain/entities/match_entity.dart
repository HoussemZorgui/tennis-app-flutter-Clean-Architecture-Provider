import 'package:tennis/data/models/player.dart';

class Match {
  final String id;
  final Player player1;
  final Player player2;
  final Player winner;
  final String loserId; // Stocke seulement l'ID
  final int player1Score;
  final int player2Score;
  final DateTime datePlayed;

  Match({
    required this.id,
    required this.player1,
    required this.player2,
    required this.winner,
    required this.loserId,
    required this.player1Score,
    required this.player2Score,
    required this.datePlayed,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['_id'] as String? ?? '',
      player1: Player.fromJson(json['player1'] as Map<String, dynamic>? ?? {}),
      player2: Player.fromJson(json['player2'] as Map<String, dynamic>? ?? {}),
      winner: Player.fromJson((json['winner'] as Map<String, dynamic>?) ?? {}),
      loserId: json['loser'] as String? ?? '', // Stocke l'ID comme String
      player1Score: (json['player1Score'] as int?) ?? 0,
      player2Score: (json['player2Score'] as int?) ?? 0,
      datePlayed: DateTime.parse(
        json['datePlayed']?.toString() ?? DateTime.now().toString(),
      ),
    );
  }
}
