import '../domain/entities/game.dart';

sealed class GamesState {}

class GamesLoadInProgress extends GamesState {}

class UserNotice {
  final String message;
  UserNotice(this.message);
}

class GamesLoadSuccess extends GamesState {
  final List<Game> games;
  final Set<String> likedIds;
  final bool onlyFavorites;
  final String? nickname;
  final UserNotice? notice;

  GamesLoadSuccess({
    required this.games,
    this.likedIds = const {},
    this.onlyFavorites = false,
    this.nickname,
    this.notice,
  });

  GamesLoadSuccess copyWith({
    List<Game>? games,
    Set<String>? likedIds,
    bool? onlyFavorites,
    String? nickname,
    UserNotice? notice,
  }) {
    return GamesLoadSuccess(
      games: games ?? this.games,
      likedIds: likedIds ?? this.likedIds,
      onlyFavorites: onlyFavorites ?? this.onlyFavorites,
      nickname: nickname ?? this.nickname,
      notice: notice ?? this.notice,
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
