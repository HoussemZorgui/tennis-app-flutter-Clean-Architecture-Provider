import '../../data/models/player.dart';
import '../../data/datasources/api_service.dart';

class AddPlayer {
  final ApiService apiService;

  AddPlayer(this.apiService);

  Future<void> execute(Player player) async {
    await apiService.addPlayer(player);
  }
}
