import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/entities/game.dart';
import 'games_event.dart';
import 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  GamesBloc() : super(GamesLoadInProgress()) {
    on<GamesLoadRequested>(_onLoadRequested);
  }

  Future<void> _onLoadRequested(
    GamesLoadRequested event,
    Emitter<GamesState> emit,
  ) async {
    emit(GamesLoadInProgress());
    await emit.forEach(
      FirebaseFirestore.instance.collection('games').snapshots(),
      onData: (snapshot) =>
          GamesLoadSuccess(snapshot.docs.map(Game.fromFirestore).toList()),
      onError: (error, stackTrace) =>
          GamesLoadFailure('Не удалось загрузить каталог'),
    );
  }
}
