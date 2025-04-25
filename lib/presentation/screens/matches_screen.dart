import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:tennis/data/models/player.dart';
import 'package:tennis/data/models/match.dart';
import '../providers/match_provider.dart';
import '../providers/player_provider.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matchs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Générer un match',
            onPressed: () async {
              await Provider.of<MatchProvider>(
                context,
                listen: false,
              ).generateRandomMatch();
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo.shade50, Colors.white],
          ),
        ),
        child: Consumer2<MatchProvider, PlayerProvider>(
          builder: (context, matchProvider, playerProvider, _) {
            if (matchProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (matchProvider.error.isNotEmpty) {
              return Center(child: Text(matchProvider.error));
            }

            return RefreshIndicator(
              onRefresh: () async {
                await matchProvider.fetchMatches();
                await playerProvider.fetchPlayers();
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: matchProvider.matches.length,
                separatorBuilder:
                    (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final match = matchProvider.matches[index];
                  final loser = playerProvider.players.firstWhere(
                    (p) => p.id == match.loserId,
                    orElse:
                        () => Player(
                          id: '',
                          name: 'Inconnu',
                          age: 0,
                          photoUrl: 'https://via.placeholder.com/150',
                        ),
                  );

                  return _MatchCard(match: match, loser: loser);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _MatchCard extends StatelessWidget {
  final Match match;
  final Player loser;

  const _MatchCard({required this.match, required this.loser});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _PlayerTile(player: match.player1, score: match.player1Score),
                const Text(
                  'VS',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                _PlayerTile(player: match.player2, score: match.player2Score),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300),
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Center(
                child: Text(
                  '${match.player1Score} - ${match.player2Score}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vainqueur: ${match.winner.name}',
                      style: TextStyle(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Perdant: ${loser.name}',
                      style: TextStyle(color: Colors.red.shade800),
                    ),
                  ],
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(match.datePlayed),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayerTile extends StatelessWidget {
  final Player player;
  final int score;

  const _PlayerTile({required this.player, required this.score});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(player.photoUrl),
        ),
        const SizedBox(height: 8),
        Text(player.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(score.toString(), style: const TextStyle(fontSize: 18)),
      ],
    );
  }
}
