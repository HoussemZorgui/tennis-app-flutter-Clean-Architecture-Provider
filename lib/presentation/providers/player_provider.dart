import 'package:flutter/foundation.dart';
import '../../data/models/player.dart';
import '../../data/datasources/api_service.dart';
import '../../domain/usecases/add_player.dart';
import '../../domain/usecases/delete_player.dart';

class PlayerProvider with ChangeNotifier {
  final ApiService apiService;
  List<Player> _players = [];
  bool _isLoading = false;
  String _error = '';

  PlayerProvider(this.apiService) {
    fetchPlayers();
  }

  List<Player> get players => _players;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchPlayers() async {
    _isLoading = true;
    notifyListeners();

    try {
      _players = await apiService.fetchPlayers();
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPlayer(Player player) async {
    _isLoading = true;
    notifyListeners();

    try {
      await AddPlayer(apiService).execute(player);
      await fetchPlayers();
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deletePlayer(String playerId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await DeletePlayer(apiService).execute(playerId);
      await fetchPlayers();
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
