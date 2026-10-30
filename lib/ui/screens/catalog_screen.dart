import 'package:flutter/material.dart';

import '../../domain/entities/game.dart';
import '../widgets/game_card.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:firebase_core/firebase_core.dart'; TODO 1: Это задел на будущий экран профиля пока пусть будет тут
//Text(FirebaseAuth.instance.currentUser?.email ?? '-')
//Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfilScreen()));

final db = FirebaseFirestore.instance;

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  // final Set<String> _likedIds = {};
  final TextEditingController _titleController = TextEditingController();
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _itemsStream;
  late final Stream<QuerySnapshot<Map<String, dynamic>>> _favoritesStream;

  late int count;
  bool _isSubmitting = false;
  bool _onlyFavorites = false;
  bool _showForm = false;
  String? _titleError;
  String? _nickname;
  int _visibleGamesCount = 0;
  int _favoritesCount = 0;

  @override
  void initState() {
    super.initState();

    _itemsStream = FirebaseFirestore.instance.collection('games').snapshots();

    final uid = FirebaseAuth.instance.currentUser!.uid;

    _favoritesStream = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .snapshots();

    _loadUserNickname(uid);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _submitGame() async {
    final title = _titleController.text.trim();

    if (title.isEmpty) {
      setState(() => _titleError = 'Введите название игры');
      return;
    }

    setState(() {
      _titleError = null;
      _isSubmitting = true;
    });

    final game = Game(
      id: '',
      title: title,
      subtitle: 'Добавлено пользователем. В состоянии модерации.',
      categories: {GameCategory.empty},
      imageAsset: 'assets/empty.png',
      accentColor: '000000',
    );

    try {
      await FirebaseFirestore.instance.collection('games').add(game.toJson());

      if (!mounted) return;

      setState(() {
        _titleController.clear();
        _showForm = false;
      });
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Не удалось добавить игру: $e')));
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  Future<void> _loadUserNickname(String uid) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists && mounted) {
        setState(() {
          _nickname = doc.data()?['nickname'] as String?;
        });
      }
    } catch (e) {
      debugPrint('Ошибка при загрузке никнейма: $e');
    }
  }

  Future<void> _toggleLike(String itemId, bool isLiked) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final fav = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favorites')
        .doc(itemId);

    try {
      if (isLiked) {
        await fav.delete();
      } else {
        await fav.set({'liked': true});
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось изменить избранное: $e')),
      );
    }
  }

  Future<int?> gamesCount() async {
    final collectionRef = FirebaseFirestore.instance.collection('games');
    final snapshot = await collectionRef.count().get();

    return snapshot.count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF1DF),
      appBar: AppBar(
        toolbarHeight: 70,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _nickname != null && _nickname!.isNotEmpty
                  ? 'Библиотека игр ($_nickname)'
                  : 'Библиотека игр',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'В библиотеке: $_visibleGamesCount · В избранном: $_favoritesCount',
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 20),
            tooltip: _showForm ? 'Скрыть форму' : 'Добавить игру',
            icon: Icon(_showForm ? Icons.close : Icons.add),
            onPressed: _isSubmitting
                ? null
                : () => setState(() => _showForm = !_showForm),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_showForm) _buildForm(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                children: [
                  Flexible(
                    child: FilterChip(
                      showCheckmark: false,
                      avatar: _onlyFavorites
                          ? const Icon(Icons.favorite, color: Colors.red)
                          : const Icon(Icons.favorite_border),
                      shape: const StadiumBorder(),
                      label: const Text('Только избранные'),
                      labelStyle: TextStyle(
                        color: _onlyFavorites ? Colors.green : Colors.black87,
                      ),
                      selectedColor: const Color(0xFFB9CDBA),
                      side: BorderSide(
                        color: _onlyFavorites
                            ? const Color(0xFFB9CDBA)
                            : Colors.grey,
                      ),
                      selected: _onlyFavorites,
                      onSelected: (value) =>
                          setState(() => _onlyFavorites = value),
                    ),
                  ),

                  SizedBox(width: 5),

                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                    },
                    child: Text('Выйти'),
                  ),
                ],
              ),
            ),
            Expanded(child: _buildCatalog()),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 12, 15, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: _titleController,
                  enabled: !_isSubmitting,
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _isSubmitting ? null : _submitGame(),
                  decoration: InputDecoration(
                    labelText: 'Название',
                    errorText: _titleError,
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitGame,
                child: _isSubmitting
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Отправить'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCatalog() {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _itemsStream,
      builder: (context, itemsSnapshot) {
        if (itemsSnapshot.hasError) {
          return Center(
            child: Text('Ошибка загрузки каталога: ${itemsSnapshot.error}'),
          );
        }

        if (itemsSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final games = itemsSnapshot.data!.docs
            .map((doc) => Game.fromFirestore(doc))
            .toList();

        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _favoritesStream,
          builder: (context, favoritesSnapshot) {
            if (favoritesSnapshot.hasError) {
              return Center(
                child: Text(
                  'Ошибка загрузки избранного: '
                  '${favoritesSnapshot.error}',
                ),
              );
            }

            if (favoritesSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final likedIds = favoritesSnapshot.data!.docs
                .map((doc) => doc.id)
                .toSet();

            final visibleGames = _onlyFavorites
                ? games.where((game) => likedIds.contains(game.id)).toList()
                : games;

            if (_visibleGamesCount != visibleGames.length ||
                _favoritesCount != likedIds.length) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _visibleGamesCount = visibleGames.length;
                    _favoritesCount = likedIds.length;
                  });
                }
              });
            }

            if (visibleGames.isEmpty) {
              return const Center(child: Text('Ничего не нашлось'));
            }

            return ListView.builder(
              padding: const EdgeInsets.only(
                top: 5,
                left: 15,
                right: 15,
                bottom: 15,
              ),
              itemCount: visibleGames.length,
              itemBuilder: (context, index) {
                final game = visibleGames[index];
                final isLiked = likedIds.contains(game.id);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GameCard(
                    game: game,
                    isLiked: isLiked,
                    onLikeTap: () => _toggleLike(game.id, isLiked),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
