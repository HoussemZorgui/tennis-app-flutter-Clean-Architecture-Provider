import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/datasources/api_service.dart';
import 'presentation/providers/player_provider.dart';
import 'presentation/providers/match_provider.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => ApiService()),
        ChangeNotifierProxyProvider<ApiService, PlayerProvider>(
          create: (context) => PlayerProvider(context.read<ApiService>()),
          update:
              (context, apiService, playerProvider) =>
                  playerProvider ?? PlayerProvider(apiService),
        ),
        ChangeNotifierProxyProvider<ApiService, MatchProvider>(
          create: (context) => MatchProvider(context.read<ApiService>()),
          update:
              (context, apiService, matchProvider) =>
                  matchProvider ?? MatchProvider(apiService),
        ),
      ],
      child: MaterialApp(
        title: 'Tennis Pro',
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
