import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/games_repository.dart';
import '../utils/error_messages.dart';
import 'games_event.dart';
import 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final GamesRepository _repository;

  GamesBloc(this._repository) : super(GamesLoadInProgress()) {
    on<GamesLoadRequested>(_onLoadRequested);
    on<GameLikeToggled>(_onLikeToggled);
    on<GamesFilterToggled>(_onFilterToggled);
    on<GameAdded>(_onGameAdded);
    on<GameUpdated>(_onGameUpdated);
    on<GameDeleted>(_onGameDeleted);
  }

  Future<void> _onLoadRequested(
    GamesLoadRequested event,
    Emitter<GamesState> emit,
  ) async {
    emit(GamesLoadInProgress());

    if (!await _repository.isOnline()) {
      emit(
        GamesLoadFailure('Не удалось загрузить каталог.\n$noInternetMessage'),
      );
      return;
    }

    final Set<String> likedIds;
    try {
      likedIds = await _repository.fetchLikedIds();
    } catch (e) {
      emit(
        GamesLoadFailure('Не удалось загрузить каталог.\n${errorMessage(e)}'),
      );
      return;
    }
    final nickname = await _repository.fetchNickname();

    await emit.forEach(
      _repository.watchGames(),
      onData: (games) {
        final s = state;
        return s is GamesLoadSuccess
            ? s.copyWith(games: games)
            : GamesLoadSuccess(
                games: games,
                likedIds: likedIds,
                nickname: nickname,
              );
      },
      onError: (error, stackTrace) => GamesLoadFailure(
        'Не удалось загрузить каталог.\n${errorMessage(error)}',
      ),
    );
  }

  Future<void> _onLikeToggled(
    GameLikeToggled event,
    Emitter<GamesState> emit,
  ) async {
    final s = state;
    if (s is! GamesLoadSuccess) return;

    final wasLiked = s.likedIds.contains(event.gameId);

    final ids = {...s.likedIds};
    if (wasLiked) {
      ids.remove(event.gameId);
    } else {
      ids.add(event.gameId);
    }

    emit(s.copyWith(likedIds: ids));

    try {
      await _repository.toggleLike(event.gameId, wasLiked);
    } catch (e) {
      final current = state;
      if (current is GamesLoadSuccess) {
        final rollback = {...current.likedIds};
        if (wasLiked) {
          rollback.add(event.gameId);
        } else {
          rollback.remove(event.gameId);
        }
        emit(
          current.copyWith(
            likedIds: rollback,
            notice: UserNotice(
              'Не удалось изменить избранное. ${errorMessage(e)}',
            ),
          ),
        );
      }
    }
  }

  void _onFilterToggled(GamesFilterToggled event, Emitter<GamesState> emit) {
    final s = state;
    if (s is GamesLoadSuccess) {
      emit(s.copyWith(onlyFavorites: !s.onlyFavorites));
    }
  }

  Future<void> _onGameAdded(GameAdded event, Emitter<GamesState> emit) async {
    try {
      await _repository.addGame(event.game);
    } catch (e) {
      final s = state;
      if (s is GamesLoadSuccess) {
        emit(
          s.copyWith(
            notice: UserNotice('Не удалось добавить игру. ${errorMessage(e)}'),
          ),
        );
      }
    }
  }

  Future<void> _onGameUpdated(
    GameUpdated event,
    Emitter<GamesState> emit,
  ) async {
    try {
      await _repository.updateGame(event.game);
    } catch (e) {
      final s = state;
      if (s is GamesLoadSuccess) {
        emit(
          s.copyWith(
            notice: UserNotice(
              'Не удалось сохранить изменения. ${errorMessage(e)}',
            ),
          ),
        );
      }
    }
  }

  Future<void> _onGameDeleted(
    GameDeleted event,
    Emitter<GamesState> emit,
  ) async {
    try {
      await _repository.deleteGame(event.gameId);
      final s = state;
      if (s is GamesLoadSuccess && s.likedIds.contains(event.gameId)) {
        emit(s.copyWith(likedIds: {...s.likedIds}..remove(event.gameId)));
      }
    } catch (e) {
      final s = state;
      if (s is GamesLoadSuccess) {
        emit(
          s.copyWith(
            notice: UserNotice('Не удалось удалить игру. ${errorMessage(e)}'),
          ),
        );
      }
    }
  }
}
