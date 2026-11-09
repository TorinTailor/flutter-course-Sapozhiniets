import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/games_bloc.dart';
import '../../bloc/games_event.dart';
import '../../bloc/games_state.dart';
import '../../domain/entities/game.dart';
import '../../utils/connectivity.dart';
import '../../utils/error_messages.dart';
import '../widgets/category_chip.dart';
import '../widgets/game_category_style.dart';
import 'add_game_screen.dart';

class GameDetailsScreen extends StatelessWidget {
  final Game game;

  const GameDetailsScreen({super.key, required this.game});

  Game _currentGame(GamesState state) {
    if (state is GamesLoadSuccess) {
      for (final g in state.games) {
        if (g.id == game.id) return g;
      }
    }
    return game;
  }

  Future<bool> _ensureOnline(BuildContext context) async {
    if (await hasInternet()) return true;
    if (!context.mounted) return false;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(noInternetActionMessage)),
    );
    return false;
  }

  Future<void> _toggleLike(BuildContext context, String gameId) async {
    final bloc = context.read<GamesBloc>();
    if (!await _ensureOnline(context)) return;
    bloc.add(GameLikeToggled(gameId));
  }

  Future<void> _edit(BuildContext context, Game current) async {
    final bloc = context.read<GamesBloc>();
    final updated = await Navigator.push<Game>(
      context,
      MaterialPageRoute(builder: (_) => AddGameScreen(game: current)),
    );
    if (updated == null) return;
    bloc.add(GameUpdated(updated));
  }

  Future<void> _confirmDelete(BuildContext context, Game current) async {
    final bloc = context.read<GamesBloc>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Удалить игру?'),
        content: Text(
          '«${current.title}» исчезнет из библиотеки. '
          'Это действие нельзя отменить.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    if (!await _ensureOnline(context) || !context.mounted) return;

    bloc.add(GameDeleted(current.id));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GamesBloc, GamesState>(
      builder: (context, state) {
        final current = _currentGame(state);
        final isLiked =
            state is GamesLoadSuccess && state.likedIds.contains(current.id);

        return Scaffold(
          backgroundColor: const Color(0xFFFBF1DF),
          appBar: AppBar(
            title: const Text('Детали'),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: 'Редактировать',
                onPressed: () => _edit(context, current),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Удалить',
                onPressed: () => _confirmDelete(context, current),
              ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Center(
                  child: Container(
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 4,
                        color: colorFromHex(current.accentColor),
                      ),
                    ),
                    child: Image.asset(current.imageAsset),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        current.title,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _toggleLike(context, current.id),
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked
                            ? const Color(0xFFFF0000)
                            : const Color(0xFF5F5F5F),
                      ),
                    ),
                  ],
                ),
                Text(current.subtitle, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    for (final category in current.categories)
                      CategoryChip(category: category),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Описание',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  current.description.isEmpty
                      ? 'Описание пока не добавлено'
                      : current.description,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}