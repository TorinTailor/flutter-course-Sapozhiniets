import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/games_bloc.dart';
import '../../bloc/games_event.dart';
import '../../bloc/games_state.dart';
import '../../domain/entities/game.dart';
import '../../utils/connectivity.dart';
import '../../utils/error_messages.dart';
import '../widgets/error_banner.dart';
import '../widgets/game_card.dart';
import 'add_game_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';

//import 'package:firebase_core/firebase_core.dart'; TODO 1: Это задел на будущий экран профиля пока пусть будет тут
//Text(FirebaseAuth.instance.currentUser?.email ?? '-')
//Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfilScreen()));

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  bool _showOfflineBanner = false;
  Timer? _bannerTimer;

  @override
  void dispose() {
    _bannerTimer?.cancel();
    super.dispose();
  }

  void _showNoInternet() {
    if (!mounted) return;
    _bannerTimer?.cancel();
    setState(() => _showOfflineBanner = true);
    _bannerTimer = Timer(const Duration(seconds: 4), () {
      if (mounted) setState(() => _showOfflineBanner = false);
    });
  }

  Future<void> _onLikeTap(String gameId) async {
    final bloc = context.read<GamesBloc>();
    if (!await hasInternet()) {
      _showNoInternet();
      return;
    }
    if (!mounted) return;
    bloc.add(GameLikeToggled(gameId));
  }

  Future<void> _openAddGame() async {
    final game = await Navigator.push<Game>(
      context,
      MaterialPageRoute(builder: (_) => const AddGameScreen()),
    );
    if (game == null || !mounted) return;
    context.read<GamesBloc>().add(GameAdded(game));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GamesBloc, GamesState>(
      listenWhen: (previous, current) =>
          current is GamesLoadSuccess &&
          current.notice != null &&
          (previous is! GamesLoadSuccess || previous.notice != current.notice),
      listener: (context, state) {
        final notice = (state as GamesLoadSuccess).notice;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(notice!.message)));
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFBF1DF),
        appBar: AppBar(
          toolbarHeight: 70,
          title: BlocBuilder<GamesBloc, GamesState>(
            builder: (context, state) {
              final nickname = state is GamesLoadSuccess
                  ? state.nickname
                  : null;
              final visibleCount = state is GamesLoadSuccess
                  ? state.visibleGames.length
                  : 0;
              final favoritesCount = state is GamesLoadSuccess
                  ? state.likedIds.length
                  : 0;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nickname != null && nickname.isNotEmpty
                        ? 'Библиотека игр ($nickname)'
                        : 'Библиотека игр',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'В библиотеке: $visibleCount · В избранном: $favoritesCount',
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              );
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: BlocBuilder<GamesBloc, GamesState>(
          builder: (context, state) {
            if (state is! GamesLoadSuccess) return const SizedBox.shrink();

            return FloatingActionButton(
              onPressed: _openAddGame,
              tooltip: 'Добавить игру',
              backgroundColor: const Color(0xFFFFB1B1),
              foregroundColor: const Color(0xFF5A0000),
              shape: const CircleBorder(),
              child: const Icon(Icons.add),
            );
          },
        ),
        body: SafeArea(
          child: Column(
            children: [
              if (_showOfflineBanner)
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 12, 15, 0),
                  child: ErrorBanner(noInternetActionMessage),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    Flexible(
                      // Нажатие — read + add. Перерисовка — BlocBuilder.
                      child: BlocBuilder<GamesBloc, GamesState>(
                        builder: (context, state) {
                          final onlyFavorites =
                              state is GamesLoadSuccess && state.onlyFavorites;

                          return FilterChip(
                            showCheckmark: false,
                            avatar: onlyFavorites
                                ? const Icon(Icons.favorite, color: Colors.red)
                                : const Icon(Icons.favorite_border),
                            shape: const StadiumBorder(),
                            label: const Text('Только избранные'),
                            labelStyle: TextStyle(
                              color: onlyFavorites
                                  ? Colors.green
                                  : Colors.black87,
                            ),
                            selectedColor: const Color(0xFFB9CDBA),
                            side: BorderSide(
                              color: onlyFavorites
                                  ? const Color(0xFFB9CDBA)
                                  : Colors.grey,
                            ),
                            selected: onlyFavorites,
                            onSelected: (_) => context.read<GamesBloc>().add(
                              GamesFilterToggled(),
                            ),
                          );
                        },
                      ),
                    ),

                    SizedBox(width: 5),

                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      child: Text('Выйти'),
                    ),
                  ],
                ),
              ),
              Expanded(child: _buildCatalog()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCatalog() {
    return BlocBuilder<GamesBloc, GamesState>(
      builder: (context, state) {
        if (state is GamesLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is GamesLoadFailure) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(state.message, textAlign: TextAlign.center),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () =>
                      context.read<GamesBloc>().add(GamesLoadRequested()),
                  child: const Text('Обновить'),
                ),
              ],
            ),
          );
        }

        // Загрузку и ошибку обработали выше, остаётся успех.
        final s = state as GamesLoadSuccess;
        final games = s.visibleGames; // уже отфильтрованный список

        if (games.isEmpty) {
          return Center(
            child: Text(
              s.onlyFavorites ? 'В избранном пока пусто' : 'Ничего не нашлось',
            ),
          );
        }

        return ListView.builder(
          // Снизу запас, чтобы кнопка «+» не закрывала последнюю карточку.
          padding: const EdgeInsets.only(
            top: 5,
            left: 15,
            right: 15,
            bottom: 88,
          ),
          itemCount: games.length,
          itemBuilder: (context, index) {
            final game = games[index];
            final isLiked = s.likedIds.contains(game.id);

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GameCard(
                game: game,
                isLiked: isLiked,
                onLikeTap: () => _onLikeTap(game.id),
              ),
            );
          },
        );
      },
    );
  }
}
