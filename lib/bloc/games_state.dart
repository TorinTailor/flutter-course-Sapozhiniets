import '../domain/entities/game.dart';

sealed class GamesState {}

class GamesLoadInProgress extends GamesState {}

class GamesLoadSuccess extends GamesState {
  final List<Game> games;
  final Set<String> likedIds;
  final bool onlyFavorites;
  final String? nickname;

  GamesLoadSuccess({
    required this.games,
    this.likedIds = const {},
    this.onlyFavorites = false,
    this.nickname,
  });

  GamesLoadSuccess copyWith({
    List<Game>? games,
    Set<String>? likedIds,
    bool? onlyFavorites,
    String? nickname,
  }) {
    return GamesLoadSuccess(
      games: games ?? this.games,
      likedIds: likedIds ?? this.likedIds,
      onlyFavorites: onlyFavorites ?? this.onlyFavorites,
      nickname: nickname ?? this.nickname,
    );
  }

  List<Game> get visibleGames => onlyFavorites
      ? games.where((game) => likedIds.contains(game.id)).toList()
      : games;
}

class GamesLoadFailure extends GamesState {
  final String message;
  GamesLoadFailure(this.message);
}
