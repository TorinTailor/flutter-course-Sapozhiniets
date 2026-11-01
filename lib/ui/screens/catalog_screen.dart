import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/games_bloc.dart';
import '../../bloc/games_event.dart';
import '../../bloc/games_state.dart';
import '../../domain/entities/game.dart';
import '../widgets/game_card.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:firebase_core/firebase_core.dart'; TODO 1: Это задел на будущий экран профиля пока пусть будет тут
//Text(FirebaseAuth.instance.currentUser?.email ?? '-')
//Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfilScreen()));

final db = FirebaseFirestore.instance;

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {

  final TextEditingController _titleController = TextEditingController();

  bool _isSubmitting = false;
  bool _showForm = false;
  String? _titleError;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _submitGame() async {
    final title = _titleController.text.trim();

    if (title.isEmpty) {
      setState(() => _titleError = 'Введите название игры');
      return;
    }

    setState(() {
      _titleError = null;
      _isSubmitting = true;
    });

    final game = Game(
      id: '',
      title: title,
      subtitle: 'Добавлено пользователем. В состоянии модерации.',
      categories: {GameCategory.empty},
      imageAsset: 'assets/empty.png',
      accentColor: '000000',
    );

    try {
      await FirebaseFirestore.instance.collection('games').add(game.toJson());

      if (!mounted) return;

      setState(() {
        _titleController.clear();
        _showForm = false;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Не удалось добавить игру: $e')));
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF1DF),
      appBar: AppBar(
        toolbarHeight: 70,
        title: BlocBuilder<GamesBloc, GamesState>(
          builder: (context, state) {
            final nickname = state is GamesLoadSuccess ? state.nickname : null;
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
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 20),
            tooltip: _showForm ? 'Скрыть форму' : 'Добавить игру',
            icon: Icon(_showForm ? Icons.close : Icons.add),
            onPressed: _isSubmitting
                ? null
                : () => setState(() => _showForm = !_showForm),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_showForm) _buildForm(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  Flexible(
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
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 12, 15, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: _titleController,
                  enabled: !_isSubmitting,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _isSubmitting ? null : _submitGame(),
                  decoration: InputDecoration(
                    labelText: 'Название',
                    errorText: _titleError,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitGame,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Отправить'),
              ),
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
                Text(state.message),
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

        final s = state as GamesLoadSuccess;
        final games = s.visibleGames;

        if (games.isEmpty) {
          return Center(
            child: Text(
              s.onlyFavorites ? 'В избранном пока пусто' : 'Ничего не нашлось',
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.only(
            top: 5,
            left: 15,
            right: 15,
            bottom: 15,
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
                onLikeTap: () =>
                    context.read<GamesBloc>().add(GameLikeToggled(game.id)),
              ),
            );
          },
        );
      },
    );
  }
}
