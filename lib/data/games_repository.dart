import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/entities/game.dart';
import '../utils/connectivity.dart';

class GamesRepository {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<bool> isOnline() => hasInternet();

  Stream<List<Game>> watchGames() async* {
    await for (final snapshot in _db.collection('games').snapshots()) {
      if (snapshot.metadata.isFromCache && snapshot.docs.isEmpty) {
        throw FirebaseException(plugin: 'cloud_firestore', code: 'unavailable');
      }
      yield snapshot.docs.map(Game.fromFirestore).toList();
    }
  }

  Future<void> addGame(Game game) => _db.collection('games').add({
    ...game.toJson(),
    'userId': _auth.currentUser!.uid,
    'createdAt': FieldValue.serverTimestamp(),
  });

  CollectionReference<Map<String, dynamic>> get _favorites => _db
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('favorites');

  Future<String?> fetchNickname() async {
    try {
      final doc = await _db
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .get();
      return doc.data()?['nickname'] as String?;
    } catch (_) {
      return null;
    }
  }

  Future<Set<String>> fetchLikedIds() async {
    final snapshot = await _favorites.get();
    return snapshot.docs.map((doc) => doc.id).toSet();
  }

  Future<void> toggleLike(String gameId, bool wasLiked) async {
    if (wasLiked) {
      await _favorites.doc(gameId).delete();
    } else {
      await _favorites.doc(gameId).set({'liked': true});
    }
  }
}
