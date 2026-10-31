import '../domain/entities/game.dart';

sealed class GamesState {}

class GamesLoadInProgress extends GamesState {}

class GamesLoadSuccess extends GamesState {
  final List<Game> games;
  GamesLoadSuccess(this.games);
}

class GamesLoadFailure extends GamesState {
  final String message;
  GamesLoadFailure(this.message);
}
