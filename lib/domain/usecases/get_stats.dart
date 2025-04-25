import '../../data/datasources/api_service.dart';

class GetPlayerStats {
  final ApiService apiService;

  GetPlayerStats(this.apiService);

  Future<Map<String, dynamic>> execute(String playerId) async {
    return await apiService.getPlayerStats(playerId);
  }
}
