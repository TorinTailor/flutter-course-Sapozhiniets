import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/games_bloc.dart';
import 'bloc/games_event.dart';
import 'data/auth_repository.dart';
import 'data/games_repository.dart';
import 'ui/screens/catalog_screen.dart';
import 'ui/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _authRepository = AuthRepository();
  late final Stream<bool> _signedIn = _authRepository.signedInChanges();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<bool>(
          stream: _signedIn,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (snapshot.data != true) {
              return const LoginScreen();
            }
            return BlocProvider(
              create: (_) =>
                  GamesBloc(GamesRepository())..add(GamesLoadRequested()),
              child: const CatalogScreen(),
            );
          },
        ),
      ),
    );
  }
}