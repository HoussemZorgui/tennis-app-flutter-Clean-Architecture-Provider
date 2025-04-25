import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/datasources/api_service.dart';
import '../../domain/usecases/get_stats.dart';

class StatsScreen extends StatelessWidget {
  final String playerId;

  const StatsScreen({super.key, required this.playerId});

  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context, listen: false);
    final futureStats = GetPlayerStats(apiService).execute(playerId);

    return Scaffold(
      appBar: AppBar(title: const Text('Player Stats')),
      body: FutureBuilder<Map<String, dynamic>>(
        future: futureStats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No stats available'));
          }

          final stats = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      stats['photoUrl'] ?? 'https://via.placeholder.com/150',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    stats['name'],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Age: ${stats['age']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                const Divider(height: 40),
                Text(
                  'Matches Played: ${stats['matchesPlayed']}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Wins: ${stats['wins']}',
                  style: const TextStyle(fontSize: 18, color: Colors.green),
                ),
                const SizedBox(height: 10),
                Text(
                  'Losses: ${stats['losses']}',
                  style: const TextStyle(fontSize: 18, color: Colors.red),
                ),
                const SizedBox(height: 10),
                Text(
                  'Win Percentage: ${stats['winPercentage']}%',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
