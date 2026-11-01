sealed class GamesEvent {}

class GamesLoadRequested extends GamesEvent {}

class GameLikeToggled extends GamesEvent {
  final String gameId;
  GameLikeToggled(this.gameId);
}

class GamesFilterToggled extends GamesEvent {}
