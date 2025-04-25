import '../../data/models/match.dart';
import '../../data/datasources/api_service.dart';

class GenerateRandomMatch {
  final ApiService apiService;

  GenerateRandomMatch(this.apiService);

  Future<Match> execute() async {
    return await apiService.generateRandomMatch();
  }
}
