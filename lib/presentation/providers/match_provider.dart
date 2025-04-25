import 'package:flutter/foundation.dart';
import '../../data/models/match.dart';
import '../../data/datasources/api_service.dart';
import '../../domain/usecases/generate_random_match.dart';

class MatchProvider with ChangeNotifier {
  final ApiService apiService;
  List<Match> _matches = [];
  bool _isLoading = false;
  String _error = '';

  MatchProvider(this.apiService) {
    fetchMatches();
  }

  List<Match> get matches => _matches;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchMatches() async {
    _isLoading = true;
    notifyListeners();

    try {
      _matches = await apiService.fetchMatches();
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> generateRandomMatch() async {
    _isLoading = true;
    notifyListeners();

    try {
      await GenerateRandomMatch(apiService).execute();
      await fetchMatches();
      _error = '';
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
