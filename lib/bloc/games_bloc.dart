import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/games_repository.dart';
import 'games_event.dart';
import 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final GamesRepository _repository;

  GamesBloc(this._repository) : super(GamesLoadInProgress()) {
    on<GamesLoadRequested>(_onLoadRequested);
    on<GameLikeToggled>(_onLikeToggled);
    on<GamesFilterToggled>(_onFilterToggled);
  }

  Future<void> _onLoadRequested(
    GamesLoadRequested event,
    Emitter<GamesState> emit,
  ) async {
    emit(GamesLoadInProgress());

    final Set<String> likedIds;
    try {
      likedIds = await _repository.fetchLikedIds();
    } catch (_) {
      emit(GamesLoadFailure('Не удалось загрузить каталог'));
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
              ); // первая загрузка
      },
      onError: (error, stackTrace) =>
          GamesLoadFailure('Не удалось загрузить каталог'),
    );
  }

  Future<void> _onLikeToggled(
    GameLikeToggled event,
    Emitter<GamesState> emit,
  ) async {
    final s = state;
    if (s is! GamesLoadSuccess) return;

    final wasLiked = s.likedIds.contains(event.gameId);

    final ids = {...s.likedIds}; // новый набор, старый не трогаем
    if (wasLiked) {
      ids.remove(event.gameId);
    } else {
      ids.add(event.gameId);
    }

    emit(s.copyWith(likedIds: ids));

    try {
      await _repository.toggleLike(event.gameId, wasLiked);
    } catch (_) {

      final current = state;
      if (current is GamesLoadSuccess) {
        final rollback = {...current.likedIds};
        if (wasLiked) {
          rollback.add(event.gameId);
        } else {
          rollback.remove(event.gameId);
        }
        emit(current.copyWith(likedIds: rollback));
      }
    }
  }

  void _onFilterToggled(GamesFilterToggled event, Emitter<GamesState> emit) {
    final s = state;
    if (s is GamesLoadSuccess) {
      emit(s.copyWith(onlyFavorites: !s.onlyFavorites));
    }
  }
}
