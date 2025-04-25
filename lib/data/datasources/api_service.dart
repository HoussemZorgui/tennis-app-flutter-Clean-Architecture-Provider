import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/player.dart';
import '../models/match.dart';

class ApiService {
  final String baseUrl =
      'http://10.0.2.2:3000/api'; // Use 10.0.2.2 for Android emulator

  Future<List<Player>> fetchPlayers() async {
    final response = await http.get(Uri.parse('$baseUrl/players'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((player) => Player.fromJson(player)).toList();
    } else {
      throw Exception('Failed to load players');
    }
  }

  Future<void> addPlayer(Player player) async {
    final response = await http.post(
      Uri.parse('$baseUrl/players'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(player.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add player');
    }
  }

  Future<void> deletePlayer(String playerId) async {
    final response = await http.delete(Uri.parse('$baseUrl/players/$playerId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete player');
    }
  }

  Future<Map<String, dynamic>> getPlayerStats(String playerId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/players/$playerId/stats'),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load player stats');
    }
  }

  Future<List<Match>> fetchMatches() async {
    final response = await http.get(Uri.parse('$baseUrl/matches'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((match) => Match.fromJson(match)).toList();
    } else {
      throw Exception('Failed to load matches');
    }
  }

  Future<Match> generateRandomMatch() async {
    final response = await http.post(Uri.parse('$baseUrl/matches/generate'));
    if (response.statusCode == 201) {
      return Match.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to generate match');
    }
  }
}
