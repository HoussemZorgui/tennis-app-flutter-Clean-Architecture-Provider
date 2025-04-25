import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tennis/data/models/player.dart';

import '../providers/player_provider.dart';
import 'stats_screen.dart';

class PlayersScreen extends StatefulWidget {
  const PlayersScreen({super.key});

  @override
  State<PlayersScreen> createState() => _PlayersScreenState();
}

class _PlayersScreenState extends State<PlayersScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _photoUrlController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _photoUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Joueurs')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo.shade50, Colors.white],
          ),
        ),
        child: Consumer<PlayerProvider>(
          builder: (context, playerProvider, _) {
            return Column(
              children: [
                _buildAddPlayerForm(context, playerProvider),
                Expanded(child: _buildPlayersList(playerProvider)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAddPlayerForm(
    BuildContext context,
    PlayerProvider playerProvider,
  ) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(
                  labelText: 'Âge',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un âge';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Âge invalide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _photoUrlController,
                decoration: const InputDecoration(
                  labelText: 'Photo URL (optionnel)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade800,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final player = Player(
                      id: '',
                      name: _nameController.text,
                      age: int.parse(_ageController.text),
                      photoUrl:
                          _photoUrlController.text.isEmpty
                              ? 'https://via.placeholder.com/150'
                              : _photoUrlController.text,
                    );
                    await playerProvider.addPlayer(player);
                    _nameController.clear();
                    _ageController.clear();
                    _photoUrlController.clear();
                  }
                },
                child: const Text('Ajouter Joueur'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayersList(PlayerProvider playerProvider) {
    if (playerProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (playerProvider.error.isNotEmpty) {
      return Center(child: Text(playerProvider.error));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: playerProvider.players.length,
      itemBuilder: (context, index) {
        final player = playerProvider.players[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          elevation: 1,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(player.photoUrl),
            ),
            title: Text(player.name),
            subtitle: Text('Âge: ${player.age}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.leaderboard),
                  color: Colors.indigo,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StatsScreen(playerId: player.id),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () async {
                    await playerProvider.deletePlayer(player.id);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
