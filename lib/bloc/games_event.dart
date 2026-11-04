import '../domain/entities/game.dart';

sealed class GamesEvent {}

class GamesLoadRequested extends GamesEvent {}

class GameLikeToggled extends GamesEvent {
  final String gameId;
  GameLikeToggled(this.gameId);
}

class GamesFilterToggled extends GamesEvent {}

class GameAdded extends GamesEvent {
  final Game game;
  GameAdded(this.game);
}
