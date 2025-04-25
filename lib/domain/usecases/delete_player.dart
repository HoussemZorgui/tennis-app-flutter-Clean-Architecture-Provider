import '../../data/datasources/api_service.dart';

class DeletePlayer {
  final ApiService apiService;

  DeletePlayer(this.apiService);

  Future<void> execute(String playerId) async {
    await apiService.deletePlayer(playerId);
  }
}
