import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/screens/login_screen.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/game.dart';
import '../widgets/game_card.dart';

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
//Text(FirebaseAuth.instance.currentUser?.email ?? '-')  TODO 1: Это задел на будущий экран профиля пока пусть будет тут


const baseUrl = 'https://6ad492ee48476c0785d91f20.mockapi.io';



class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final Set<String> _likedIds = {};
  final TextEditingController _titleController = TextEditingController();

  List<Game> _games = [];
  bool _onlyFavorites = false;
  bool _isLoading = true;
  bool _isSubmitting = false;
  bool _showForm = false;
  String? _loadError;
  String? _titleError;

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _loadGames() async {
    setState(() {
      _isLoading = true;
      _loadError = null;
    });

    try {
      final response = await http.get(Uri.parse('$baseUrl/games'));
      if (response.statusCode != 200) {
        throw Exception('Статус ${response.statusCode}');
      }

      final items = jsonDecode(response.body) as List<dynamic>;
      final games = items
          .map((item) => Game.fromJson(item as Map<String, dynamic>))
          .toList();

      if (!mounted) return;
      setState(() => _games = games);
    } catch (error) {
      if (!mounted) return;
      setState(() => _loadError = 'Не удалось загрузить каталог: $error');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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
      final response = await http.post(
        Uri.parse('$baseUrl/games'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(game.toJson()),
      );
      if (response.statusCode != 201) {
        throw Exception('Статус ${response.statusCode}');
      }

      final created = Game.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
      if (!mounted) return;
      setState(() {
        _games.insert(0, created);
        _titleController.clear();
        _showForm = false;
      });
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Не удалось добавить игру: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _toggleLike(String id) {
    setState(() {
      if (_likedIds.contains(id)) {
        _likedIds.remove(id);
      } else {
        _likedIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final visibleGames = _onlyFavorites
        ? _games.where((game) => _likedIds.contains(game.id)).toList()
        : _games;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF1DF),
      appBar: AppBar(
        toolbarHeight: 70,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Библиотека игр',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),
            Text(
              'В библиотеке игр: ${_games.length} · В избранном: ${_likedIds.length}',
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
                  Flexible(child: FilterChip(
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
                  ),),
                  IconButton(
                      tooltip: 'Обновить каталог',
                      icon: const Icon(Icons.refresh),
                      onPressed: _isLoading ? null : _loadGames,
                  ),
                  SizedBox(width: 5,),
                  ElevatedButton(onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    if (!context.mounted) return;
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                  }, child: Text('Выйти'))
                ],
              ),
            ),
            Expanded(child: _buildCatalog(visibleGames)),
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

  Widget _buildCatalog(List<Game> visibleGames) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_loadError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_loadError!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: _loadGames,
                icon: const Icon(Icons.refresh),
                label: const Text('Обновить'),
              ),
            ],
          ),
        ),
      );
    }

    if (visibleGames.isEmpty) {
      return const Center(child: Text('Ничего не нашлось'));
    }

    return RefreshIndicator(
      onRefresh: _loadGames,
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 15),
        itemCount: visibleGames.length,
        itemBuilder: (context, index) {
          final game = visibleGames[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GameCard(
              game: game,
              isLiked: _likedIds.contains(game.id),
              onLikeTap: () => _toggleLike(game.id),
            ),
          );
        },
      ),
    );
  }
}
